import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/core/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../models/doctor_model.dart';

class SavedDoctorsGetController extends GetxController {
  RxList<DoctorModel> savedDoctors = RxList<DoctorModel>([]);

  void loadSavedDoctors() {
    FirebaseFirestore.instance
        .collection(AppConstants.patients)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(AppConstants.savedDoctors)
        .get()
        .then((value) {
      List<String> doctorEmails = value.docs.map((e) => e.id).toList();
      savedDoctors.clear();
      for (String email in doctorEmails) {
        FirebaseFirestore.instance
            .collection(AppConstants.doctors)
            .doc(email)
            .get()
            .then((value) {
          DoctorModel doctorModel =
              DoctorModel.fromJson(jsonDecode(jsonEncode(value.data())));
          savedDoctors.add(doctorModel);
        });
      }
    });
  }

  void deleteFromSavedDoctorsList(DoctorModel doctor) {
    FirebaseFirestore.instance
        .collection(AppConstants.patients)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(AppConstants.savedDoctors)
        .doc(doctor.email)
        .delete()
        .then((value) => loadSavedDoctors());
  }

  @override
  void onInit() {
    loadSavedDoctors();
    super.onInit();
  }
}
