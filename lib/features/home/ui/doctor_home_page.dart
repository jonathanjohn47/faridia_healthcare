import 'package:faridia_healthcare/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../notifications/ui/notifications_page.dart';
import '../../appointments/ui/doctor_appointments_page.dart';
import '../../auth/select_profile/ui/select_profile_page.dart';
import '../../messages/ui/messages_page.dart';
import '../../profile/ui/doctor_self_profile_page.dart';

class DoctorHomePage extends StatelessWidget {
  DoctorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(8.sp),
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.0.sp),
            child: Text(
              'Upcoming Appointments',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 8.sp,
          ),
          SizedBox(
            height: 80.sp,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...List.generate(
                    5,
                    (index) => Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.0.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Patient Name',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp),
                                ),
                                SizedBox(
                                  height: 8.sp,
                                ),
                                Text(
                                  '02 July 2023',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade700),
                                ),
                                Text(
                                  '8:00 AM',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey.shade700),
                                ),
                              ],
                            ),
                          ),
                        ))
              ],
            ),
          ),
          SizedBox(
            height: 8.sp,
          ),
          Divider(
            thickness: 1.5.sp,
            color: AppColors.primary,
            indent: 16.sp,
            endIndent: 16.sp,
          ),
          SizedBox(
            height: 8.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Row(
              children: [
                Text(
                  'Appointment Requests',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                CircleAvatar(
                  radius: 10.sp,
                  backgroundColor: Colors.red,
                  child: Text(
                    '5',
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8.sp,
          ),
          SizedBox(
            height: 80.sp,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...List.generate(
                    5,
                    (index) => Card(
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: 8.sp,
                                        ),
                                        ListTile(
                                          leading: Icon(
                                            Icons.calendar_today,
                                            color: Colors.green,
                                          ),
                                          title: Text(
                                            'Set Appointment',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.green),
                                          ),
                                        ),
                                        ListTile(
                                          leading: Icon(
                                            Icons.cancel,
                                            color: Colors.red,
                                          ),
                                          title: Text(
                                            'Reject',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8.0.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Patient Name',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp),
                                  ),
                                  SizedBox(
                                    height: 8.sp,
                                  ),
                                  Text(
                                    '02 July 2023',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade700),
                                  ),
                                  Text(
                                    '8:00 AM',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey.shade700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ))
              ],
            ),
          ),
          SizedBox(
            height: 8.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.sp),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.sp),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 8.sp,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                        child: Text(
                          'Notifications',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => NotificationsPage());
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.sp),
                          child: Stack(
                            children: [
                              Icon(Icons.notifications, size: 24.sp),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: CircleAvatar(
                                  radius: 8.sp,
                                  backgroundColor: Colors.red,
                                  child: Text(
                                    '1',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.sp,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                        child: Text(
                          'Messages',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => MessagesPage());
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.sp),
                          child: Stack(
                            children: [
                              Icon(Icons.chat, size: 24.sp),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: CircleAvatar(
                                  radius: 8.sp,
                                  backgroundColor: Colors.red,
                                  child: Text(
                                    '1',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Image.asset(
                "assets/images/Faridia Healthcare-07.png",
                width: 60.w,
                height: 20.h,
                fit: BoxFit.cover,
              ),
              Divider(
                thickness: 1.5.sp,
                color: AppColors.secondary,
                indent: 8.sp,
                endIndent: 8.sp,
              ),
              Expanded(
                  child: ListView(
                children: [
                  ListTile(
                    title: Text('My Profile'),
                    onTap: () {
                      Get.to(() => DoctorSelfProfilePage());
                    },
                  ),
                  Divider(
                    thickness: 0.5.sp,
                    color: AppColors.primary,
                    indent: 10.sp,
                    endIndent: 10.sp,
                  ),
                  ListTile(
                    title: Text('Appointments'),
                    onTap: () {
                      Get.to(() => DoctorAppointmentsPage());
                    },
                  ),
                  Divider(
                    thickness: 0.5.sp,
                    color: AppColors.primary,
                    indent: 10.sp,
                    endIndent: 10.sp,
                  ),
                  ListTile(
                    title: Text("Messages"),
                    trailing: CircleAvatar(
                      radius: 10.sp,
                      backgroundColor: Colors.red,
                      child: Text(
                        '9+',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      Get.to(() => MessagesPage());
                    },
                  ),
                  Divider(
                    thickness: 0.5.sp,
                    color: AppColors.primary,
                    indent: 10.sp,
                    endIndent: 10.sp,
                  ),
                ],
              )),
              Divider(
                thickness: 1.5.sp,
                color: AppColors.secondary,
                indent: 8.sp,
                endIndent: 8.sp,
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {
                  Get.offAll(() => SelectProfilePage());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
