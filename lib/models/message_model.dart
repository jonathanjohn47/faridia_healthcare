class MessageModel {
  String id;
  String text;
  String doctorEmail;
  String patientEmail;
  DateTime sentAt;
  bool readByDoctor;
  bool readByPatient;
  String imageLink;
  bool sentByDoctor;
  bool sentByPatient;

  MessageModel({
    required this.id,
    required this.text,
    required this.doctorEmail,
    required this.patientEmail,
    required this.sentAt,
    required this.readByDoctor,
    required this.readByPatient,
    required this.imageLink,
    required this.sentByDoctor,
    required this.sentByPatient,
  });

  MessageModel copyWith({
    String? id,
    String? text,
    String? doctorEmail,
    String? patientEmail,
    DateTime? sentAt,
    bool? readByDoctor,
    bool? readByPatient,
    String? imageLink,
    bool? sentByDoctor,
    bool? sentByPatient,
  }) =>
      MessageModel(
        id: id ?? this.id,
        text: text ?? this.text,
        doctorEmail: doctorEmail ?? this.doctorEmail,
        patientEmail: patientEmail ?? this.patientEmail,
        sentAt: sentAt ?? this.sentAt,
        readByDoctor: readByDoctor ?? this.readByDoctor,
        readByPatient: readByPatient ?? this.readByPatient,
        imageLink: imageLink ?? this.imageLink,
        sentByDoctor: sentByDoctor ?? this.sentByDoctor,
        sentByPatient: sentByPatient ?? this.sentByPatient,
      );

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json["id"],
        text: json["text"],
        doctorEmail: json["doctor_email"],
        patientEmail: json["patient_email"],
        sentAt: DateTime.fromMillisecondsSinceEpoch(json["sent_at"]),
        readByDoctor: json["read_by_doctor"],
        readByPatient: json["read_by_patient"],
        imageLink: json["image_link"],
        sentByDoctor: json["sent_by_doctor"],
        sentByPatient: json["sent_by_patient"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "doctor_email": doctorEmail,
        "patient_email": patientEmail,
        "sent_at": sentAt.millisecondsSinceEpoch,
        "read_by_doctor": readByDoctor,
        "read_by_patient": readByPatient,
        "image_link": imageLink,
        "sent_by_doctor": sentByDoctor,
        "sent_by_patient": sentByPatient,
      };

  factory MessageModel.empty() => MessageModel(
        id: '',
        text: '',
        doctorEmail: '',
        patientEmail: '',
        sentAt: DateTime.now(),
        readByDoctor: false,
        readByPatient: false,
        imageLink: '',
        sentByDoctor: false,
        sentByPatient: false,
      );
}
