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
          preferredSize: Size.fromHeight(0),
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
                    CircleAvatar(
                      radius: 50.sp,
                      backgroundImage: AssetImage(
                        'assets/images/3727036.png',
                      ),
                    ),
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
                            onPressed: () {},
                            child: Icon(
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
                            controller: getController.emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              labelText: 'Email',
                              // other properties...
                            ),
                          ),
                          SizedBox(
                            height: 8.sp,
                          ),
                          TextFormField(
                            controller: getController.addressController,
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
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(2),
                        },
                        children: [
                          //name, phone number, email, address
                          TableRow(children: [
                            Text('Name'),
                            Text(
                              'John Doe',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w600),
                            )
                          ]),
                          TableRow(children: [
                            Text('Phone Number'),
                            Text(
                              '+880 1234567890',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w600),
                            )
                          ]),
                          TableRow(children: [
                            Text('Email'),
                            Text(
                              'johndoe@gmail.com',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w600),
                            )
                          ]),
                          TableRow(children: [
                            Text('Address'),
                            Text(
                              'Dhaka, Bangladesh',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w600),
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
