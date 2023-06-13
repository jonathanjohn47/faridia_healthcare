import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DoctorSignInGetController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool showPassword = false.obs;
}
