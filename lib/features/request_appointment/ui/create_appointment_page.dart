import 'package:faridia_healthcare/core/app_colors.dart';
import 'package:faridia_healthcare/helpers/date_time_helpers.dart';
import 'package:faridia_healthcare/models/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../get_controllers/create_appointment_get_controller.dart';

class CreateAppointmentPage extends StatelessWidget {
  CreateAppointmentPage({super.key, required this.doctorModel});

  final DoctorModel doctorModel;

  CreateAppointmentGetController getController =
      Get.put(CreateAppointmentGetController());

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
                'Request appointment with',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8.0.sp,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.sp),
                  color: AppColors.secondary.withOpacity(0.1),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 4.0.sp, horizontal: 4.sp),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30.sp,
                        backgroundImage: NetworkImage(
                          doctorModel.imageLink,
                        ),
                      ),
                      SizedBox(
                        width: 8.sp,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doctorModel.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16.sp),
                            ),
                            SizedBox(
                              height: 1.sp,
                            ),
                            Text(
                              doctorModel.bio,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8.0.sp,
              ),
              Divider(
                thickness: 1.5.sp,
                color: AppColors.primary,
              ),
              SizedBox(
                height: 8.0.sp,
              ),
              TextFormField(
                controller: getController.briefMessageController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Brief message to doctor, e.g. symptoms, etc...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.sp),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0.sp,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.sp),
                  color: AppColors.secondary.withOpacity(0.1),
                ),
                child: InkWell(
                  onTap: () {
                    getController.selectDate(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: Row(
                      children: [
                        Text(
                          'Choose Date',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Obx(() {
                          return Text(
                            getController.chosenDate.value.getDateString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.sp),
                          );
                        })
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0.sp,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.sp),
                  color: AppColors.secondary.withOpacity(0.1),
                ),
                child: InkWell(
                  onTap: () {
                    getController.selectTime(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: Row(
                      children: [
                        Text(
                          'Choose Time',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Obx(() {
                          return Text(
                            DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    getController.chosenTime.value.hour,
                                    getController.chosenTime.value.minute)
                                .getTimeString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.sp),
                          );
                        })
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0.sp,
              ),
              Divider(
                thickness: 1.5.sp,
                color: AppColors.primary,
              ),
              SizedBox(
                height: 8.0.sp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.extended(
                    onPressed: () {
                      getController.createAppointment(doctorModel);
                    },
                    icon: Icon(Icons.check, color: Colors.white),
                    label: Text('Request',
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                    backgroundColor: AppColors.secondary,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
