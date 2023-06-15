import 'package:faridia_healthcare/core/app_colors.dart';
import 'package:faridia_healthcare/helpers/index_helpers.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

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
        child: ListView(
          children: [
            Text(
              "Notifications",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 8.sp,
            ),
            Divider(
              thickness: 1.5.sp,
              color: AppColors.primary,
            ),
            ...List.generate(
                100,
                (index) => Column(
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
                                  title: Text(
                                    'Notification Title',
                                    style: TextStyle(
                                        fontWeight: index.isPrime
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                        fontSize:
                                            index.isPrime ? 12.sp : 10.sp),
                                  ),
                                  subtitle: Text(
                                    'Notification subtitle',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  trailing: Text(
                                    '50 mins ago',
                                    style: TextStyle(color: Colors.grey),
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
        ),
      ),
    );
  }
}
