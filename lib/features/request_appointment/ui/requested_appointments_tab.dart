import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/helpers/date_time_helpers.dart';
import 'package:faridia_healthcare/models/appointment_request_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_constants.dart';

class RequestedAppointmentsTab extends StatelessWidget {
  const RequestedAppointmentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection(AppConstants.patients)
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection(AppConstants.appointmentRequests)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  AppointmentRequestModel appointmentRequestModel =
                      AppointmentRequestModel.fromJson(jsonDecode(
                          jsonEncode(snapshot.data!.docs[index].data())));
                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            appointmentRequestModel.doctorModel.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14.sp),
                          ),
                          subtitle: Text(
                            "${appointmentRequestModel.appointmentFor.getDateString()} on ${appointmentRequestModel.appointmentFor.getTimeStringInAmPm()}",
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Divider(
                          thickness: 1.5.sp,
                          color: Colors.grey,
                          indent: 16.sp,
                          endIndent: 16.sp,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0.sp),
                          child: Text(
                            appointmentRequestModel.briefMessage,
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
