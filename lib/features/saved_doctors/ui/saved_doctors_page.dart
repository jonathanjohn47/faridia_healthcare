import 'package:faridia_healthcare/core/app_colors.dart';
import 'package:faridia_healthcare/models/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../get_controllers/saved_doctors_get_controller.dart';

class SavedDoctorsPage extends StatelessWidget {
  SavedDoctorsPage({super.key});

  SavedDoctorsGetController savedDoctorsGetController =
      Get.put(SavedDoctorsGetController());

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
                "Saved Doctors",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 8.sp,
              ),
              Divider(
                thickness: 1.5.sp,
                color: AppColors.primary,
              ),
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      DoctorModel doctorModel =
                          savedDoctorsGetController.savedDoctors[index];
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
                                  backgroundImage:
                                      NetworkImage(doctorModel.imageLink),
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
                                        doctorModel.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp),
                                      ),
                                      SizedBox(
                                        height: 1.sp,
                                      ),
                                      Text(
                                        doctorModel.bio,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      savedDoctorsGetController
                                          .deleteFromSavedDoctorsList(
                                              doctorModel);
                                    },
                                    icon: Icon(
                                      Icons.delete_forever,
                                      color: AppColors.secondary,
                                    ))
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 0.2.sp,
                            color: AppColors.secondary,
                            indent: 16.sp,
                            endIndent: 16.sp,
                          ),
                        ],
                      );
                    },
                    itemCount: savedDoctorsGetController.savedDoctors.length,
                  );
                }),
              )
            ],
          ),
        ));
  }
}
