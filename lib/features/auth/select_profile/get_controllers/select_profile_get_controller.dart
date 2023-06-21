import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/core/app_constants.dart';
import 'package:faridia_healthcare/features/home/ui/doctor_home_page.dart';
import 'package:faridia_healthcare/features/home/ui/patient_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SelectProfileGetController extends GetxController {
  void checkIfAlreadyLoggedIn() {
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseFirestore.instance
          .collection(AppConstants.doctors)
          .doc(FirebaseAuth.instance.currentUser!.email)
          .get()
          .then((value) {
        if (value.exists) {
          Get.offAll(() => DoctorHomePage());
        } else {
          FirebaseFirestore.instance
              .collection(AppConstants.patients)
              .doc(FirebaseAuth.instance.currentUser!.email)
              .get()
              .then((value) {
            if (value.exists) {
              Get.offAll(() => PatientHomePage());
            }
          });
        }
      });
    }
  }

  @override
  void onInit() {
    checkIfAlreadyLoggedIn();
    super.onInit();
  }
}
