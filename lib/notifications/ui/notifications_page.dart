import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/core/app_colors.dart';
import 'package:faridia_healthcare/helpers/date_time_helpers.dart';
import 'package:faridia_healthcare/helpers/index_helpers.dart';
import 'package:faridia_healthcare/models/notification_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_constants.dart';

class NotificationsPage extends StatelessWidget {
  final bool isPatient;

  NotificationsPage({super.key, this.isPatient = true});

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
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection(
                    isPatient ? AppConstants.patients : AppConstants.doctors)
                .doc(FirebaseAuth.instance.currentUser!.email)
                .collection(AppConstants.notifications)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<NotificationModel> allNotifications = snapshot.data!.docs
                    .map((e) => NotificationModel.fromJson(
                        jsonDecode(jsonEncode(e.data()))))
                    .toList();
                return ListView(
                  children: [
                    Text(
                      "Notifications",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 8.sp,
                    ),
                    Divider(
                      thickness: 1.5.sp,
                      color: AppColors.primary,
                    ),
                    ...List.generate(
                        allNotifications.length,
                        (index) => Column(
                              children: [
                                Row(
                                  children: [
                                    Visibility(
                                      visible: !allNotifications[index].isRead,
                                      child: CircleAvatar(
                                        radius: 4.sp,
                                        backgroundColor: Colors.blue,
                                      ),
                                    ),
                                    Expanded(
                                      child: ListTile(
                                          title: Text(
                                            allNotifications[index].title,
                                            style: TextStyle(
                                                fontWeight: index.isPrime
                                                    ? FontWeight.w700
                                                    : FontWeight.w500,
                                                fontSize: index.isPrime
                                                    ? 12.sp
                                                    : 10.sp),
                                          ),
                                          subtitle: Text(
                                            allNotifications[index].description,
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          trailing: Text(
                                            allNotifications[index]
                                                .sentAt
                                                .getHowMuchTimeAgo(),
                                            style:
                                                TextStyle(color: Colors.grey),
                                          )),
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 0.5.sp,
                                  color: AppColors.secondary,
                                )
                              ],
                            ))
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
