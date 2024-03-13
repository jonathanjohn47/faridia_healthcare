import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:faridia_healthcare/core/app_constants.dart';
import 'package:faridia_healthcare/models/patient_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../home/ui/patient_home_page.dart';
import '../../sign_in/ui/verify_otp_page.dart';

class PatientSignUpGetController extends GetxController {
  TextEditingController nameController = TextEditingController();

  //TextEditingController phoneController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool showPassword = false.obs;

  RxString imagePath = ''.obs;

  RxBool showLoader = false.obs;

  CountryCode countryCode = CountryCode(dialCode: "+91");

  void chooseImage() {
    ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        imagePath.value = value.path;
      }
    });
  }

  Future<void> signUpAsPatient() async {
    if (!formKey.currentState!.validate()) {
      Get.snackbar('Error', 'Please fill in all the fields',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    showLoader.value = true;
    FirebaseFirestore.instance
        .collection(AppConstants.patients)
        .where("phone",
            isEqualTo: countryCode.toString() + phoneNumberController.text)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        Get.snackbar("Error", "User already exists",
            backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        if (imagePath.isEmpty) {
          FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: countryCode.toString() + phoneNumberController.text,
            verificationCompleted: (PhoneAuthCredential credential) async {
              await FirebaseAuth.instance
                  .signInWithCredential(credential)
                  .then((value) {
                PatientModel patientModel = PatientModel(
                    id: value.user!.uid,
                    name: nameController.text,
                    phone: countryCode.toString() + phoneNumberController.text,
                    address: addressController.text,
                    fcmToken: "");
                FirebaseFirestore.instance
                    .collection(AppConstants.patients)
                    .doc(value.user!.uid)
                    .set(patientModel.toJson())
                    .then((value) {
                  Get.offAll(() => PatientHomePage());
                });
              });
            },
            verificationFailed: (FirebaseAuthException e) {
              if (e.code == 'invalid-phone-number') {
                Get.snackbar(
                    "Error", "The provided phone number is not valid.");
              }
            },
            codeSent: (String verificationId, int? resendToken) {
              Get.to(() => VerifyOtpPage(
                    verificationId: verificationId,
                    onVerified: (uid) async {
                      PatientModel patientModel = PatientModel(
                          id: uid,
                          name: nameController.text,
                          phone: countryCode.toString() +
                              phoneNumberController.text,
                          address: addressController.text,
                          fcmToken: "");
                      FirebaseFirestore.instance
                          .collection(AppConstants.patients)
                          .doc(uid)
                          .set(patientModel.toJson())
                          .then((value) {
                        Get.offAll(() => PatientHomePage());
                      });
                    },
                  ));
            },
            codeAutoRetrievalTimeout: (String verificationId) {},
          );
        } else {
          FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: countryCode.toString() + phoneNumberController.text,
            verificationCompleted: (PhoneAuthCredential credential) async {
              await FirebaseAuth.instance
                  .signInWithCredential(credential)
                  .then((value) {
                FirebaseStorage.instance
                    .ref()
                    .child(AppConstants.patients)
                    .child(value.user!.uid)
                    .putFile(File(imagePath.value))
                    .then((p0) {
                  p0.ref.getDownloadURL().then((downloadUrl) {
                    PatientModel patientModel = PatientModel(
                        id: value.user!.uid,
                        name: nameController.text,
                        phone:
                            countryCode.toString() + phoneNumberController.text,
                        address: addressController.text,
                        imageLink: downloadUrl,
                        fcmToken: "");
                    FirebaseFirestore.instance
                        .collection(AppConstants.patients)
                        .doc(value.user!.uid)
                        .set(patientModel.toJson())
                        .then((value) {
                      Get.offAll(() => PatientHomePage());
                    });
                  });
                });
              });
            },
            verificationFailed: (FirebaseAuthException e) {
              if (e.code == 'invalid-phone-number') {
                Get.snackbar(
                    "Error", "The provided phone number is not valid.");
              }
            },
            codeSent: (String verificationId, int? resendToken) {
              Get.to(() => VerifyOtpPage(
                    verificationId: verificationId,
                    onVerified: (uid) {
                      FirebaseStorage.instance
                          .ref()
                          .child(AppConstants.patients)
                          .child(uid)
                          .putFile(File(imagePath.value))
                          .then((p0) {
                        p0.ref.getDownloadURL().then((downloadUrl) {
                          PatientModel patientModel = PatientModel(
                              id: uid,
                              name: nameController.text,
                              phone: countryCode.toString() +
                                  phoneNumberController.text,
                              address: addressController.text,
                              imageLink: downloadUrl,
                              fcmToken: "");
                          FirebaseFirestore.instance
                              .collection(AppConstants.patients)
                              .doc(uid)
                              .set(patientModel.toJson())
                              .then((value) {
                            Get.offAll(() => PatientHomePage());
                          });
                        });
                      });
                    },
                  ));
            },
            codeAutoRetrievalTimeout: (String verificationId) {},
          );
        }
      }
    });
    showLoader.value = false;
  }
}
