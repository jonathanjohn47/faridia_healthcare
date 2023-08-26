import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/models/appointment_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    } else {
      Get.snackbar("Error", "Appointment is not started yet",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> saveFcmToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    await FirebaseFirestore.instance
        .collection(AppConstants.patients)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({'fcmToken': token});
  }
}
