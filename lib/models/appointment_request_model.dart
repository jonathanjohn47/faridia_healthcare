// To parse this JSON data, do
//
//     final appointmentRequestModel = appointmentRequestModelFromJson(jsonString);

import 'dart:convert';

import 'package:faridia_healthcare/models/patient_model.dart';

import 'doctor_model.dart';

AppointmentRequestModel appointmentRequestModelFromJson(String str) =>
    AppointmentRequestModel.fromJson(json.decode(str));

String appointmentRequestModelToJson(AppointmentRequestModel data) =>
    json.encode(data.toJson());

class AppointmentRequestModel {
  String id;
  DoctorModel doctorModel;
  PatientModel patientModel;
  String briefMessage;
  DateTime requestedOn;
  DateTime appointmentFor;

  AppointmentRequestModel({
    required this.id,
    required this.doctorModel,
    required this.patientModel,
    required this.briefMessage,
    required this.requestedOn,
    required this.appointmentFor,
  });

  AppointmentRequestModel copyWith({
    String? id,
    DoctorModel? doctorModel,
    PatientModel? patientModel,
    String? briefMessage,
    DateTime? requestedOn,
    DateTime? appointmentFor,
  }) =>
      AppointmentRequestModel(
        id: id ?? this.id,
        doctorModel: doctorModel ?? this.doctorModel,
        patientModel: patientModel ?? this.patientModel,
        briefMessage: briefMessage ?? this.briefMessage,
        requestedOn: requestedOn ?? this.requestedOn,
        appointmentFor: appointmentFor ?? this.appointmentFor,
      );

  factory AppointmentRequestModel.fromJson(Map<String, dynamic> json) =>
      AppointmentRequestModel(
        id: json["id"],
        doctorModel: DoctorModel.fromJson(json["doctor_model"]),
        patientModel: PatientModel.fromJson(json["patient_model"]),
        briefMessage: json["brief_message"],
        requestedOn: DateTime.fromMillisecondsSinceEpoch(json["requested_on"]),
        appointmentFor:
            DateTime.fromMillisecondsSinceEpoch(json["appointment_for"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "doctor_model": doctorModel.toJson(),
        "patient_model": patientModel.toJson(),
        "brief_message": briefMessage,
        "requested_on": requestedOn.millisecondsSinceEpoch,
        "appointment_for": appointmentFor.millisecondsSinceEpoch,
      };
}
