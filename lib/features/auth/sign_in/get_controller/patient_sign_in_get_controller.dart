import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientSignInGetController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool showPassword = false.obs;
}
