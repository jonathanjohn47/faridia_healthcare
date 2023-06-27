import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/core/app_constants.dart';
import 'package:faridia_healthcare/helpers/index_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
                                        leading: const CircleAvatar(
                                          backgroundImage: AssetImage(
                                              'assets/images/img_491471.png'),
                                        ),
                                        title: const Text(
                                          "Dr Ahmed",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700),
                                        ),
                                        subtitle:
                                            const Text('hi, How are you?'),
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
        ));
  }
}
