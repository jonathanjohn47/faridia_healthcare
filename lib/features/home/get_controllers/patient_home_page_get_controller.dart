import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/models/appointment_model.dart';
import 'package:faridia_healthcare/models/patient_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import '../../../core/app_constants.dart';

class PatientHomePageGetController extends GetxController {
  RxInt unreadMessages = 0.obs;

  @override
  void onInit() {
    zegoLogin().then((value) {
      getUnreadMessages();
    });
    super.onInit();
  }

  Future<void> zegoLogin() async {
    await FirebaseFirestore.instance
        .collection(AppConstants.patients)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) async {
      PatientModel patientModel =
          PatientModel.fromJson(jsonDecode(jsonEncode(value.data())));
      await ZIMKit().connectUser(
        id: FirebaseAuth.instance.currentUser!.email!,
        name: patientModel.name,
        avatarUrl: patientModel.imageLink,
      );
      ZIMKitConversation zimKitConversation = ZIMKitConversation();
    });
  }

  void getUnreadMessages() {
    ZIMEventHandler.onConversationTotalUnreadMessageCountUpdated =
        (zim, count) {
      unreadMessages.value = count;
    };
  }

  void joinMeeting(AppointmentModel appointment) {
    FirebaseFirestore.instance
        .collection(AppConstants.patients)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      PatientModel currentPatient =
          PatientModel.fromJson(jsonDecode(jsonEncode(value.data())));
      Get.to(() {
        return ZegoUIKitPrebuiltCall(
            appID: 2147056725,
            // Fill in the appID that you get from ZEGOCLOUD Admin Console.
            appSign:
                '78663d2c80c989938747754831f44b8b119e04e769e52f7440786ac6725ba2e2',
            // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
            userID: FirebaseAuth.instance.currentUser!.email!,
            userName: currentPatient.name,
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
}
