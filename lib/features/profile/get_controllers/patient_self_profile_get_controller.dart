import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PatientSelfProfileGetController extends GetxController {
  //name, phone number, email, address
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  RxBool editMode = false.obs;

  @override
  void onInit() {
    nameController.text = 'John Doe';
    phoneNumberController.text = '01700000000';
    emailController.text = 'johndoe@gmail.com';
    addressController.text = 'Dhaka, Bangladesh';
    super.onInit();
  }
}
