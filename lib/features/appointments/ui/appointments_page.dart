import 'package:faridia_healthcare/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppointmentsPage extends StatelessWidget {
  AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8.sp),
            bottomRight: Radius.circular(8.sp),
          ),
        ),
      ),
      body: ListView(
        children: [
          ...List.generate(
              10,
              (index) => Card(
                    child: Padding(
                      padding: EdgeInsets.all(4.sp),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              'Dr. Ahmed',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 14.sp),
                            ),
                            subtitle: Text(
                              'Dentist',
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '12/12/2021',
                                  style: TextStyle(fontSize: 10.sp),
                                ),
                                SizedBox(
                                  width: 4.sp,
                                ),
                                Text(
                                  '12:00 PM',
                                  style: TextStyle(fontSize: 10.sp),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondary,
                                ),
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 4.sp,
                                    ),
                                    Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ))
        ],
      ),
    );
  }
}
