import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/core/app_constants.dart';
import 'package:faridia_healthcare/models/appointment_model.dart';
import 'package:faridia_healthcare/models/appointment_request_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetAppointmentGetController extends GetxController {
  Rx<DateTime> chosenDate = DateTime.now().obs;
  Rx<TimeOfDay> chosenTime = TimeOfDay.now().obs;

  RxBool showLoader = false.obs;

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

  Future<void> setAppointment(
      AppointmentRequestModel appointmentRequestModel) async {
    showLoader.value = true;
    AppointmentModel appointmentModel = AppointmentModel(
        id: appointmentRequestModel.id,
        doctorEmail: appointmentRequestModel.doctorModel.email,
        patientEmail: appointmentRequestModel.patientModel.email,
        doctorModel: appointmentRequestModel.doctorModel,
        patientModel: appointmentRequestModel.patientModel,
        appointmentOn: DateTime(
            chosenDate.value.year,
            chosenDate.value.month,
            chosenDate.value.day,
            chosenTime.value.hour,
            chosenTime.value.minute),
        clinicAddress: appointmentRequestModel.doctorModel.clinicAddress,
        isCancelled: false);
    await FirebaseFirestore.instance
        .collection(AppConstants.appointments)
        .doc(appointmentRequestModel.id)
        .set(appointmentModel.toJson());
    await FirebaseFirestore.instance
        .collection(AppConstants.patients)
        .doc(appointmentRequestModel.patientModel.email)
        .collection(AppConstants.appointmentRequests)
        .doc(appointmentRequestModel.id)
        .delete();
    await FirebaseFirestore.instance
        .collection(AppConstants.doctors)
        .doc(appointmentRequestModel.doctorModel.email)
        .collection(AppConstants.appointmentRequests)
        .doc(appointmentRequestModel.id)
        .delete();
    showLoader.value = false;
    Get.back();
    Get.snackbar("Success", "Appointment set successfully",
        backgroundColor: Colors.green, colorText: Colors.white);
  }
}
