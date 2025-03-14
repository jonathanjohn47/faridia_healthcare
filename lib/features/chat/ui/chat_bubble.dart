import 'package:faridia_healthcare/models/message_model.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final bool sentByMe;
  final MessageModel messageModel;

  const ChatBubble({required this.sentByMe, required this.messageModel});

  @override
  Widget build(BuildContext context) {
    if (sentByMe) {
      // Sender's Bubble
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              messageModel.text,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    } else {
      // Receiver's Bubble
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              messageModel.text,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      );
    }
  }
}
