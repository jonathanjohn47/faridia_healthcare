import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/core/app_constants.dart';
import 'package:faridia_healthcare/features/home/ui/doctor_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorSignInGetController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool showPassword = false.obs;

  RxBool showLoader = false.obs;

  Future<void> login() async {
    showLoader.value = true;
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: AppConstants.emailForTemporaryLogin,
        password: AppConstants.passwordForTemporaryLogin);

    await FirebaseFirestore.instance
        .collection(AppConstants.doctors)
        .doc(emailController.text.trim())
        .get()
        .then((value) async {
      await FirebaseAuth.instance.signOut();
      if (value.exists) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim())
            .then((value) {
          Get.offAll(() => DoctorHomePage());
        });
      } else {
        Get.snackbar("Error", "No doctor found with this email",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    });
    showLoader.value = false;
  }
}
