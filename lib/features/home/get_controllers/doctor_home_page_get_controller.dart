import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../core/app_constants.dart';
import '../../../models/appointment_request_model.dart';

class DoctorHomePageGetController extends GetxController {
  RxList<AppointmentRequestModel> appointmentRequests =
      RxList<AppointmentRequestModel>([]);

  Future<void> fetchAppointmentRequests() async {
    await FirebaseFirestore.instance
        .collection(AppConstants.doctors)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(AppConstants.appointmentRequests)
        .get()
        .then((value) {
      appointmentRequests.value = value.docs
          .map((e) => AppointmentRequestModel.fromJson(
              jsonDecode(jsonEncode(e.data()))))
          .toList();
    });
  }

  @override
  void onInit() {
    fetchAppointmentRequests();
    super.onInit();
  }
}
