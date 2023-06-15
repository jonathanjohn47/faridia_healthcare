import 'package:faridia_healthcare/features/auth/select_profile/ui/select_profile_page.dart';
import 'package:faridia_healthcare/features/profile/ui/patient_self_profile_page.dart';
import 'package:faridia_healthcare/features/search_for_doctors/ui/search_for_doctors_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_colors.dart';
import '../../appointments/ui/appointments_page.dart';
import '../../messages/ui/messages_page.dart';
import '../../saved_doctors/ui/saved_doctors_page.dart';

class PatientHomePage extends StatelessWidget {
  const PatientHomePage({super.key});

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
            child: ListView.builder(
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
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Dr. John Doe',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp),
                                ),
                                SizedBox(
                                  width: 8.sp,
                                ),
                                const Expanded(
                                  child: Text(
                                    '(Dentist)',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 1.5.sp,
                              color: AppColors.secondary,
                            ),
                            Table(
                              columnWidths: const {
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(0.1),
                                2: FlexColumnWidth(2),
                              },
                              children: const [
                                TableRow(children: [
                                  Text('Date'),
                                  Text(':'),
                                  Text(
                                    '12/12/2021',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ]),
                                TableRow(children: [
                                  Text('Time'),
                                  Text(':'),
                                  Text(
                                    '12:00 PM',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ]),
                                TableRow(children: [
                                  Text('Address'),
                                  Text(':'),
                                  Text(
                                    '10 Downing Street, London',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ]),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    onPressed: () {},
                  ),
                );
              },
              itemCount: 5,
            ),
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
                        onTap: () {},
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
                      const Spacer(),
                      GestureDetector(
                        onTap: () {},
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
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 4.0.sp, horizontal: 8.sp),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 30.sp,
                            backgroundImage: const NetworkImage(
                                'https://g.foolcdn.com/image/?url=https%3A//g.foolcdn.com/editorial/images/64791/gettyimages-852090066_8cTQuWD.jpg&w=2000&op=resize'),
                          ),
                          SizedBox(
                            width: 8.sp,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dr. John Doe',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp),
                              ),
                              SizedBox(
                                height: 1.sp,
                              ),
                              const Text(
                                'Dentist',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 1.sp,
                              ),
                              const Text(
                                'MBBS, BDS, MDS',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 1.sp,
                              ),
                              const Text(
                                '10 years of experience',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                        ],
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
              itemCount: 10,
            ),
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
                    title: Text('Appointments'),
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
                    trailing: CircleAvatar(
                      radius: 10.sp,
                      backgroundColor: Colors.red,
                      child: const Text(
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
                  ListTile(
                    title: const Text("Saved Doctors"),
                    trailing: CircleAvatar(
                      radius: 10.sp,
                      backgroundColor: Colors.blueAccent,
                      child: const Text(
                        '5',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
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
                  Get.offAll(() => const SelectProfilePage());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
