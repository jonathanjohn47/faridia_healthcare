import 'package:faridia_healthcare/features/auth/sign_in/get_controller/patient_sign_in_get_controller.dart';
import 'package:faridia_healthcare/features/home/ui/patient_home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_colors.dart';
import '../../sign_up/ui/patient_sign_up_page.dart';

class PatientSignInPage extends StatelessWidget {
  PatientSignInPage({super.key});

  PatientSignInGetController getController =
      Get.put(PatientSignInGetController());

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
                height: 30.h, child: Image.asset('assets/images/3727036.png')),
            Text('Login as Patient',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 8.sp,
            ),
            /*TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool showPassword = false.obs;*/
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton.extended(
                  heroTag: null,
                  onPressed: () {
                    Get.offAll(() => PatientHomePage());
                  },
                  label: Padding(
                    padding: EdgeInsets.all(16.0.sp),
                    child: Text(
                      'Login',
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
                  'Don\'t have an account?',
                  style: TextStyle(fontSize: 12.sp),
                ),
                TextButton(
                  onPressed: () {
                    Get.off(() => PatientSignUpPage());
                  },
                  child: Text(
                    'Sign Up',
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
