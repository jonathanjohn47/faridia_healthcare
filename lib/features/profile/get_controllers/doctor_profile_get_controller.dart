import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/models/doctor_model.dart';
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
}
