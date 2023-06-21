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
            title: Text('Cancel Appointment?'),
            content: Column(
              children: [
                Text('Are you sure you want to cancel this appointment?'),
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
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  AppointmentModel cancelledAppointment =
                      appointment.copyWith(isCancelled: true);
                  FirebaseFirestore.instance
                      .collection(AppConstants.appointments)
                      .doc(cancelledAppointment.id)
                      .update(cancelledAppointment.toJson())
                      .then((value) {
                    Navigator.pop(context);
                    Get.snackbar(
                        'Success', "The appointment has been cancelled",
                        backgroundColor: Colors.green, colorText: Colors.white);
                  });
                },
                child: Text('Yes'),
              ),
            ],
          );
        });
  }
}
