import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/core/app_constants.dart';
import 'package:faridia_healthcare/helpers/date_time_helpers.dart';
import 'package:faridia_healthcare/models/appointment_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_colors.dart';
import '../get_controllers/doctor_appointment_get_controller.dart';

class DoctorAppointmentsPage extends StatelessWidget {
  DoctorAppointmentsPage({super.key});

  DoctorAppointmentGetController getController =
      Get.put(DoctorAppointmentGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: Container(
          color: AppColors.primary,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Appointments",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8.sp,
            ),
            Divider(
              thickness: 1.5.sp,
              color: AppColors.primary,
            ),
            Expanded(
                child: FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection(AppConstants.appointments)
                        .where('doctor_email',
                            isEqualTo: FirebaseAuth.instance.currentUser!.email)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<AppointmentModel> appointments = snapshot
                            .data!.docs
                            .map((e) => AppointmentModel.fromJson(
                                jsonDecode(jsonEncode(e.data()))))
                            .toList();
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            return Card(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.sp, vertical: 8.0.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      appointments[index].patientModel.name,
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 8.sp,
                                    ),
                                    Table(
                                      children: [
                                        TableRow(children: [
                                          Text(
                                            "Date",
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey.shade700),
                                          ),
                                          Text(
                                            "Time",
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey.shade700),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Text(
                                            appointments[index]
                                                .appointmentOn
                                                .getDateStringWithMonthName(),
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey.shade700),
                                          ),
                                          Text(
                                            appointments[index]
                                                .appointmentOn
                                                .getTimeStringInAmPm(),
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey.shade700),
                                          ),
                                        ])
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8.sp,
                                    ),
                                    Divider(
                                      thickness: 0.5.sp,
                                      color: AppColors.secondary,
                                    ),
                                    Table(
                                      children: [
                                        TableRow(children: [
                                          TextButton(
                                              onPressed: () {
                                                getController.cancelAppointment(
                                                    appointments[index]);
                                              },
                                              child: Text('Cancel Appointment'))
                                        ])
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: appointments.length,
                        );
                      }
                      return Container();
                    })),
          ],
        ),
      ),
    );
  }
}
