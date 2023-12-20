import 'package:faridia_healthcare/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../models/chat_channel_model.dart';
import '../get_controllers/chat_page_get_controller.dart';
import 'chat_bubble.dart';

class ChatPage extends StatelessWidget {
  final ChatChannelModel chatChannel;

  ChatPage({super.key, required this.chatChannel});

  @override
  Widget build(BuildContext context) {
    ChatPageGetController getController =
        Get.put(ChatPageGetController(chatChannelModel: chatChannel));
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(2.0),
          child: Obx(() {
            return getController.isPatient.value
                ? CircleAvatar(
                    backgroundImage:
                        NetworkImage(chatChannel.doctorModel.imageLink),
                  )
                : chatChannel.patientModel.imageLink != null
                    ? CircleAvatar(
                        backgroundImage:
                            NetworkImage(chatChannel.patientModel.imageLink!),
                      )
                    : CircleAvatar(
                        child: Text(chatChannel.patientModel.name[0]),
                      );
          }),
        ),
        title: Obx(() {
          return Text(getController.isPatient.value
              ? chatChannel.doctorModel.name
              : chatChannel.patientModel.name);
        }),
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return getController.allMessages.isNotEmpty
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        MessageModel messageModel =
                            getController.allMessages[index];
                        return ChatBubble(
                            sentByMe: getController.isPatient.value &&
                                    messageModel.sentByPatient ||
                                !getController.isPatient.value &&
                                    !messageModel.sentByPatient,
                            messageModel: messageModel);
                      },
                      itemCount: getController.allMessages.length,
                    )
                  : Center(
                      child: Text('No Message Yet'),
                    );
            }),
          ),
          Obx(
            () {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // Image preview
                    if (getController.imageLink.value.isNotEmpty)
                      Stack(
                        children: [
                          Image.network(getController.imageLink.value),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  getController.imageLink.value = '';
                                },
                              )),
                        ],
                      ),
                    // Message input
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: getController.messageController,
                            decoration: InputDecoration(
                                hintText: "Type message here..."),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.attach_file),
                          onPressed: () async {
                            getController.chooseImage();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            getController.sendMessage();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
