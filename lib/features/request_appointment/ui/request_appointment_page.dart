import 'package:faridia_healthcare/core/app_colors.dart';
import 'package:faridia_healthcare/features/request_appointment/ui/requested_appointments_tab.dart';
import 'package:faridia_healthcare/features/request_appointment/ui/search_doctor_for_appointment_tab.dart';
import 'package:flutter/material.dart';

class RequestAppointmentPage extends StatelessWidget {
  const RequestAppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(
            color: AppColors.primary,
          ),
        ),
        body: Column(
          children: [
            const TabBar(tabs: [
              Tab(
                text: 'Search Doctor',
              ),
              Tab(
                text: 'Requested Appointments',
              ),
            ]),
            Expanded(
              child: TabBarView(
                children: [
                  SearchDoctorForAppointmentTab(),
                  const RequestedAppointmentsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
