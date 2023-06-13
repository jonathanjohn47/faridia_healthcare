import 'package:faridia_healthcare/features/auth/sign_in/ui/patient_sign_in.dart';
import 'package:faridia_healthcare/features/auth/sign_up/get_controllers/patient_sign_up_get_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_colors.dart';
import '../../sign_in/ui/doctor_sign_in.dart';

class PatientSignUpPage extends StatelessWidget {
  PatientSignUpPage({super.key});

  PatientSignUpGetController getController =
      Get.put(PatientSignUpGetController());

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
        child: ListView(
          children: [
            SizedBox(
              height: 8.sp,
            ),
            SizedBox(
                height: 30.h,
                child: Image.asset('assets/images/3727036.png')),
            Text('Sign Up as Patient',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 8.sp,
            ),
            /*TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();



  RxBool showPassword = false.obs;*/
            TextFormField(
              controller: getController.nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 8.sp,
            ),
            TextFormField(
              controller: getController.emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 8.sp,
            ),
            Obx(() {
              return TextFormField(
                controller: getController.passwordController,
                obscureText: !getController.showPassword.value,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      getController.showPassword.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      getController.showPassword.toggle();
                    },
                  ),
                ),
              );
            }),
            SizedBox(
              height: 8.sp,
            ),
            Obx(() {
              return TextFormField(
                controller: getController.confirmPasswordController,
                obscureText: !getController.showPassword.value,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      getController.showPassword.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      getController.showPassword.toggle();
                    },
                  ),
                ),
              );
            }),
            SizedBox(
              height: 8.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton.extended(
                  heroTag: null,
                  onPressed: () {},
                  label: Padding(
                    padding: EdgeInsets.all(16.0.sp),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(fontSize: 12.sp),
                ),
                TextButton(
                  onPressed: () {
                    Get.off(() => PatientSignInPage());
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
