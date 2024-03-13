import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:faridia_healthcare/core/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PatientSignUpGetController extends GetxController {
  TextEditingController nameController = TextEditingController();

  //TextEditingController phoneController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool showPassword = false.obs;

  RxString imagePath = ''.obs;

  RxBool showLoader = false.obs;

  CountryCode countryCode = CountryCode.fromCountryCode('91');

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
        if (imagePath.isEmpty){

        }
      }
    });
    showLoader.value = false;
  }
}
