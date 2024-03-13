import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/core/app_constants.dart';
import 'package:faridia_healthcare/features/auth/sign_in/ui/patient_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../../home/ui/doctor_home_page.dart';

class SplashGetController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  RxDouble animationValue = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )
      ..forward(from: 0).then((value) {
        Get.off(() => PatientSignInPage());
      })
      ..addListener(() {
        animationValue.value = animationController.value;
      });
  }

  Future<void> checkIfAlreadySignedIn() async {
    if (FirebaseAuth.instance.currentUser != null) {
      bool isDoctor = await FirebaseFirestore.instance
          .collection(AppConstants.doctors)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) => value.exists);

      if (isDoctor) {
        if (animationValue.value == 1.0) {
          Get.offAll(() => DoctorHomePage());
        } else {
          animationValue.listen((p0) {
            if (p0 == 1.0) {
              Get.offAll(() => DoctorHomePage());
            }
          });
        }
      } else {
        if (animationValue.value == 1.0) {
          Get.offAll(() => PatientSignInPage());
        } else {
          animationValue.listen((p0) {
            if (p0 == 1.0) {
              Get.offAll(() => PatientSignInPage());
            }
          });
        }
      }
    }
  }
}
