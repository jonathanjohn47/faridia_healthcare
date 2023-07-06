import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/core/app_constants.dart';
import 'package:faridia_healthcare/features/auth/select_profile/ui/select_profile_page.dart';
import 'package:faridia_healthcare/features/home/get_controllers/patient_home_page_get_controller.dart';
import 'package:faridia_healthcare/features/profile/ui/patient_self_profile_page.dart';
import 'package:faridia_healthcare/features/search_for_doctors/ui/search_for_doctors_page.dart';
import 'package:faridia_healthcare/models/appointment_model.dart';
import 'package:faridia_healthcare/models/doctor_model.dart';
import 'package:faridia_healthcare/notifications/ui/notifications_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import '../../../core/app_colors.dart';
import '../../../models/notification_model.dart';
import '../../appointments/ui/appointments_page.dart';
import '../../messages/ui/messages_page_patient.dart';
import '../../profile/ui/doctor_profile_page.dart';
import '../../request_appointment/ui/request_appointment_page.dart';
import '../../saved_doctors/ui/saved_doctors_page.dart';

class PatientHomePage extends StatelessWidget {
  PatientHomePage({super.key});

  PatientHomePageGetController patientHomePageGetController =
      Get.put(PatientHomePageGetController());

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
                Get.to(() => PatientSelfProfilePage());
              },
              icon: const Icon(Icons.person))
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 8.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
            child: Text(
              'Appointments',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 4.sp,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 20.h,
              maxHeight: 22.h,
            ),
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(AppConstants.appointments)
                    .where('patient_email',
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
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FloatingActionButton.extended(
                                  heroTag: null,
                                  elevation: 2,
                                  label: Padding(
                                    padding: EdgeInsets.all(8.0.sp),
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        minWidth: 30.w,
                                        maxWidth: 50.w,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Dr. ${appointments[index].doctorModel.name}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14.sp),
                                          ),
                                          SizedBox(
                                            height: 2.sp,
                                          ),
                                          Text(
                                            "(${appointments[index].doctorModel.bio})",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 8.sp),
                                          ),
                                          Divider(
                                            thickness: 1.5.sp,
                                            color: AppColors.secondary,
                                          ),
                                          Table(
                                            columnWidths: const {
                                              0: FlexColumnWidth(1),
                                              2: FlexColumnWidth(1),
                                            },
                                            children: const [
                                              TableRow(children: [
                                                AutoSizeText(
                                                  '12/12/2021',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  '12:00 PM',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ]),
                                            ],
                                          ),
                                          const AutoSizeText(
                                            '10 Downing Street, London',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    patientHomePageGetController
                                        .initiateAppointmentMeeting(
                                            appointments[index]);
                                  },
                                ),
                              );
                            },
                            itemCount: appointments.length,
                          )
                        : const Center(
                            child: Text('No Appointments'),
                          );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
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
                                      .collection(AppConstants.patients)
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.email)
                                      .collection(AppConstants.notifications)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    List<NotificationModel> allNotifications =
                                        snapshot.data!.docs
                                            .map((e) =>
                                                NotificationModel.fromJson(
                                                    jsonDecode(
                                                        jsonEncode(e.data()))))
                                            .toList();
                                    allNotifications.removeWhere(
                                        (element) => element.isRead == true);
                                    if (snapshot.hasData) {
                                      if (allNotifications.isNotEmpty) {
                                        return Positioned(
                                          top: 0,
                                          right: 0,
                                          child: CircleAvatar(
                                            radius: 8.sp,
                                            backgroundColor: Colors.red,
                                            child: Text(
                                              allNotifications.length
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.sp,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      return Container();
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
                          Get.to(() => const MessagesPagePatient());
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.sp),
                          child: Stack(
                            children: [
                              Icon(Icons.chat, size: 24.sp),
                              Obx(() {
                                return Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Visibility(
                                    visible: patientHomePageGetController
                                            .unreadMessages.value >
                                        0,
                                    child: CircleAvatar(
                                      radius: 8.sp,
                                      backgroundColor: Colors.red,
                                      child: Text(
                                        patientHomePageGetController
                                            .unreadMessages.value
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
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
                ],
              ),
            ),
          ),
          Divider(
            thickness: 1.5.sp,
            color: AppColors.secondary,
            indent: 16.sp,
            endIndent: 16.sp,
          ),
          SizedBox(
            height: 8.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
            child: Text(
              'Top Doctors',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 4.sp,
          ),
          SizedBox(
            height: 40.h,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(AppConstants.doctors)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<DoctorModel> doctors = snapshot.data!.docs
                        .map((e) => DoctorModel.fromJson(
                            jsonDecode(jsonEncode(e.data()))))
                        .toList();
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        DoctorModel doctor = doctors[index];
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(() => DoctorProfilePage(
                                      doctorModel: doctor,
                                    ));
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4.0.sp, horizontal: 8.sp),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 30.sp,
                                      backgroundImage:
                                          NetworkImage(doctor.imageLink),
                                    ),
                                    SizedBox(
                                      width: 8.sp,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            doctor.name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.sp),
                                          ),
                                          SizedBox(
                                            height: 1.sp,
                                          ),
                                          Text(
                                            doctor.bio,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 0.5.sp,
                              color: AppColors.primary,
                              indent: 16.sp,
                              endIndent: 16.sp,
                            ),
                          ],
                        );
                      },
                      itemCount: doctors.length,
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          )
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
                      Get.to(() => PatientSelfProfilePage());
                    },
                  ),
                  Divider(
                    thickness: 0.5.sp,
                    color: AppColors.primary,
                    indent: 10.sp,
                    endIndent: 10.sp,
                  ),
                  ListTile(
                    title: const Text('Search For Doctors'),
                    onTap: () {
                      Get.to(() => SearchForDoctorsPage());
                    },
                  ),
                  Divider(
                    thickness: 0.5.sp,
                    color: AppColors.primary,
                    indent: 10.sp,
                    endIndent: 10.sp,
                  ),
                  ListTile(
                    title: const Text('Request an Appointment'),
                    onTap: () {
                      Get.to(() => const RequestAppointmentPage());
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
                      Get.to(() => AppointmentsPage());
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
                    trailing: Obx(() {
                      return Visibility(
                        visible:
                            patientHomePageGetController.unreadMessages.value >
                                0,
                        child: CircleAvatar(
                          radius: 10.sp,
                          backgroundColor: Colors.red,
                          child: Text(
                            patientHomePageGetController.unreadMessages.value
                                .toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }),
                    onTap: () {
                      Get.to(() => const MessagesPagePatient());
                    },
                  ),
                  Divider(
                    thickness: 0.5.sp,
                    color: AppColors.primary,
                    indent: 10.sp,
                    endIndent: 10.sp,
                  ),
                  ListTile(
                    title: const Text("Saved Doctors"),
                    trailing: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection(AppConstants.patients)
                            .doc(FirebaseAuth.instance.currentUser!.email)
                            .collection(AppConstants.savedDoctors)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.docs.isNotEmpty) {
                              return CircleAvatar(
                                radius: 10.sp,
                                backgroundColor: Colors.blueAccent,
                                child: Text(
                                  snapshot.data!.docs.length.toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            }
                            return const SizedBox(
                              height: 0,
                              width: 0,
                            );
                          }
                          return const SizedBox(
                            height: 0,
                            width: 0,
                          );
                        }),
                    onTap: () {
                      Get.to(() => SavedDoctorsPage());
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
                  try {
                    ZIM.getInstance()!.logout();
                    ZIM.getInstance()!.destroy();
                  } catch (e) {
                    // TODO
                  }
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
