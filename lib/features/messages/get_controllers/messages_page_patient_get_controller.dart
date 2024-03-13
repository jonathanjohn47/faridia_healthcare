import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/core/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../models/chat_channel_model.dart';

class MessagesPagePatientGetController extends GetxController {
  RxList<ChatChannelModel> chatChannels = RxList<ChatChannelModel>([]);

  late StreamSubscription<QuerySnapshot> listen;

  void loadChatChannels() {
    listen = FirebaseFirestore.instance
        .collection(AppConstants.chatChannels)
        .where('patient_email',
            isEqualTo: FirebaseAuth.instance.currentUser!.uid!)
        .snapshots()
        .listen((event) {
      chatChannels.value =
          event.docs.map((e) => ChatChannelModel.fromJson(e.data())).toList();
      chatChannels
          .sort((a, b) => a.lastMessage.sentAt.compareTo(b.lastMessage.sentAt));
    });
  }

  @override
  void onInit() {
    loadChatChannels();
    super.onInit();
  }

  @override
  void onClose() {
    listen.cancel();
    super.onClose();
  }
}
