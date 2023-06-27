import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../models/chat_channel_model.dart';

class ChatPage extends StatelessWidget {
  final ChatChannelModel chatChannel;

  const ChatPage({super.key, required this.chatChannel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          color: AppColors.primary,
        ),
      ),
    );
  }
}
