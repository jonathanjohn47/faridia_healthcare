import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridia_healthcare/helpers/date_time_helpers.dart';
import 'package:faridia_healthcare/models/notification_model.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../core/app_constants.dart';
import '../../../models/appointment_model.dart';

class DoctorAppointmentGetController extends GetxController {
  Future<void> cancelAppointment(AppointmentModel appointmentModel) async {
    await FirebaseFirestore.instance
        .collection(AppConstants.appointments)
        .doc(appointmentModel.id)
        .delete()
        .then((value) async {
      Uuid uuid = const Uuid();
      String notificationId = uuid.v4();
      NotificationModel notificationModel = NotificationModel(
          id: notificationId,
          title: 'Appointment Cancelled',
          description:
              'Your appointment for ${appointmentModel.appointmentOn.getDateStringWithMonthName} on ${appointmentModel.appointmentOn.getTimeStringInAmPm()} with doctor ${appointmentModel.doctorModel.name} has been cancelled by the doctor.',
          isRead: false,
          sentAt: DateTime.now());
      await FirebaseFirestore.instance
          .collection(AppConstants.patients)
          .doc(appointmentModel.patientEmail)
          .collection(AppConstants.notifications)
          .doc(notificationId)
          .set(notificationModel.toJson());
    });
  }
}
