import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/core/app_constants.dart';
import 'package:faridia_healthcare/models/appointment_request_model.dart';
import 'package:faridia_healthcare/models/doctor_model.dart';
import 'package:faridia_healthcare/models/notification_model.dart';
import 'package:faridia_healthcare/models/patient_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CreateAppointmentGetController extends GetxController {
  TextEditingController briefMessageController = TextEditingController();

  Rx<DateTime> chosenDate = DateTime.now().obs;
  Rx<TimeOfDay> chosenTime = TimeOfDay.now().obs;

  void selectDate(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 30)))
        .then((value) {
      if (value != null) {
        chosenDate.value = value;
      }
    });
  }

  void selectTime(BuildContext context) {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      if (value != null) {
        chosenTime.value = value;
      }
    });
  }

  Future<void> createAppointment(DoctorModel doctorModel) async {
    Uuid uuid = const Uuid();
    String appointmentRequestId = uuid.v4();
    await FirebaseFirestore.instance
        .collection(AppConstants.patients)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) async {
      PatientModel patientModel =
          PatientModel.fromJson(jsonDecode(jsonEncode(value.data())));
      AppointmentRequestModel appointmentRequestModel = AppointmentRequestModel(
          id: appointmentRequestId,
          doctorModel: doctorModel,
          patientModel: patientModel,
          briefMessage: briefMessageController.text,
          requestedOn: DateTime.now(),
          appointmentFor: DateTime(
              chosenDate.value.year,
              chosenDate.value.month,
              chosenDate.value.day,
              chosenTime.value.hour,
              chosenTime.value.minute));
      await FirebaseFirestore.instance
          .collection(AppConstants.doctors)
          .doc(doctorModel.email)
          .collection(AppConstants.appointmentRequests)
          .doc(appointmentRequestId)
          .set(appointmentRequestModel.toJson());
      await FirebaseFirestore.instance
          .collection(AppConstants.patients)
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection(AppConstants.appointmentRequests)
          .doc(appointmentRequestId)
          .set(appointmentRequestModel.toJson())
          .then((value) async {
        String notificationId = uuid.v4();
        NotificationModel notificationModel = NotificationModel(
            id: notificationId,
            title: 'Appointment Request',
            description:
                'You have a new appointment request from ${appointmentRequestModel.patientModel.name}',
            isRead: false,
            sentAt: DateTime.now());
        await FirebaseFirestore.instance
            .collection(AppConstants.doctors)
            .doc(doctorModel.email)
            .collection(AppConstants.notifications)
            .doc(notificationId)
            .set(notificationModel.toJson());
      });
    });
  }
}
