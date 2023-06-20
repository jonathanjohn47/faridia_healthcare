// To parse this JSON data, do
//
//     final appointmentModel = appointmentModelFromJson(jsonString);

import 'dart:convert';

import 'doctor_model.dart';
import 'patient_model.dart';

AppointmentModel appointmentModelFromJson(String str) =>
    AppointmentModel.fromJson(json.decode(str));

String appointmentModelToJson(AppointmentModel data) =>
    json.encode(data.toJson());

class AppointmentModel {
  String id;
  String doctorEmail;
  String patientEmail;
  DoctorModel doctorModel;
  PatientModel patientModel;
  DateTime appointmentOn;
  String clinicAddress;
  bool isCancelled;

  AppointmentModel({
    required this.id,
    required this.doctorEmail,
    required this.patientEmail,
    required this.doctorModel,
    required this.patientModel,
    required this.appointmentOn,
    required this.clinicAddress,
    required this.isCancelled,
  });

  AppointmentModel copyWith({
    String? id,
    String? doctorEmail,
    String? patientEmail,
    DoctorModel? doctorModel,
    PatientModel? patientModel,
    DateTime? appointmentOn,
    String? clinicAddress,
    bool? isCancelled,
  }) =>
      AppointmentModel(
        id: id ?? this.id,
        doctorEmail: doctorEmail ?? this.doctorEmail,
        patientEmail: patientEmail ?? this.patientEmail,
        doctorModel: doctorModel ?? this.doctorModel,
        patientModel: patientModel ?? this.patientModel,
        appointmentOn: appointmentOn ?? this.appointmentOn,
        clinicAddress: clinicAddress ?? this.clinicAddress,
        isCancelled: isCancelled ?? this.isCancelled,
      );

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      AppointmentModel(
        id: json["id"],
        doctorEmail: json["doctor_email"],
        patientEmail: json["patient_email"],
        doctorModel: DoctorModel.fromJson(json["doctor_model"]),
        patientModel: PatientModel.fromJson(json["patient_model"]),
        appointmentOn:
            DateTime.fromMillisecondsSinceEpoch(json["appointment_on"]),
        clinicAddress: json["clinic_address"],
        isCancelled: json["is_cancelled"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "doctor_email": doctorEmail,
        "patient_email": patientEmail,
        "doctor_model": doctorModel.toJson(),
        "patient_model": patientModel.toJson(),
        "appointment_on": appointmentOn.millisecondsSinceEpoch,
        "clinic_address": clinicAddress,
        "is_cancelled": isCancelled,
      };
}
