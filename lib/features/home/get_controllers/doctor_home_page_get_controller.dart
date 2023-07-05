import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/models/appointment_model.dart';
import 'package:faridia_healthcare/models/doctor_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  void joinMeeting(AppointmentModel appointment) {}

  void initiateAppointmentMeeting(AppointmentModel appointment) {
    if (appointment.appointmentOn.isBefore(DateTime.now())) {
      joinMeeting(appointment);
    } else {
      Get.snackbar("Error", "Appointment is not started yet",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void getUnreadMessages() {
    ZIMConversationQueryConfig conversationQueryConfig =
        ZIMConversationQueryConfig();
    conversationQueryConfig.nextConversation = null;
// The number of queries per page.
    conversationQueryConfig.count = 20;

//Get the session list.
    ZIM
        .getInstance()!
        .queryConversationList(conversationQueryConfig)
        .then((value) => {
              value.conversationList.forEach((element) {
                unreadMessages.value += element.unreadMessageCount;
              })
            })
        .catchError((onError) {});
  }
}
