import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/helpers/date_time_helpers.dart';
import 'package:faridia_healthcare/models/notification_model.dart';
import 'package:faridia_healthcare/models/patient_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../FCM/fcm_get_controller.dart';
import '../../../core/app_constants.dart';
import '../../../models/appointment_model.dart';

class DoctorAppointmentGetController extends GetxController {
  Future<void> cancelAppointment(AppointmentModel appointmentModel) async {
    await FirebaseFirestore.instance
        .collection(AppConstants.appointments)
        .doc(appointmentModel.id)
        .delete()
        .then((value) async {
      Uuid uuid = const Uuid();
      String notificationId = uuid.v4();
      NotificationModel notificationModel = NotificationModel(
          id: notificationId,
          title: 'Appointment Cancelled',
          description:
              'Your appointment for ${appointmentModel.appointmentOn.getDateStringWithMonthName()} on ${appointmentModel.appointmentOn.getTimeStringInAmPm()} with doctor ${appointmentModel.doctorModel.name} has been cancelled by the doctor.',
          isRead: false,
          sentAt: DateTime.now());
      await FirebaseFirestore.instance
          .collection(AppConstants.patients)
          .doc(appointmentModel.patientEmail)
          .collection(AppConstants.notifications)
          .doc(notificationId)
          .set(notificationModel.toJson());
      await FirebaseFirestore.instance
          .collection(AppConstants.patients)
          .doc(appointmentModel.patientEmail)
          .get()
          .then((value) {
        PatientModel currentPatient =
            PatientModel.fromJson(jsonDecode(jsonEncode(value.data())));
        FCMGetController fcmGetController = Get.put(FCMGetController());
        fcmGetController.sendNotification(
            currentPatient.fcmToken,
            'New Appointment',
            'Your appointment for ${appointmentModel.appointmentOn.getDateStringWithMonthName()} on ${appointmentModel.appointmentOn.getTimeStringInAmPm()} with doctor ${appointmentModel.doctorModel.name} has been cancelled by the doctor.');
      });
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
}
