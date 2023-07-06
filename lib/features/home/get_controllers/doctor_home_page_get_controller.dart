import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/models/appointment_model.dart';
import 'package:faridia_healthcare/models/doctor_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import '../../../core/app_constants.dart';
import '../../../models/appointment_request_model.dart';

class DoctorHomePageGetController extends GetxController {
  RxList<AppointmentRequestModel> appointmentRequests =
      RxList<AppointmentRequestModel>([]);

  RxInt unreadMessages = 0.obs;

  Future<void> fetchAppointmentRequests() async {
    await FirebaseFirestore.instance
        .collection(AppConstants.doctors)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(AppConstants.appointmentRequests)
        .get()
        .then((value) {
      appointmentRequests.value = value.docs
          .map((e) => AppointmentRequestModel.fromJson(
              jsonDecode(jsonEncode(e.data()))))
          .toList();
    });
  }

  @override
  void onInit() {
    zegoLogin().then((value) {
      getUnreadMessages();
    });
    saveFcmToken();
    fetchAppointmentRequests();
    super.onInit();
  }

  Future<void> zegoLogin() async {
    await FirebaseFirestore.instance
        .collection(AppConstants.doctors)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) async {
      DoctorModel doctorModel =
          DoctorModel.fromJson(jsonDecode(jsonEncode(value.data())));
      await ZIMKit().connectUser(
        id: FirebaseAuth.instance.currentUser!.email!,
        name: doctorModel.name,
        avatarUrl: doctorModel.imageLink,
      );
    });
  }

  void joinMeeting(AppointmentModel appointment) {
    FirebaseFirestore.instance
        .collection(AppConstants.doctors)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      DoctorModel currentDoctor =
          DoctorModel.fromJson(jsonDecode(jsonEncode(value.data())));
      Get.to(() {
        return ZegoUIKitPrebuiltCall(
            appID: 2147056725,
            // Fill in the appID that you get from ZEGOCLOUD Admin Console.
            appSign:
                '78663d2c80c989938747754831f44b8b119e04e769e52f7440786ac6725ba2e2',
            // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
            userID: FirebaseAuth.instance.currentUser!.email!,
            userName: currentDoctor.name,
            callID: appointment.id,
            // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
            config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall());
      });
    });
  }

  void initiateAppointmentMeeting(AppointmentModel appointment) {
    if (appointment.appointmentOn.isBefore(DateTime.now())) {
      joinMeeting(appointment);
    } else {
      Get.snackbar("Error", "Appointment is not started yet",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void getUnreadMessages() {
    ZIMEventHandler.onConversationTotalUnreadMessageCountUpdated =
        (zim, count) {
      unreadMessages.value = count;
    };
  }

  Future<void> saveFcmToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    await FirebaseFirestore.instance
        .collection(AppConstants.doctors)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({'fcmToken': token});
  }
}
