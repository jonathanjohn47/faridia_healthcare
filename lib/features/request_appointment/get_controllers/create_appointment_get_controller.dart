import 'package:faridia_healthcare/models/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAppointmentGetController extends GetxController {
  TextEditingController briefMessageController = TextEditingController();

  Rx<DateTime> chosenDate = DateTime.now().obs;
  Rx<TimeOfDay> chosenTime = TimeOfDay.now().obs;

  void selectDate(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 30)))
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

  void createAppointment(DoctorModel doctorModel) {}
}
