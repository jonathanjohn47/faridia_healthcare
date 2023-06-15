import 'package:faridia_healthcare/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SavedDoctorsPage extends StatelessWidget {
  SavedDoctorsPage({super.key});

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
                "Saved Doctors",
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
                  10,
                  (index) => Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 4.0.sp, horizontal: 8.sp),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 30.sp,
                                  backgroundImage: NetworkImage(
                                      'https://g.foolcdn.com/image/?url=https%3A//g.foolcdn.com/editorial/images/64791/gettyimages-852090066_8cTQuWD.jpg&w=2000&op=resize'),
                                ),
                                SizedBox(
                                  width: 8.sp,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Dr. John Doe',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.sp),
                                    ),
                                    SizedBox(
                                      height: 1.sp,
                                    ),
                                    Text(
                                      'Dentist',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 1.sp,
                                    ),
                                    Text(
                                      'MBBS, BDS, MDS',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 1.sp,
                                    ),
                                    Text(
                                      '10 years of experience',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.delete_forever,
                                      color: AppColors.secondary,
                                    ))
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 0.2.sp,
                            color: AppColors.secondary,
                            indent: 16.sp,
                            endIndent: 16.sp,
                          ),
                        ],
                      ))
            ],
          ),
        ));
  }
}
