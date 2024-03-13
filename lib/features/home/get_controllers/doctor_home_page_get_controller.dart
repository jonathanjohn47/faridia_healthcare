import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/models/appointment_model.dart';
import 'package:faridia_healthcare/models/doctor_model.dart';
import 'package:faridia_healthcare/models/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../../core/app_constants.dart';
import '../../../models/appointment_request_model.dart';

class DoctorHomePageGetController extends GetxController {
  RxList<AppointmentRequestModel> appointmentRequests =
      RxList<AppointmentRequestModel>([]);

  RxInt unreadMessages = 0.obs;

  late StreamSubscription<QuerySnapshot> appointmentsListen;

  Future<void> fetchAppointmentRequests() async {
    appointmentsListen = FirebaseFirestore.instance
        .collection(AppConstants.doctors)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(AppConstants.appointmentRequests)
        .snapshots()
        .listen((value) {
      appointmentRequests.value = value.docs
          .map((e) => AppointmentRequestModel.fromJson(
              jsonDecode(jsonEncode(e.data()))))
          .toList();
    });
  }

  @override
  void onInit() {
    saveFcmToken();
    fetchAppointmentRequests();
    getUnreadMessages();
    super.onInit();
  }

  @override
  void onClose() {
    appointmentsListen.cancel();
    unreadMessagesListen.cancel();
    super.onClose();
  }

  void initiateAppointmentMeeting(AppointmentModel appointment) {
    if (appointment.appointmentOn.isBefore(DateTime.now())) {
      FirebaseFirestore.instance
          .collection(AppConstants.doctors)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((doctorData) {
        DoctorModel patientModel =
            DoctorModel.fromJson(jsonDecode(jsonEncode(doctorData.data()!)));
        Get.to(() => ZegoUIKitPrebuiltCall(
              appID: 2147056725,
              callID: appointment.id,
              userID: FirebaseAuth.instance.currentUser!.uid!,
              userName: patientModel.name,
              config: ZegoUIKitPrebuiltCallConfig(),
              appSign:
                  '78663d2c80c989938747754831f44b8b119e04e769e52f7440786ac6725ba2e2',
            ));
      });
    } else {
      Get.snackbar("Error", "Appointment is not started yet",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  late StreamSubscription<QuerySnapshot> unreadMessagesListen;

  void getUnreadMessages() {
    unreadMessagesListen = FirebaseFirestore.instance
        .collection(AppConstants.chatChannels)
        .where('doctor_email',
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      unreadMessages.value = 0;
      for (var element in event.docs) {
        MessageModel lastMessage = MessageModel.fromJson(
            jsonDecode(jsonEncode(element.get('last_message'))));
        unreadMessages.value += lastMessage.readByDoctor ? 0 : 1;
      }
    });
  }

  Future<void> saveFcmToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    await FirebaseFirestore.instance
        .collection(AppConstants.doctors)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'fcmToken': token});
  }

  void rejectAppointmentRequest(AppointmentRequestModel appointmentRequest) {
    FirebaseFirestore.instance
        .collection(AppConstants.doctors)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(AppConstants.appointmentRequests)
        .doc(appointmentRequest.id)
        .delete();
    FirebaseFirestore.instance
        .collection(AppConstants.patients)
        .doc(appointmentRequest.patientModel.id)
        .collection(AppConstants.appointmentRequests)
        .doc(appointmentRequest.id)
        .delete();

    fetchAppointmentRequests();
  }
}
