import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/models/doctor_model.dart';
import 'package:faridia_healthcare/models/patient_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

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
      ZIMKit()
          .connectUser(
              id: FirebaseAuth.instance.currentUser!.email!,
              name: patientModel.name,
              avatarUrl: patientModel.imageLink)
          .then((value) {
        Get.to(() => ZIMKitMessageListPage(
              conversationID: doctorModel.email,
              conversationType: ZIMConversationType.peer,
              appBarBuilder: (context, title) {
                return AppBar(
                  leading: CircleAvatar(
                    radius: 10.sp,
                    backgroundImage: NetworkImage(doctorModel.imageLink),
                  ),
                  title: Text(doctorModel.name),
                );
              },
            ));
      });
    });
  }
}
