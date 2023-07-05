import 'package:faridia_healthcare/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../models/doctor_model.dart';
import '../get_controllers/doctor_profile_get_controller.dart';

class DoctorProfilePage extends StatelessWidget {
  final DoctorModel doctorModel;

  const DoctorProfilePage({super.key, required this.doctorModel});

  @override
  Widget build(BuildContext context) {
    DoctorProfileGetController doctorProfileGetController =
        Get.put(DoctorProfileGetController(doctorModel));
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.sp),
                color: AppColors.secondary.withOpacity(0.1),
              ),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 4.0.sp, horizontal: 4.sp),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30.sp,
                      backgroundImage: NetworkImage(
                        doctorModel.imageLink,
                      ),
                    ),
                    SizedBox(
                      width: 8.sp,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctorModel.name,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16.sp),
                          ),
                          SizedBox(
                            height: 1.sp,
                          ),
                          Text(
                            doctorModel.bio,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8.sp,
            ),
            Divider(
              color: AppColors.primary,
              thickness: 1.5.sp,
            ),
            SizedBox(
              height: 8.sp,
            ),
            Text('About',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.secondary)),
            SizedBox(
              height: 8.sp,
            ),
            SizedBox(
              height: 25.h,
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(doctorModel.about),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8.sp,
            ),
            Text('Services',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.secondary)),
            SizedBox(
              height: 8.sp,
            ),
            SizedBox(
              height: 25.h,
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(doctorModel.services,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: AppColors.secondary.withOpacity(0.7))),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8.sp,
            ),
            Text('Education',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.secondary)),
            SizedBox(
              height: 8.sp,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(doctorModel.education,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: AppColors.secondary.withOpacity(0.7))),
            ),
            SizedBox(
              height: 8.sp,
            ),
            Text('Experience',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.secondary)),
            SizedBox(
              height: 8.sp,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(doctorModel.experience,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: AppColors.secondary.withOpacity(0.7))),
            ),
            SizedBox(
              height: 8.sp,
            ),
            Text('Awards and Recognitions',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.secondary)),
            SizedBox(
              height: 8.sp,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(doctorModel.awardsAndRecognitions,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: AppColors.secondary.withOpacity(0.7))),
            ),
            SizedBox(
              height: 8.sp,
            ),
            Text('Clinic Address',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.secondary)),
            SizedBox(
              height: 8.sp,
            ),
            Text(doctorModel.clinicAddress,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: AppColors.secondary.withOpacity(0.7))),
            Divider(
              thickness: 1.5.sp,
              color: AppColors.primary,
            ),
            SizedBox(
              height: 8.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      doctorProfileGetController.saveDoctor();
                    },
                    label: Row(
                      children: [
                        const Icon(Icons.bookmark),
                        SizedBox(
                          width: 5.sp,
                        ),
                        Text(
                          'Save',
                          style: TextStyle(fontSize: 12.sp),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.sp,
                ),
                Expanded(
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      doctorProfileGetController.chatWithDoctor();
                    },
                    label: Row(
                      children: [
                        Icon(MdiIcons.chat),
                        SizedBox(
                          width: 5.sp,
                        ),
                        Text(
                          'Chat',
                          style: TextStyle(fontSize: 12.sp),
                        )
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
    );
  }
}
