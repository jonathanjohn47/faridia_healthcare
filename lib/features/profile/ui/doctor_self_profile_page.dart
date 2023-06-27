import 'dart:io';

import 'package:faridia_healthcare/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../get_controllers/doctor_self_profile_page_get_controller.dart';

class DoctorSelfProfilePage extends StatelessWidget {
  DoctorSelfProfilePage({super.key});

  DoctorSelfProfilePageGetController getController =
      Get.put(DoctorSelfProfilePageGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(
            color: AppColors.primary,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.0.sp),
          child: ListView(
            children: [
              //about, services, education, experience, awards and recognitions, clinic address
              SizedBox(
                height: 8.sp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Obx(() {
                        return getController.imagePicked.value
                            ? CircleAvatar(
                                radius: 50.sp,
                                backgroundImage: FileImage(
                                  File(getController.imageLink.value),
                                ),
                              )
                            : getController.imageLink.value.isEmpty
                                ? CircleAvatar(
                                    radius: 50.sp,
                                    backgroundImage: const AssetImage(
                                      'assets/images/img_491471.png',
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 50.sp,
                                    backgroundImage: NetworkImage(
                                      getController.imageLink.value,
                                    ),
                                  );
                      }),
                      Obx(() {
                        return Visibility(
                          visible: getController.editMode.value,
                          child: Positioned(
                            bottom: 0,
                            right: 0,
                            child: FloatingActionButton(
                              heroTag: null,
                              backgroundColor: AppColors.secondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.sp),
                              ),
                              onPressed: () {
                                getController.getPhoto();
                              },
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 8.sp,
              ),
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(3),
                },
                children: [
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.only(top: 15.sp),
                      child: Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 13.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Obx(() {
                      return getController.editMode.value
                          ? TextFormField(
                              controller: getController.nameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            )
                          : StreamBuilder<String>(
                              stream: Stream.periodic(
                                  const Duration(milliseconds: 100), (_) {
                                return getController.nameController.text;
                              }),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 15.sp),
                                    child: Text(
                                      snapshot.data!,
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  );
                                }
                                return Container();
                              });
                    }),
                  ])
                ],
              ),
              SizedBox(
                height: 8.sp,
              ),
              Divider(
                thickness: 1.5.sp,
              ),
              SizedBox(
                height: 8.sp,
              ),
              Text(
                'Bio',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
              ),
              Obx(() {
                return getController.editMode.value
                    ? TextFormField(
                        controller: getController.bioController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText:
                              'e.g\nGynocologist\nMBBS, MD, PhD\n10 years of experience',
                        ),
                      )
                    : StreamBuilder<String>(
                        stream: Stream.periodic(
                            const Duration(milliseconds: 100), (_) {
                          return getController.bioController.text;
                        }),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data!);
                          }
                          return Container();
                        });
              }),
              SizedBox(
                height: 8.sp,
              ),
              Text(
                'About',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
              ),
              Obx(() {
                return getController.editMode.value
                    ? TextFormField(
                        controller: getController.aboutController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText:
                              'Write something about yourself in short...',
                        ),
                      )
                    : StreamBuilder<String>(
                        stream: Stream.periodic(
                            const Duration(milliseconds: 100), (_) {
                          return getController.aboutController.text;
                        }),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data!);
                          }
                          return Container();
                        });
              }),
              SizedBox(
                height: 8.sp,
              ),
              Text(
                'Services',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
              ),
              Obx(() {
                return getController.editMode.value
                    ? TextFormField(
                        controller: getController.servicesController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText:
                              'What are the services you offer? e.g. Dental Care, Eye Care, etc.',
                        ),
                      )
                    : StreamBuilder<String>(
                        stream: Stream.periodic(
                            const Duration(milliseconds: 100), (_) {
                          return getController.servicesController.text;
                        }),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data!);
                          }
                          return Container();
                        });
              }),
              SizedBox(
                height: 8.sp,
              ),
              Text(
                'Experience',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
              ),
              Obx(() {
                return getController.editMode.value
                    ? TextFormField(
                        controller: getController.experienceController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText:
                              'Write about your best work experience. e.g. 5 years of experience as Gynocologist in AIIMS etc.',
                        ),
                      )
                    : StreamBuilder<String>(
                        stream: Stream.periodic(
                            const Duration(milliseconds: 100), (_) {
                          return getController.experienceController.text;
                        }),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data!);
                          }
                          return Container();
                        });
              }),
              SizedBox(
                height: 8.sp,
              ),
              Text(
                'Awards and Recognitions',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
              ),
              Obx(() {
                return getController.editMode.value
                    ? TextFormField(
                        controller:
                            getController.awardsAndRecognitionsController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText:
                              'This will make you stand out. You know what to write here...',
                        ),
                      )
                    : StreamBuilder<String>(
                        stream: Stream.periodic(
                            const Duration(milliseconds: 100), (_) {
                          return getController
                              .awardsAndRecognitionsController.text;
                        }),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data!);
                          }
                          return Container();
                        });
              }),
              SizedBox(
                height: 8.sp,
              ),
              Text(
                'Clinic/Hospital Address',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
              ),
              Obx(() {
                return getController.editMode.value
                    ? TextFormField(
                        controller: getController.clinicAddressController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText:
                              'Where do you see patients? e.g. AIIMS, New Delhi',
                        ),
                      )
                    : StreamBuilder<String>(
                        stream: Stream.periodic(
                            const Duration(milliseconds: 100), (_) {
                          return getController.clinicAddressController.text;
                        }),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data!);
                          }
                          return Container();
                        });
              }),
              SizedBox(
                height: 8.sp,
              ),
              Divider(
                thickness: 1.5.sp,
              ),
              SizedBox(
                height: 8.sp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.extended(
                    heroTag: null,
                    onPressed: () {
                      getController.editMode.toggle();
                    },
                    label: Obx(() {
                      return Text(
                        getController.editMode.value ? 'Save' : 'Edit',
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w500),
                      );
                    }),
                    icon: Obx(() {
                      return Icon(getController.editMode.value
                          ? Icons.upload
                          : Icons.edit);
                    }),
                  )
                ],
              ),
              SizedBox(
                height: 8.sp,
              ),
            ],
          ),
        ));
  }
}
