import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:faridia_healthcare/core/app_colors.dart';
import 'package:faridia_healthcare/features/profile/get_controllers/patient_self_profile_get_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PatientSelfProfilePage extends StatelessWidget {
  PatientSelfProfilePage({super.key});

  PatientSelfProfileGetController getController =
      Get.put(PatientSelfProfileGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(
            color: AppColors.primary,
          ),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 8.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Obx(() {
                      return !getController.uploadNewPhoto.value
                          ? getController.imageLink.value.isNotEmpty
                              ? CircleAvatar(
                                  radius: 50.sp,
                                  backgroundImage: NetworkImage(
                                    getController.imageLink.value,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 50.sp,
                                  backgroundImage: const AssetImage(
                                    'assets/images/3727036.png',
                                  ),
                                )
                          : CircleAvatar(
                              radius: 50.sp,
                              backgroundImage: FileImage(
                                File(getController.imageLink.value),
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
                              getController.getImage();
                            },
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 8.sp,
            ),
            Divider(
              thickness: 1.5.sp,
              indent: 16.sp,
              endIndent: 16.sp,
            ),
            SizedBox(
              height: 8.sp,
            ),
            Obx(() {
              return getController.editMode.value
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: getController.nameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              labelText: 'Name',
                              // other properties...
                            ),
                          ),
                          SizedBox(
                            height: 8.sp,
                          ),
                          TextFormField(
                            controller: getController.phoneNumberController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              labelText: 'Phone Number',
                              // other properties...
                            ),
                          ),
                          SizedBox(
                            height: 8.sp,
                          ),
                          TextFormField(
                            controller: getController.addressController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              labelText: 'Address',
                              // other properties...
                            ),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.sp),
                      child: Table(
                        columnWidths: const {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(2),
                        },
                        children: [
                          //name, phone number, email, address
                          TableRow(children: [
                            const Text('Name'),
                            Text(
                              getController.name.value,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w600),
                            )
                          ]),
                          TableRow(children: [
                            const Text('Phone Number'),
                            Text(
                              getController.phoneNumber.value,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w600),
                            )
                          ]),
                          TableRow(children: [
                            const Text('Email'),
                            AutoSizeText(
                              getController.email.value,
                              textAlign: TextAlign.end,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            )
                          ]),
                          TableRow(children: [
                            const Text('Address'),
                            AutoSizeText(
                              getController.address.value,
                              textAlign: TextAlign.end,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            )
                          ]),
                        ],
                      ),
                    );
            }),
            SizedBox(
              height: 8.sp,
            ),
            Divider(
              thickness: 1.5.sp,
              indent: 16.sp,
              endIndent: 16.sp,
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
                    if (getController.editMode.value) {
                      getController.save();
                    }
                    getController.editMode.toggle();
                  },
                  label: Obx(() {
                    return Text(getController.editMode.value ? 'Save' : 'Edit',
                        style: TextStyle(fontSize: 14.sp));
                  }),
                ),
              ],
            )
          ],
        ));
  }
}
