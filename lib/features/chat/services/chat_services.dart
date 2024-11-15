import 'dart:developer';

import 'package:bebra_ai/models/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatService {
  Future<void> callGeminiModel({
    required TextEditingController controller,
    required List<Message> messages,
  }) async {
    try {
      if (controller.text.isNotEmpty) {
        messages.add(Message(text: controller.text, isUser: true));
      }

      final model = GenerativeModel(
        model: "gemini-pro",
        apiKey: dotenv.env["GOOGLE_API_KEY"]!,
      );
      final prompt = controller.text.trim();
      final content = [Content.text(prompt)];

      controller.clear();

      final response = await model.generateContent(content);

      messages.add(Message(text: response.text!, isUser: false));
    } catch (e) {
      log("error: $e");
    }
  }
}
