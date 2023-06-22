import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/core/app_colors.dart';
import 'package:faridia_healthcare/core/app_constants.dart';
import 'package:faridia_healthcare/features/request_appointment/ui/create_appointment_page.dart';
import 'package:faridia_healthcare/models/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../get_controllers/request_appointment_get_controller.dart';

class RequestAppointmentPage extends StatelessWidget {
  RequestAppointmentPage({super.key});

  RequestAppointmentGetController getController =
      Get.put(RequestAppointmentGetController());

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Request an Appointment',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 2.0.sp,
              ),
              Divider(
                color: AppColors.primary,
                thickness: 2.0.sp,
              ),
              SizedBox(
                height: 2.0.sp,
              ),
              TextFormField(
                controller: getController.searchController,
                decoration: InputDecoration(
                  hintText: 'Search Doctor, Specialization etc...',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.sp),
                  ),
                ),
              ),
              SizedBox(
                height: 2.0.sp,
              ),
              Expanded(
                child: FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection(AppConstants.doctors)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<DoctorModel> allDoctors = snapshot.data!.docs
                            .map((e) => DoctorModel.fromJson(
                                jsonDecode(jsonEncode(e.data()))))
                            .toList();
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            return StreamBuilder<String>(
                                stream: Stream.periodic(
                                    Duration(milliseconds: 500), (_) {
                                  return getController.searchController.text;
                                }),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Visibility(
                                      visible: allDoctors[index]
                                              .name
                                              .toLowerCase()
                                              .contains(snapshot.data!
                                                  .toLowerCase()) ||
                                          allDoctors[index]
                                              .bio
                                              .toLowerCase()
                                              .contains(
                                                  snapshot.data!.toLowerCase()),
                                      child: Card(
                                        child: InkWell(
                                          onTap: () {
                                            Get.to(() => CreateAppointmentPage(
                                                  doctorModel:
                                                      allDoctors[index],
                                                ));
                                          },
                                          child: ListTile(
                                            leading: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  allDoctors[index].imageLink),
                                            ),
                                            title: Text(allDoctors[index].name),
                                            subtitle:
                                                Text(allDoctors[index].bio),
                                            trailing: Icon(
                                              Icons.arrow_forward_ios,
                                              size: 10.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return Container();
                                });
                          },
                          itemCount: allDoctors.length,
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
