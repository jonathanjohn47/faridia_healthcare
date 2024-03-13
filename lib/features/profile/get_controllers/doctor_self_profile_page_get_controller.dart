import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/core/app_constants.dart';
import 'package:faridia_healthcare/models/doctor_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DoctorSelfProfilePageGetController extends GetxController {
  RxBool editMode = false.obs;
  RxString imageLink = ''.obs;

  RxBool imagePicked = false.obs;

  late DoctorModel doctorModel;

  //name, bio, about, services, experience, awards and recognitions, clinic address
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController servicesController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController awardsAndRecognitionsController =
      TextEditingController();
  TextEditingController clinicAddressController = TextEditingController();

  void loadDoctor() {
    FirebaseFirestore.instance
        .collection(AppConstants.doctors)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      doctorModel = DoctorModel.fromJson(jsonDecode(jsonEncode(value.data()!)));
      nameController.text = doctorModel.name;
      bioController.text = doctorModel.bio;
      aboutController.text = doctorModel.about;
      servicesController.text = doctorModel.services;
      experienceController.text = doctorModel.experience;
      awardsAndRecognitionsController.text = doctorModel.awardsAndRecognitions;
      clinicAddressController.text = doctorModel.clinicAddress;
      imageLink.value = doctorModel.imageLink;
    });
  }

  void getPhoto() {
    ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((value) {
      imageLink.value = value!.path;
      imagePicked.value = true;
    });
  }

  Future<void> saveDoctor() async {
    if (imagePicked.value) {
      await uploadImage(File(imageLink.value)).then((downloadUrl) async {
        doctorModel = doctorModel.copyWith(
          name: nameController.text,
          bio: bioController.text,
          about: aboutController.text,
          services: servicesController.text,
          experience: experienceController.text,
          awardsAndRecognitions: awardsAndRecognitionsController.text,
          clinicAddress: clinicAddressController.text,
          imageLink: downloadUrl,
        );
        await FirebaseFirestore.instance
            .collection(AppConstants.doctors)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(doctorModel.toJson());
        editMode.value = false;
      });
    } else {
      doctorModel = doctorModel.copyWith(
        name: nameController.text,
        bio: bioController.text,
        about: aboutController.text,
        services: servicesController.text,
        experience: experienceController.text,
        awardsAndRecognitions: awardsAndRecognitionsController.text,
        clinicAddress: clinicAddressController.text,
      );
      await FirebaseFirestore.instance
          .collection(AppConstants.doctors)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(doctorModel.toJson());
      editMode.value = false;
    }
    loadDoctor();
  }

  @override
  void onInit() {
    loadDoctor();
    super.onInit();
  }

  Future<String> uploadImage(File file) async {
    String downloadUrl = "";
    await FirebaseStorage.instance
        .ref()
        .child(AppConstants.doctors)
        .child(FirebaseAuth.instance.currentUser!.uid!)
        .putFile(File(imageLink.value))
        .then((p0) async {
      await p0.ref.getDownloadURL().then((value) {
        downloadUrl = value;
      });
    });
    return downloadUrl;
  }
}
