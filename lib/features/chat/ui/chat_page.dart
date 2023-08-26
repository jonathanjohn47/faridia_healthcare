import 'package:faridia_healthcare/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../models/chat_channel_model.dart';
import '../get_controllers/chat_page_get_controller.dart';
import 'chat_bubble.dart';

class ChatPage extends StatelessWidget {
  final ChatChannelModel chatChannel;

  const ChatPage({super.key, required this.chatChannel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          color: AppColors.primary,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GetX<ChatPageGetController>(
                init: ChatPageGetController(chatChannel),
                builder: (controller) {
                  return controller.allMessages.isNotEmpty
                      ? ListView.builder(
                          itemBuilder: (context, index) {
                            MessageModel messageModel =
                                controller.allMessages[index];
                            return ChatBubble(
                                isPatient: controller.isPatient,
                                messageModel: messageModel);
                          },
                          itemCount: controller.allMessages.length,
                        )
                      : Center(
                          child: Text('No Message Yet'),
                        );
                }),
          ),
          GetX<ChatPageGetController>(
            init: ChatPageGetController(chatChannel),
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // Image preview
                    if (controller.imageLink.value.isNotEmpty)
                      Stack(
                        children: [
                          Image.network(controller.imageLink.value),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  controller.imageLink.value = '';
                                },
                              )),
                        ],
                      ),
                    // Message input
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.messageController,
                            decoration: InputDecoration(
                                hintText: "Type message here..."),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.attach_file),
                          onPressed: () async {
                            controller.chooseImage();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            controller.sendMessage();
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
