import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/models/patient_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import '../../../core/app_constants.dart';

class PatientHomePageGetController extends GetxController {
  RxInt unreadMessages = 0.obs;

  @override
  void onInit() {
    zegoLogin().then((value) {
      getUnreadMessages();
    });
    super.onInit();
  }

  Future<void> zegoLogin() async {
    await FirebaseFirestore.instance
        .collection(AppConstants.patients)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) async {
      PatientModel patientModel =
          PatientModel.fromJson(jsonDecode(jsonEncode(value.data())));
      await ZIMKit().connectUser(
        id: FirebaseAuth.instance.currentUser!.email!,
        name: patientModel.name,
        avatarUrl: patientModel.imageLink,
      );
      ZIMKitConversation zimKitConversation = ZIMKitConversation();
    });
  }

  void getUnreadMessages() {
    ZIMConversationQueryConfig conversationQueryConfig =
        ZIMConversationQueryConfig();
    conversationQueryConfig.nextConversation = null;
// The number of queries per page.
    conversationQueryConfig.count = 20;

//Get the session list.
    ZIM
        .getInstance()!
        .queryConversationList(conversationQueryConfig)
        .then((value) => {
              value.conversationList.forEach((element) {
                unreadMessages.value += element.unreadMessageCount;
              })
            })
        .catchError((onError) {});
  }
}
