import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:faridia_healthcare/core/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../home/ui/patient_home_page.dart';

class PatientSignInGetController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool showPassword = false.obs;

  CountryCode countryCode = CountryCode.fromCountryCode('91');

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool showLoader = false.obs;

  Future<void> signInAsPatient() async {
    showLoader.value = true;
    if (formKey.currentState!.validate()) {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: AppConstants.emailForTemporaryLogin,
              password: AppConstants.passwordForTemporaryLogin)
          .then((value) async {
        final snapshot = await FirebaseFirestore.instance
            .collection(AppConstants.patients)
            .doc(phoneController.text.trim())
            .get();

        await FirebaseAuth.instance.signOut();

        if (snapshot.exists) {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: phoneController.text.trim(),
                  password: passwordController.text.trim())
              .then((value) {
            Get.offAll(() => PatientHomePage());
          });
        }
      }).catchError((error) {
        Get.snackbar('Error', error.toString(),
            backgroundColor: Colors.red, colorText: Colors.white);
      });
    }
    showLoader.value = false;
  }
}
