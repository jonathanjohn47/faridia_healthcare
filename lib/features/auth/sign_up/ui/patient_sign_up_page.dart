import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:faridia_healthcare/features/auth/sign_in/ui/patient_sign_in.dart';
import 'package:faridia_healthcare/features/auth/sign_up/get_controllers/patient_sign_up_get_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_colors.dart';

class PatientSignUpPage extends StatelessWidget {
  PatientSignUpPage({super.key});

  PatientSignUpGetController getController =
      Get.put(PatientSignUpGetController());

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
        child: Form(
          key: getController.formKey,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sign Up as Patient',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              SizedBox(
                height: 8.sp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Obx(() {
                        return getController.imagePath.value!.isEmpty
                            ? CircleAvatar(
                                radius: 50.sp,
                                backgroundImage: const AssetImage(
                                  'assets/images/3727036.png',
                                ),
                              )
                            : CircleAvatar(
                                radius: 50.sp,
                                backgroundImage: FileImage(
                                  File(getController.imagePath.value),
                                ),
                              );
                      }),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: FloatingActionButton(
                          heroTag: null,
                          onPressed: () {
                            getController.chooseImage();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.sp),
                          ),
                          backgroundColor: AppColors.secondary,
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 8.sp,
              ),
              TextFormField(
                controller: getController.nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 8.sp,
              ),
              TextFormField(
                controller: getController.phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                  prefixIcon: CountryCodePicker(
                    onChanged: (value) {
                      getController.countryCode = value;
                    },
                    // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                    initialSelection: 'IN',
                    favorite: ['+91', 'IN'],
                    // optional. Shows only country name and flag
                    showCountryOnly: false,
                    // optional. Shows only country name and flag when popup is closed.
                    showOnlyCountryWhenClosed: false,
                    // optional. aligns the flag and the Text left
                    alignLeft: false,
                  ),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 8.sp,
              ),
              TextFormField(
                controller: getController.addressController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 8.sp,
              ),
              Divider(
                thickness: 0.5.sp,
                color: AppColors.primary,
              ),
              SizedBox(
                height: 8.sp,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    return getController.showLoader.value
                        ? const CircularProgressIndicator()
                        : FloatingActionButton.extended(
                            heroTag: null,
                            onPressed: () {
                              getController.signUpAsPatient();
                            },
                            label: Padding(
                              padding: EdgeInsets.all(16.0.sp),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          );
                  }),
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
      ),
    );
  }
}
