class DoctorModel {
  String name;
  String email;
  String phone;
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
    required this.name,
    required this.email,
    required this.phone,
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
    String? name,
    String? email,
    String? phone,
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
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        bio: bio ?? this.bio,
        fcmToken: fcmToken ?? this.fcmToken,
        imageLink: imageLink ?? this.imageLink,
        about: about ?? this.about,
        services: services ?? this.services,
        education: education ?? this.education,
        experience: experience ?? this.experience,
        awardsAndRecognitions:
            awardsAndRecognitions ?? this.awardsAndRecognitions,
        clinicAddress: clinicAddress ?? this.clinicAddress,
      );

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        bio: json["bio"],
        fcmToken: json["fcmToken"],
        imageLink: json["imageLink"],
        about: json["about"],
        services: json["services"],
        education: json["education"],
        experience: json["experience"],
        awardsAndRecognitions: json["awards_and_recognitions"],
        clinicAddress: json["clinic_address"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "bio": bio,
        "fcmToken": fcmToken,
        "imageLink": imageLink,
        "about": about,
        "services": services,
        "education": education,
        "experience": experience,
        "awards_and_recognitions": awardsAndRecognitions,
        "clinic_address": clinicAddress,
      };
}
