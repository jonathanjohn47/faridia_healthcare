import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/core/app_constants.dart';
import 'package:faridia_healthcare/models/chat_channel_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../models/message_model.dart';

class ChatPageGetController extends GetxController {
  final ChatChannelModel chatChannelModel;

  ChatPageGetController(this.chatChannelModel);

  TextEditingController messageController = TextEditingController();
  RxString imageLink = RxString('');

  RxList<MessageModel> allMessages = RxList<MessageModel>([]);

  bool isPatient = false;

  late StreamSubscription<QuerySnapshot> listen;

  void loadMessages() {
    FirebaseFirestore.instance
        .collection(AppConstants.chatChannels)
        .doc(chatChannelModel.id)
        .collection(AppConstants.messages)
        .snapshots()
        .listen((event) {
      allMessages.value =
          event.docs.map((e) => MessageModel.fromJson(e.data())).toList();
      allMessages.sort((a, b) => a.sentAt.compareTo(b.sentAt));
    });
  }

  void loadIfCurrentUserIsPatientOrDoctor() {
    FirebaseFirestore.instance
        .collection(AppConstants.patients)
        .doc(chatChannelModel.patientEmail)
        .get()
        .then((value) {
      isPatient = value.exists;
    });
  }

  void chooseImage() {
    ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        imageLink.value = value.path;
      }
    });
  }

  @override
  void onInit() {
    loadMessages();
    loadIfCurrentUserIsPatientOrDoctor();
    super.onInit();
  }

  @override
  void onClose() {
    listen.cancel();
    super.onClose();
  }

  void sendMessage() async {
    if (messageController.text.trim().isEmpty &&
        imageLink.value.trim().isEmpty) {
      Get.snackbar('Error', 'Cannot send empty message',
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP);
      return;
    }

    Uuid uuid = Uuid();
    String messageId = uuid.v4();
    if (imageLink.value.trim().isNotEmpty) {
      File file = File(imageLink.value.trim());
      String fileName = messageId + '.jpg';
      final firebaseStorageRef =
          FirebaseStorage.instance.ref().child('chat_images/$fileName');
      await firebaseStorageRef.putFile(file).then((taskSnapshot) async {
        imageLink.value = await taskSnapshot.ref.getDownloadURL();
      }).catchError((e) {
        Get.snackbar('Error', 'Failed to upload image: $e');
        return;
      });
    }

    MessageModel msg = MessageModel(
      id: DateTime.now().toString(),
      text: messageController.text.trim(),
      doctorEmail: chatChannelModel.doctorEmail,
      patientEmail: chatChannelModel.patientEmail,
      sentAt: DateTime.now(),
      readByDoctor: !isPatient,
      readByPatient: isPatient,
      imageLink: imageLink.value,
      sentByDoctor: !isPatient,
      sentByPatient: isPatient,
    );

    await FirebaseFirestore.instance
        .collection(AppConstants.chatChannels)
        .doc(chatChannelModel.id)
        .collection(AppConstants.messages)
        .doc(msg.id)
        .set(msg.toJson())
        .then((value) {
      messageController.clear();
      imageLink.value = '';
    }).catchError((e) {
      Get.snackbar('Error', 'Failed to send message: $e');
    });

    await FirebaseFirestore.instance
        .collection(AppConstants.chatChannels)
        .doc(chatChannelModel.id)
        .update({
      'last_message': msg.toJson(),
    }).then((value) {
      messageController.clear();
      imageLink.value = '';
    }).catchError((e) {
      Get.snackbar('Error', 'Failed to update last message: $e');
    });
  }
}
