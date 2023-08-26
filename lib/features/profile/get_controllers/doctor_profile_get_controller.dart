import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/features/chat/ui/chat_page.dart';
import 'package:faridia_healthcare/models/chat_channel_model.dart';
import 'package:faridia_healthcare/models/doctor_model.dart';
import 'package:faridia_healthcare/models/message_model.dart';
import 'package:faridia_healthcare/models/patient_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_constants.dart';

class DoctorProfileGetController extends GetxController {
  final DoctorModel doctorModel;

  DoctorProfileGetController(this.doctorModel);

  void saveDoctor() {
    FirebaseFirestore.instance
        .collection(AppConstants.patients)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(AppConstants.savedDoctors)
        .doc(doctorModel.email)
        .set(doctorModel.toJson())
        .then((value) {
      Get.snackbar("Success", "Doctor saved successfully",
          backgroundColor: Colors.green, colorText: Colors.white);
    });
  }

  void chatWithDoctor() {
    FirebaseFirestore.instance
        .collection(AppConstants.patients)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      PatientModel patientModel =
          PatientModel.fromJson(jsonDecode(jsonEncode(value.data())));
      String doctorEmailFormatted =
          doctorModel.email.replaceAll('@', '').replaceAll('.', '');
      String patientEmailFormatted =
          patientModel.email.replaceAll('@', '').replaceAll('.', '');
      String uniqueID = doctorEmailFormatted + patientEmailFormatted;
      ChatChannelModel chatChannelModel = ChatChannelModel(
          id: uniqueID,
          doctorEmail: doctorModel.email,
          patientEmail: patientModel.email,
          doctorModel: doctorModel,
          patientModel: patientModel,
          lastMessage: MessageModel.empty());
      Get.to(() => ChatPage(chatChannel: chatChannelModel));
    });
  }
}
