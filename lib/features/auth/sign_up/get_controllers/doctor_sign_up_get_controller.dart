import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorSignUpGetController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RxBool showPassword = false.obs;
}
