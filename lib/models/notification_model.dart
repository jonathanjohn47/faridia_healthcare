// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  String id;
  String title;
  String description;
  bool isRead;
  DateTime sentAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isRead,
    required this.sentAt,
  });

  NotificationModel copyWith({
    String? id,
    String? title,
    String? description,
    bool? isRead,
    DateTime? sentAt,
  }) =>
      NotificationModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        isRead: isRead ?? this.isRead,
        sentAt: sentAt ?? this.sentAt,
      );

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        isRead: json["isRead"],
        sentAt: DateTime.fromMillisecondsSinceEpoch(json["sentAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "isRead": isRead,
        "sentAt": sentAt.millisecondsSinceEpoch,
      };
}
