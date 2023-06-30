import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/models/patient_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import '../../../core/app_constants.dart';

class PatientHomePageGetController extends GetxController{
  @override
  void onInit() {
    zegoLogin();
    super.onInit();
  }

  void zegoLogin() {
    FirebaseFirestore.instance
        .collection(AppConstants.patients)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      PatientModel patientModel =
      PatientModel.fromJson(jsonDecode(jsonEncode(value.data())));
      ZIMKit().connectUser(
        id: FirebaseAuth.instance.currentUser!.email!,
        name: patientModel.name,
        avatarUrl: patientModel.imageLink,
      );
      ZIMKitConversation zimKitConversation = ZIMKitConversation();
    });
  }
}