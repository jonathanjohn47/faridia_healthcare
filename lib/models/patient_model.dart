// To parse this JSON data, do
//
//     final patientModel = patientModelFromJson(jsonString);

import 'dart:convert';

PatientModel patientModelFromJson(String str) => PatientModel.fromJson(json.decode(str));

String patientModelToJson(PatientModel data) => json.encode(data.toJson());

class PatientModel {
  String name;
  String email;
  String phone;
  String address;
  String fcmToken;
  String imageLink;

  PatientModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.fcmToken,
    required this.imageLink,
  });

  PatientModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? fcmToken,
    String? imageLink,
  }) =>
      PatientModel(
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        fcmToken: fcmToken ?? this.fcmToken,
        imageLink: imageLink ?? this.imageLink,
      );

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    fcmToken: json["fcmToken"],
    imageLink: json["imageLink"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "address": address,
    "fcmToken": fcmToken,
    "imageLink": imageLink,
  };
}
