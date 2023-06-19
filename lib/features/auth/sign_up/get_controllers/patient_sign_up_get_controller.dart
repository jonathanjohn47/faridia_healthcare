import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/core/app_constants.dart';
import 'package:faridia_healthcare/features/home/ui/patient_home_page.dart';
import 'package:faridia_healthcare/models/patient_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PatientSignUpGetController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool showPassword = false.obs;

  RxString imagePath = ''.obs;

  RxBool showLoader = false.obs;

  void chooseImage() {
    ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        imagePath.value = value.path;
      }
    });
  }

  Future<void> signUpAsPatient() async {
    if (imagePath.value.isEmpty &&
        !formKey.currentState!.validate() &&
        passwordController.text != confirmPasswordController.text) {
      return;
    }
    showLoader.value = true;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: AppConstants.emailForTemporaryLogin,
            password: AppConstants.passwordForTemporaryLogin)
        .then((value) async {
      final snapshot = await FirebaseFirestore.instance
          .collection(AppConstants.patients)
          .doc(emailController.text.trim())
          .get();

      FirebaseAuth.instance.signOut();

      if (snapshot.exists) {
        Get.snackbar('Error', 'Email already exists',
            backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .then((value) async {
          await FirebaseStorage.instance
              .ref()
              .child(AppConstants.patients)
              .child(emailController.text)
              .putFile(File(imagePath.value))
              .then((p0) async {
            final downloadURL = await p0.ref.getDownloadURL();
            PatientModel patientModel = PatientModel(
              name: nameController.text,
              email: emailController.text,
              fcmToken: "",
              imageLink: downloadURL,
            );
            await FirebaseFirestore.instance
                .collection(AppConstants.patients)
                .doc(emailController.text)
                .set(patientModel.toJson())
                .then((value) {
              Get.offAll(() => PatientHomePage());
            });
          });
        });
      }
    });
    showLoader.value = false;
  }
}
