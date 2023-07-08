import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import '../../../core/app_colors.dart';

class MessagesPageDoctor extends StatelessWidget {
  const MessagesPageDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          color: AppColors.primary,
        ),
      ),
      body: ZIMKitConversationListView(
        onPressed: (context, conversation, defaultAction) {
          Get.to(() => ZIMKitMessageListPage(
                conversationID: conversation.id,
                conversationType: conversation.type,
                appBarBuilder: (context, title) {
                  return AppBar(
                    leading: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.0.sp),
                      child: CircleAvatar(
                        radius: 10.sp,
                        backgroundImage: NetworkImage(conversation.avatarUrl),
                      ),
                    ),
                    title: Text(conversation.name),
                  );
                },
              ));
        },
      ), /*Padding(
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
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Visibility(
                                    visible: index.isPrime,
                                    child: CircleAvatar(
                                      radius: 4.sp,
                                      backgroundColor: Colors.blue,
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              'assets/images/img_491471.png'),
                                        ),
                                        title: Text(
                                          "Dr Ahmed",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700),
                                        ),
                                        subtitle:
                                            Text('hi, How are you?'),
                                        trailing: Text(
                                          '50 mins ago',
                                          style: TextStyle(
                                              fontSize:
                                                  index.isPrime ? 10.sp : 9.sp),
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
                      );
                    }),
              ),
            ],
          ),
        )*/
    );
  }
}
