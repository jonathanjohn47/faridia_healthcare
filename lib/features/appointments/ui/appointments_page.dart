import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/core/app_colors.dart';
import 'package:faridia_healthcare/core/app_constants.dart';
import 'package:faridia_healthcare/helpers/date_time_helpers.dart';
import 'package:faridia_healthcare/models/appointment_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../get_controllers/appointment_page_get_controller.dart';

class AppointmentsPage extends StatelessWidget {
  AppointmentsPage({super.key});

  AppointmentPageGetController appointmentPageGetController =
      Get.put(AppointmentPageGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8.sp),
            bottomRight: Radius.circular(8.sp),
          ),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection(AppConstants.appointments)
              .where('patient_email',
                  isEqualTo: FirebaseAuth.instance.currentUser!.email)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<AppointmentModel> allAppointments = snapshot.data!.docs
                  .map((e) => AppointmentModel.fromJson(
                      jsonDecode(jsonEncode(e.data()))))
                  .toList();
              return ListView.builder(
                itemBuilder: (context, index) {
                  AppointmentModel appointment = allAppointments[index];
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(4.sp),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              'Dr. ${appointment.doctorModel.name}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 14.sp),
                            ),
                            subtitle: Text(
                              appointment.doctorModel.bio,
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  appointment.appointmentOn.getDateString(),
                                  style: TextStyle(fontSize: 10.sp),
                                ),
                                SizedBox(
                                  width: 4.sp,
                                ),
                                Text(
                                  appointment.appointmentOn.getTimeString(),
                                  style: TextStyle(fontSize: 10.sp),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondary,
                                ),
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 4.sp,
                                    ),
                                    Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: allAppointments.length,
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
