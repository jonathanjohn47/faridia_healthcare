import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/models/appointment_model.dart';
import 'package:faridia_healthcare/models/patient_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../../core/app_constants.dart';

class PatientHomePageGetController extends GetxController {
  RxInt unreadMessages = 0.obs;

  @override
  void onInit() {
    saveFcmToken();
    super.onInit();
  }

  void getUnreadMessages() {}

  void initiateAppointmentMeeting(AppointmentModel appointment) {
    if (appointment.appointmentOn.isBefore(DateTime.now())) {
      FirebaseFirestore.instance
          .collection(AppConstants.patients)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((patientData) {
        PatientModel patientModel =
            PatientModel.fromJson(jsonDecode(jsonEncode(patientData.data()!)));
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

  Future<void> saveFcmToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    await FirebaseFirestore.instance
        .collection(AppConstants.patients)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'fcmToken': token});
  }
}
