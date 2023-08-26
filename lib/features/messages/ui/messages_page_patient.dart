import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/helpers/date_time_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_constants.dart';
import '../../../models/chat_channel_model.dart';

class MessagesPagePatient extends StatelessWidget {
  const MessagesPagePatient({super.key});

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
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection(AppConstants.chatChannels)
                        .where('patient_email',
                            isEqualTo:
                                FirebaseAuth.instance.currentUser!.email!)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ChatChannelModel> chatChannels = snapshot
                            .data!.docs
                            .map((e) => ChatChannelModel.fromJson(
                                jsonDecode(jsonEncode(e.data()))))
                            .toList();
                        return chatChannels.isNotEmpty
                            ? ListView.builder(
                                itemBuilder: (context, index) {
                                  ChatChannelModel chatChannel =
                                      chatChannels[index];
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Visibility(
                                            visible: !chatChannel
                                                .lastMessage.readByPatient,
                                            child: CircleAvatar(
                                              radius: 4.sp,
                                              backgroundColor: Colors.blue,
                                            ),
                                          ),
                                          Expanded(
                                            child: ListTile(
                                                leading: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      chatChannel.doctorModel
                                                          .imageLink),
                                                ),
                                                title: Text(
                                                  chatChannel.doctorModel.name,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                subtitle: Text(chatChannel
                                                    .lastMessage.text),
                                                trailing: Text(
                                                  chatChannel.lastMessage.sentAt
                                                      .getHowMuchTimeAgo(),
                                                  style: TextStyle(
                                                      fontSize: !chatChannel
                                                              .lastMessage
                                                              .readByPatient
                                                          ? 10.sp
                                                          : 9.sp),
                                                )),
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
                                itemCount: 10,
                              )
                            : Center(
                                child: Text('No messages yet'),
                              );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
