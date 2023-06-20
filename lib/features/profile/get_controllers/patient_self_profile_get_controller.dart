import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/models/patient_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/app_constants.dart';

class PatientSelfProfileGetController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  RxString name = ''.obs;
  RxString phoneNumber = ''.obs;
  RxString email = ''.obs;
  RxString address = ''.obs;
  RxString fcmToken = ''.obs;

  RxString imageLink = ''.obs;

  RxBool editMode = false.obs;

  RxBool uploadNewPhoto = false.obs;

  @override
  void onInit() {
    fetchCurrentPatient();
    super.onInit();
  }

  void fetchCurrentPatient() {
    FirebaseFirestore.instance
        .collection(AppConstants.patients)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      PatientModel currentPatient =
          PatientModel.fromJson(jsonDecode(jsonEncode(value.data())));
      nameController.text = currentPatient.name;
      phoneNumberController.text = currentPatient.phone;
      emailController.text = currentPatient.email;
      addressController.text = currentPatient.address;
      imageLink.value = currentPatient.imageLink;

      name.value = currentPatient.name;
      phoneNumber.value = currentPatient.phone;
      email.value = currentPatient.email;
      address.value = currentPatient.address;
      fcmToken.value = currentPatient.fcmToken;
    });
  }

  void getImage() {
    ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        uploadNewPhoto.value = true;
        imageLink.value = value.path;
      }
    });
  }

  void save() {
    if (uploadNewPhoto.value) {
      FirebaseStorage.instance
          .ref()
          .child(AppConstants.patients)
          .child(FirebaseAuth.instance.currentUser!.email!)
          .putFile(File(imageLink.value))
          .then((value) {
        value.ref.getDownloadURL().then((downloadUrl) {
          PatientModel patientModel = PatientModel(
              name: nameController.text.trim(),
              email: emailController.text.trim(),
              phone: phoneNumberController.text.trim(),
              address: addressController.text.trim(),
              fcmToken: fcmToken.value,
              imageLink: downloadUrl);
          FirebaseFirestore.instance
              .collection(AppConstants.patients)
              .doc(FirebaseAuth.instance.currentUser!.email)
              .update(patientModel.toJson());
        });
      });
    } else {
      PatientModel patientModel = PatientModel(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          phone: phoneNumberController.text.trim(),
          address: addressController.text.trim(),
          fcmToken: fcmToken.value,
          imageLink: imageLink.value);
      FirebaseFirestore.instance
          .collection(AppConstants.patients)
          .doc(FirebaseAuth.instance.currentUser!.email)
          .update(patientModel.toJson());
    }
  }
}
