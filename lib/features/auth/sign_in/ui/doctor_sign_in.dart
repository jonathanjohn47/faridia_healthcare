import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_colors.dart';
import '../get_controller/doctor_sign_in_get_controller.dart';

class DoctorSignInPage extends StatelessWidget {
  DoctorSignInPage({super.key});

  DoctorSignInGetController getController =
      Get.put(DoctorSignInGetController());

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
                child: Image.asset('assets/images/img_491471.png')),
            Text('Login as Doctor',
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
                  onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}
