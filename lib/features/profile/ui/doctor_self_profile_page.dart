import 'package:faridia_healthcare/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DoctorSelfProfilePage extends StatelessWidget {
  const DoctorSelfProfilePage({super.key});

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
              //about, services, education, experience, awards and recognitions, clinic address
              SizedBox(
                height: 8.sp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50.sp,
                        backgroundImage: AssetImage(
                          'assets/images/img_491471.png',
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: FloatingActionButton(
                          heroTag: null,
                          backgroundColor: AppColors.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.sp),
                          ),
                          onPressed: () {},
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 8.sp,
              ),
              Table(
                columnWidths: {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(3),
                },
                children: [
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.only(top: 15.sp),
                      child: Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 13.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ])
                ],
              ),
              SizedBox(
                height: 8.sp,
              ),
              Divider(
                thickness: 1.5.sp,
              ),
              SizedBox(
                height: 8.sp,
              ),
              Text(
                'Bio',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
              ),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText:
                      'e.g\nGynocologist\nMBBS, MD, PhD\n10 years of experience',
                ),
              ),
              SizedBox(
                height: 8.sp,
              ),
              Text(
                'About',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
              ),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Write something about yourself in short...',
                ),
              ),
              SizedBox(
                height: 8.sp,
              ),
              Text(
                'Services',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
              ),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText:
                      'What are the services you offer? e.g. Dental Care, Eye Care, etc.',
                ),
              ),
              SizedBox(
                height: 8.sp,
              ),
              Text(
                'Experience',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
              ),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText:
                      'Write about your best work experience. e.g. 5 years of experience as Gynocologist in AIIMS etc.',
                ),
              ),
              SizedBox(
                height: 8.sp,
              ),
              Text(
                'Awards and Recognitions',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
              ),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText:
                      'This will make you stand out. You know what to write here...',
                ),
              ),
              SizedBox(
                height: 8.sp,
              ),
              Text(
                'Clinic/Hospital Address',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
              ),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Where do you see patients? e.g. AIIMS, New Delhi',
                ),
              ),
              SizedBox(
                height: 8.sp,
              ),
              Divider(
                thickness: 1.5.sp,
              ),
              SizedBox(
                height: 8.sp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.extended(
                    heroTag: null,
                    onPressed: () {},
                    label: Text(
                      'Save',
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w500),
                    ),
                    icon: Icon(Icons.upload),
                  )
                ],
              ),
              SizedBox(
                height: 8.sp,
              ),
            ],
          ),
        ));
  }
}
