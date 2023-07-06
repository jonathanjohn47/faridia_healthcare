import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/core/app_constants.dart';
import 'package:faridia_healthcare/models/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AppointmentPageGetController extends GetxController {
  void cancelAppointment(AppointmentModel appointment,
      {required BuildContext context}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Cancel Appointment?'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Are you sure you want to cancel this appointment?'),
                SizedBox(
                  height: 8.sp,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection(AppConstants.appointments)
                      .doc(appointment.id)
                      .delete()
                      .then((value) {
                    Navigator.pop(context);
                    Get.snackbar(
                        'Success', "The appointment has been cancelled",
                        backgroundColor: Colors.green, colorText: Colors.white);
                  });
                },
                child: const Text('Yes'),
              ),
            ],
          );
        });
  }
}
