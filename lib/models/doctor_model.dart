// To parse this JSON data, do
//
//     final doctorModel = doctorModelFromJson(jsonString);

import 'dart:convert';

DoctorModel doctorModelFromJson(String str) => DoctorModel.fromJson(json.decode(str));

String doctorModelToJson(DoctorModel data) => json.encode(data.toJson());

class DoctorModel {
  String id;
  String name;
  String phone;
  String email;
  String password;
  String bio;
  String fcmToken;
  String imageLink;
  String about;
  String services;
  String education;
  String experience;
  String awardsAndRecognitions;
  String clinicAddress;

  DoctorModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.bio,
    required this.fcmToken,
    required this.imageLink,
    required this.about,
    required this.services,
    required this.education,
    required this.experience,
    required this.awardsAndRecognitions,
    required this.clinicAddress,
  });

  DoctorModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? password,
    String? bio,
    String? fcmToken,
    String? imageLink,
    String? about,
    String? services,
    String? education,
    String? experience,
    String? awardsAndRecognitions,
    String? clinicAddress,
  }) =>
      DoctorModel(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        password: password ?? this.password,
        bio: bio ?? this.bio,
        fcmToken: fcmToken ?? this.fcmToken,
        imageLink: imageLink ?? this.imageLink,
        about: about ?? this.about,
        services: services ?? this.services,
        education: education ?? this.education,
        experience: experience ?? this.experience,
        awardsAndRecognitions: awardsAndRecognitions ?? this.awardsAndRecognitions,
        clinicAddress: clinicAddress ?? this.clinicAddress,
      );

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    password: json["password"],
    bio: json["bio"],
    fcmToken: json["fcmToken"],
    imageLink: json["imageLink"],
    about: json["about"],
    services: json["services"],
    education: json["education"],
    experience: json["experience"],
    awardsAndRecognitions: json["awardsAndRecognitions"],
    clinicAddress: json["clinicAddress"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "email": email,
    "password": password,
    "bio": bio,
    "fcmToken": fcmToken,
    "imageLink": imageLink,
    "about": about,
    "services": services,
    "education": education,
    "experience": experience,
    "awardsAndRecognitions": awardsAndRecognitions,
    "clinicAddress": clinicAddress,
  };
}
