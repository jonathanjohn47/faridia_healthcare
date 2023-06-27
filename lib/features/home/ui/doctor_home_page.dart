import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/core/app_colors.dart';
import 'package:faridia_healthcare/core/app_constants.dart';
import 'package:faridia_healthcare/features/appointments/ui/set_appointment_page.dart';
import 'package:faridia_healthcare/helpers/date_time_helpers.dart';
import 'package:faridia_healthcare/models/appointment_model.dart';
import 'package:faridia_healthcare/models/notification_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../notifications/ui/notifications_page.dart';
import '../../appointments/ui/doctor_appointments_page.dart';
import '../../auth/select_profile/ui/select_profile_page.dart';
import '../../messages/ui/messages_page_doctor.dart';
import '../../profile/ui/doctor_self_profile_page.dart';
import '../get_controllers/doctor_home_page_get_controller.dart';

class DoctorHomePage extends StatelessWidget {
  DoctorHomePage({super.key});

  DoctorHomePageGetController getController =
      Get.put(DoctorHomePageGetController());

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
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => DoctorSelfProfilePage());
              },
              icon: const Icon(Icons.person))
        ],
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
            height: 83.sp,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(AppConstants.appointments)
                    .where('doctor_email',
                        isEqualTo: FirebaseAuth.instance.currentUser!.email)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<AppointmentModel> appointments = snapshot.data!.docs
                        .map((e) => AppointmentModel.fromJson(
                            jsonDecode(jsonEncode(e.data()))))
                        .toList();
                    return appointments.isNotEmpty
                        ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              AppointmentModel appointment =
                                  appointments[index];
                              return Card(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0.sp),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        appointment.patientModel.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp),
                                      ),
                                      SizedBox(
                                        width: 100.sp,
                                        child: Divider(
                                          thickness: 1.5.sp,
                                          color: AppColors.secondary,
                                        ),
                                      ),
                                      Text(
                                        appointment.appointmentOn
                                            .getDateStringWithMonthName(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey.shade700),
                                      ),
                                      Text(
                                        appointment.appointmentOn
                                            .getTimeStringInAmPm(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.grey.shade700),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: appointments.length,
                          )
                        : const Center(child: Text('No Appointments'));
                  }
                  return Container();
                }),
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
                const Spacer(),
                CircleAvatar(
                  radius: 10.sp,
                  backgroundColor: Colors.red,
                  child: Obx(() {
                    return Text(
                      getController.appointmentRequests.length.toString(),
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    );
                  }),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8.sp,
          ),
          SizedBox(
            height: 130.sp,
            child: Obx(() {
              return getController.appointmentRequests.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Card(
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
                                          leading: const Icon(
                                            Icons.calendar_today,
                                            color: Colors.green,
                                          ),
                                          title: const Text(
                                            'Set Appointment',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.green),
                                          ),
                                          onTap: () {
                                            Get.to(() => SetAppointmentPage(
                                                  appointmentRequestModel:
                                                      getController
                                                              .appointmentRequests[
                                                          index],
                                                ));
                                          },
                                        ),
                                        const ListTile(
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
                                    getController.appointmentRequests[index]
                                        .patientModel.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp),
                                  ),
                                  SizedBox(
                                    height: 8.sp,
                                  ),
                                  Text(
                                    getController.appointmentRequests[index]
                                        .appointmentFor
                                        .getDateStringWithMonthName(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade700),
                                  ),
                                  Text(
                                    getController.appointmentRequests[index]
                                        .appointmentFor
                                        .getTimeStringInAmPm(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey.shade700),
                                  ),
                                  SizedBox(
                                    height: 4.sp,
                                  ),
                                  SizedBox(
                                    width: 100.sp,
                                    child: Divider(
                                      thickness: 1.sp,
                                      color: AppColors.secondary,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.sp,
                                  ),
                                  const Text('Requested On:'),
                                  Text(
                                    getController
                                        .appointmentRequests[index].requestedOn
                                        .getDateStringWithMonthName(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: getController.appointmentRequests.length,
                    )
                  : const Center(child: Text('No Appointment Requests'));
            }),
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
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const NotificationsPage());
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.sp),
                          child: Stack(
                            children: [
                              Icon(Icons.notifications, size: 24.sp),
                              StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection(AppConstants.doctors)
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.email)
                                      .collection(AppConstants.notifications)
                                      .where('isRead', isEqualTo: false)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<NotificationModel> notifications =
                                          snapshot.data!.docs
                                              .map((e) =>
                                                  NotificationModel.fromJson(e
                                                          .data()
                                                      as Map<String, dynamic>))
                                              .toList();
                                      notifications.removeWhere(
                                          (element) => element.isRead == true);
                                      return Visibility(
                                        visible: notifications.isNotEmpty,
                                        child: Positioned(
                                          top: 0,
                                          right: 0,
                                          child: CircleAvatar(
                                            radius: 8.sp,
                                            backgroundColor: Colors.red,
                                            child: Text(
                                              notifications.length.toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return Container();
                                  }),
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
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const MessagesPageDoctor());
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
                    title: const Text('My Profile'),
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
                    title: const Text('Appointments'),
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
                    title: const Text("Messages"),
                    trailing: CircleAvatar(
                      radius: 10.sp,
                      backgroundColor: Colors.red,
                      child: const Text(
                        '9+',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      Get.to(() => const MessagesPageDoctor());
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
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Get.offAll(() => SelectProfilePage());
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
