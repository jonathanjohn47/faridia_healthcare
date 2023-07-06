import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

import '../core/app_constants.dart';

class FCMGetController extends GetxController {
  static const _SCOPES = [
    //'https://www.googleapis.com/auth/cloud-platform.read-only',
    'https://www.googleapis.com/auth/firebase.messaging',
  ];

  Future<String> getAccessToken() async {
    String accessToken = "";
    await FirebaseFirestore.instance
        .collection(AppConstants.constants)
        .doc(AppConstants.serviceAccount)
        .get()
        .then((value) async {
      ServiceAccountCredentials credentials =
          ServiceAccountCredentials.fromJson(
              jsonDecode(jsonEncode(value.data())));
      credentials;
      final accessCredentials = await obtainAccessCredentialsViaServiceAccount(
        credentials,
        _SCOPES,
        http.Client(),
      );
      accessToken = accessCredentials.accessToken.data;
    });

    return accessToken;
  }

  Future<void> sendNotification(String fcmToken, String title, String body,
      {String? imageUrl}) async {
    await getAccessToken().then((accessToken) async {
      var headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json'
      };
      var request = http.Request(
          'POST',
          Uri.parse(
              'https://fcm.googleapis.com/v1/projects/faridiahealthcare-7b487/messages:send'));
      request.body = json.encode({
        "message": {
          "token": fcmToken,
          "notification": {"title": title, "body": body}
        }
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
      } else {}
    });
  }
}
