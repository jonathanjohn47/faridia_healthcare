import 'package:faridia_healthcare/core/app_colors.dart';
import 'package:faridia_healthcare/helpers/date_time_helpers.dart';
import 'package:faridia_healthcare/models/appointment_request_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../get_controllers/set_appointment_get_controller.dart';

class SetAppointmentPage extends StatelessWidget {
  final AppointmentRequestModel appointmentRequestModel;

  SetAppointmentPage({super.key, required this.appointmentRequestModel});

  SetAppointmentGetController getController =
      Get.put(SetAppointmentGetController());

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
          padding: EdgeInsets.symmetric(
            horizontal: 16.sp,
            vertical: 8.0.sp,
          ),
          child: ListView(
            children: [
              Text(
                'Set Appointment for',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
              ),
              SizedBox(
                height: 8.sp,
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
                          appointmentRequestModel.patientModel.imageLink ?? '',
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
                              appointmentRequestModel.patientModel.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16.sp),
                            ),
                            SizedBox(
                              height: 1.sp,
                            ),
                            Text(
                              appointmentRequestModel.patientModel.address,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
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
              const Text('Patient\'s Message:',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              Container(
                height: 100.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.sp),
                  color: AppColors.secondary.withOpacity(0.1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    appointmentRequestModel.briefMessage,
                    style: const TextStyle(fontStyle: FontStyle.italic),
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
                        const Text(
                          'Choose Date',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
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
                        const Text(
                          'Choose Time',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        Obx(() {
                          return Text(
                            DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    getController.chosenTime.value.hour,
                                    getController.chosenTime.value.minute)
                                .getTimeStringInAmPm(),
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
                  Obx(() {
                    return getController.showLoader.value
                        ? const CircularProgressIndicator()
                        : FloatingActionButton.extended(
                            onPressed: () {
                              getController
                                  .setAppointment(appointmentRequestModel);
                            },
                            icon: const Icon(Icons.check, color: Colors.white),
                            label: Text('Set Appointment',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                            backgroundColor: AppColors.secondary,
                          );
                  }),
                ],
              )
            ],
          ),
        ));
  }
}
