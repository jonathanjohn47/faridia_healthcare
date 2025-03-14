import 'package:faridia_healthcare/features/chat/ui/chat_page.dart';
import 'package:faridia_healthcare/helpers/date_time_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_colors.dart';
import '../../../models/chat_channel_model.dart';
import '../get_controllers/messages_page_doctor_get_controller.dart';

class MessagesPageDoctor extends StatelessWidget {
  const MessagesPageDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Container(
            color: AppColors.primary,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.0.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Messages",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 8.sp,
              ),
              Divider(
                thickness: 1.5.sp,
                color: AppColors.primary,
              ),
              Expanded(
                child: GetX<MessagesPageDoctorGetController>(
                    init: MessagesPageDoctorGetController(),
                    builder: (controller) {
                      return controller.chatChannels.isNotEmpty
                          ? ListView.builder(
                              itemBuilder: (context, index) {
                                ChatChannelModel chatChannel =
                                    controller.chatChannels[index];
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Visibility(
                                          visible: !chatChannel
                                              .lastMessage.readByDoctor,
                                          child: CircleAvatar(
                                            radius: 4.sp,
                                            backgroundColor: Colors.blue,
                                          ),
                                        ),
                                        Expanded(
                                          child: ListTile(
                                            leading: chatChannel.patientModel
                                                        .imageLink !=
                                                    null
                                                ? CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(chatChannel
                                                            .patientModel
                                                            .imageLink!),
                                                  )
                                                : CircleAvatar(
                                                    child: Text(
                                                      chatChannel
                                                          .patientModel.name
                                                          .substring(0, 1),
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ),
                                            title: Text(
                                              chatChannel.patientModel.name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            subtitle: Text(
                                                chatChannel.lastMessage.text),
                                            trailing: Text(
                                              chatChannel.lastMessage.sentAt
                                                  .getHowMuchTimeAgo(),
                                              style: TextStyle(
                                                  fontSize: !chatChannel
                                                          .lastMessage
                                                          .readByDoctor
                                                      ? 10.sp
                                                      : 9.sp),
                                            ),
                                            onTap: () {
                                              Get.to(() => ChatPage(
                                                  chatChannel: chatChannel));
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      thickness: 0.5.sp,
                                      color: AppColors.secondary,
                                    )
                                  ],
                                );
                              },
                              itemCount: controller.chatChannels.length,
                            )
                          : Center(
                              child: Text('No messages yet'),
                            );
                    }),
              ),
            ],
          ),
        ));
  }
}
