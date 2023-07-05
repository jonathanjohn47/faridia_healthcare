import 'package:faridia_healthcare/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../sign_in/ui/doctor_sign_in.dart';
import '../../sign_in/ui/patient_sign_in.dart';
import '../get_controllers/select_profile_get_controller.dart';

class SelectProfilePage extends StatelessWidget {
  SelectProfilePage({super.key});

  SelectProfileGetController getController =
      Get.put(SelectProfileGetController());

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
          children: <Widget>[
            SizedBox(
              height: 10.h,
            ),
            Text(
              'I am a...',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 22.h,
              child: FloatingActionButton.extended(
                heroTag: null,
                icon: SizedBox(
                    height: 20.h,
                    width: 20.h,
                    child: Image.asset('assets/images/img_491471.png')),
                label: Padding(
                  padding: EdgeInsets.only(left: 8.0.sp),
                  child: Text(
                    'Doctor',
                    style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondary),
                  ),
                ),
                onPressed: () {
                  Get.off(() => DoctorSignInPage());
                },
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 22.h,
              child: FloatingActionButton.extended(
                heroTag: null,
                icon: SizedBox(
                    height: 20.h,
                    width: 20.h,
                    child: Image.asset('assets/images/3727036.png')),
                label: Padding(
                  padding: EdgeInsets.only(left: 8.0.sp),
                  child: Text(
                    'Patient',
                    style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondary),
                  ),
                ),
                onPressed: () {
                  Get.off(() => PatientSignInPage());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
