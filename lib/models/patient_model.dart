// To parse this JSON data, do
//
//     final patientModel = patientModelFromJson(jsonString);

import 'dart:convert';

List<PatientModel> patientModelFromJson(String str) => List<PatientModel>.from(json.decode(str).map((x) => PatientModel.fromJson(x)));

String patientModelToJson(List<PatientModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PatientModel {
  String id;
  String name;
  String phone;
  String address;
  String fcmToken;
  String? imageLink;

  PatientModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.fcmToken,
    this.imageLink,
  });

  PatientModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? address,
    String? fcmToken,
    String? imageLink,
  }) =>
      PatientModel(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        fcmToken: fcmToken ?? this.fcmToken,
        imageLink: imageLink ?? this.imageLink,
      );

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    address: json["address"],
    fcmToken: json["fcmToken"],
    imageLink: json["imageLink"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "address": address,
    "fcmToken": fcmToken,
    "imageLink": imageLink,
  };
}
