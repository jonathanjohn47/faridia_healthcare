import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:faridia_healthcare/core/app_constants.dart';
import 'package:faridia_healthcare/features/auth/sign_in/ui/verify_otp_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../home/ui/patient_home_page.dart';

class PatientSignInGetController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool showPassword = false.obs;

  CountryCode countryCode = CountryCode(dialCode: "+91");

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool showLoader = false.obs;

  Future<void> signInAsPatient() async {
    showLoader.value = true;
    if (formKey.currentState!.validate()) {
      FirebaseFirestore.instance
          .collection(AppConstants.patients)
          .where("phone",
              isEqualTo: countryCode.toString() + phoneController.text)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          initiatePhoneSignIn();
        } else {
          Get.snackbar("Error", "User not found",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      });
    }
    showLoader.value = false;
  }

  void initiatePhoneSignIn() {
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: countryCode.toString() + phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
        Get.offAll(() => PatientHomePage());
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar("Error", "The provided phone number is not valid.");
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        Get.to(() => VerifyOtpPage(
              verificationId: verificationId,
              onVerified: (uid) {
                Get.offAll(() => PatientHomePage());
              },
            ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
