import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_colors.dart';

class DoctorAppointmentsPage extends StatelessWidget {
  DoctorAppointmentsPage({super.key});

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
              child: ListView(
                children: [
                  ...List.generate(
                      10,
                      (index) => Card(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.sp, vertical: 8.0.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Patient Name",
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
                                          "12 July 2023",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade700),
                                        ),
                                        Text(
                                          "8:00AM",
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
                                            onPressed: () {},
                                            child: Text('Cancel Appointment'))
                                      ])
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
