import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/core/app_constants.dart';
import 'package:faridia_healthcare/features/search_for_doctors/get_controllers/search_for_doctors_get_controller.dart';
import 'package:faridia_healthcare/models/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_colors.dart';
import '../../profile/ui/doctor_profile_page.dart';

class SearchForDoctorsPage extends StatelessWidget {
  SearchForDoctorsPage({super.key});

  SearchForDoctorsGetController getController =
      Get.put(SearchForDoctorsGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0.sp),
              bottomRight: Radius.circular(10.0.sp),
            ),
          ),
          title: Text(
            'Search for Doctors',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.0.sp),
          child: Column(
            children: [
              SizedBox(
                height: 8.sp,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: getController.searchController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        labelText: 'Name, Specialization, etc...',
                        prefixIcon: Icon(Icons.search),
                        // other properties...
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4.sp,
                  ),
                  /*FloatingActionButton(
                    heroTag: null,
                    backgroundColor: AppColors.secondary,
                    shape: CircleBorder(),
                    onPressed: () {},
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  )*/
                ],
              ),
              SizedBox(
                height: 4.sp,
              ),
              Divider(
                thickness: 1.5.sp,
                color: AppColors.secondary,
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
                              DoctorModel doctor = allDoctors[index];
                              return StreamBuilder<String>(
                                  stream: Stream.periodic(
                                      Duration(milliseconds: 500), (_) {
                                    return getController.searchController.text;
                                  }),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      String searchValue = snapshot.data!;
                                      return Visibility(
                                        visible: doctor.name
                                                .toLowerCase()
                                                .contains(searchValue
                                                    .toLowerCase()) ||
                                            doctor.bio.toLowerCase().contains(
                                                searchValue.toLowerCase()),
                                        child: Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.to(() => DoctorProfilePage(
                                                      doctorModel: doctor,
                                                    ));
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 4.0.sp,
                                                    horizontal: 4.sp),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 30.sp,
                                                      backgroundImage:
                                                          NetworkImage(
                                                              doctor.imageLink),
                                                    ),
                                                    SizedBox(
                                                      width: 8.sp,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          doctor.name,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16.sp),
                                                        ),
                                                        SizedBox(
                                                          height: 1.sp,
                                                        ),
                                                        Text(
                                                          doctor.bio,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              thickness: 0.5.sp,
                                              color: AppColors.primary,
                                              indent: 8.sp,
                                              endIndent: 8.sp,
                                            ),
                                          ],
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
                      }))
            ],
          ),
        ));
  }
}
