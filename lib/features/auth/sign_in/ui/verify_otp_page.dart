import 'package:faridia_healthcare/core/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class VerifyOtpPage extends StatelessWidget {
  final String verificationId;
  final Function(String uid) onVerified;

  const VerifyOtpPage({
    super.key,
    required this.verificationId,
    required this.onVerified,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Verify OTP"),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            Text("Enter the OTP sent to your phone number."),
            SizedBox(
              height: 5.h,
            ),
            OtpTextField(
              numberOfFields: 6,
              borderColor: AppColors.primary,

              showFieldAsBox: true,
              //runs when a code is typed in
              onCodeChanged: (String code) {},
              //runs when every textfield is filled
              onSubmit: (String verificationCode) {
                FirebaseAuth.instance
                    .signInWithCredential(PhoneAuthProvider.credential(
                        verificationId: verificationId,
                        smsCode: verificationCode))
                    .then((value) {
                  onVerified(value.user!.uid);
                }).catchError((onError) {
                  Get.snackbar("Error", onError.toString(),
                      backgroundColor: Colors.red, colorText: Colors.white);
                });
              }, // end onSubmit
            ),
          ],
        ));
  }
}
