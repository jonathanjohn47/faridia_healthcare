import 'package:faridia_healthcare/features/splash/get_controllers/splash_get_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  SplashGetController getController = Get.put(SplashGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: FadeTransition(
          opacity: getController.animationController,
          child: Image.asset("assets/images/Faridia Healthcare-03.png")),
    ));
  }
}
