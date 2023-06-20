// To parse this JSON data, do
//
//     final chatChannelModel = chatChannelModelFromJson(jsonString);

import 'dart:convert';

import 'doctor_model.dart';
import 'message_model.dart';
import 'patient_model.dart';

ChatChannelModel chatChannelModelFromJson(String str) =>
    ChatChannelModel.fromJson(json.decode(str));

String chatChannelModelToJson(ChatChannelModel data) =>
    json.encode(data.toJson());

class ChatChannelModel {
  String id;
  String doctorEmail;
  String patientEmail;
  DoctorModel doctorModel;
  PatientModel patientModel;
  MessageModel lastMessage;

  ChatChannelModel({
    required this.id,
    required this.doctorEmail,
    required this.patientEmail,
    required this.doctorModel,
    required this.patientModel,
    required this.lastMessage,
  });

  ChatChannelModel copyWith({
    String? id,
    String? doctorEmail,
    String? patientEmail,
    DoctorModel? doctorModel,
    PatientModel? patientModel,
    MessageModel? lastMessage,
  }) =>
      ChatChannelModel(
        id: id ?? this.id,
        doctorEmail: doctorEmail ?? this.doctorEmail,
        patientEmail: patientEmail ?? this.patientEmail,
        doctorModel: doctorModel ?? this.doctorModel,
        patientModel: patientModel ?? this.patientModel,
        lastMessage: lastMessage ?? this.lastMessage,
      );

  factory ChatChannelModel.fromJson(Map<String, dynamic> json) =>
      ChatChannelModel(
        id: json["id"],
        doctorEmail: json["doctor_email"],
        patientEmail: json["patient_email"],
        doctorModel: DoctorModel.fromJson(json["doctor_model"]),
        patientModel: PatientModel.fromJson(json["patient_model"]),
        lastMessage: MessageModel.fromJson(json["last_message"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "doctor_email": doctorEmail,
        "patient_email": patientEmail,
        "doctor_model": doctorModel.toJson(),
        "patient_model": patientModel.toJson(),
        "last_message": lastMessage.toJson(),
      };
}
