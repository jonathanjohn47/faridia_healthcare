import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_colors.dart';
import '../../sign_in/ui/doctor_sign_in.dart';
import '../get_controllers/doctor_sign_up_get_controller.dart';

class DoctorSignUpPage extends StatelessWidget {
  DoctorSignUpPage({super.key});

  DoctorSignUpGetController getController =
      Get.put(DoctorSignUpGetController());

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
            SizedBox(
              height: 8.sp,
            ),
            SizedBox(
                height: 30.h,
                child: Image.asset('assets/images/img_491471.png')),
            Text('Sign Up as Doctor',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 8.sp,
            ),
            /*TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();



  RxBool showPassword = false.obs;*/
            TextFormField(
              controller: getController.nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 8.sp,
            ),
            TextFormField(
              controller: getController.phoneController,
              decoration: const InputDecoration(
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
                  border: const OutlineInputBorder(),
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
                  border: const OutlineInputBorder(),
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
                    Get.off(() => DoctorSignInPage());
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
