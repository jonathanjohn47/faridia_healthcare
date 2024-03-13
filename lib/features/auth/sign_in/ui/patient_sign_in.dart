import 'package:country_code_picker/country_code_picker.dart';
import 'package:faridia_healthcare/features/auth/sign_in/get_controller/patient_sign_in_get_controller.dart';
import 'package:faridia_healthcare/features/auth/sign_in/ui/doctor_sign_in.dart';
import 'package:faridia_healthcare/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
        preferredSize: const Size.fromHeight(0),
        child: Container(
          color: AppColors.primary,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.0.sp),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: getController.formKey,
                child: ListView(
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    SizedBox(
                        height: 30.h,
                        child: Image.asset('assets/images/3727036.png')),
                    Text('Login as Patient',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(
                      height: 3.h,
                    ),
                    /*TextEditingController phoneController = TextEditingController();
                TextEditingController passwordController = TextEditingController();

                RxBool showPassword = false.obs;*/
                    TextFormField(
                      controller: getController.phoneController,
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
                      height: 3.h,
                    ),
                    StandardButton(
                        onPressed: () {}, title: "Send Verification Code"),
                    SizedBox(
                      height: 3.h,
                    ),
                    SizedBox(
                      height: 3.h,
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                StandardButton(
                  onPressed: () {
                    Get.offAll(() => DoctorSignInPage());
                  },
                  title: "Doctor Sign In",
                  icon: MdiIcons.doctor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
