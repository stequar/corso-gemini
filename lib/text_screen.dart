import 'package:corso_gemini/gemini.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

// ignore: must_be_immutable
class TextScreen extends StatefulWidget {
  TextScreen({super.key});

  GenerateContentResponse? response;

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          widget.response == null
              ? Text(widget.response!.text ?? '')
              : const SizedBox.shrink()
        ],
      ),
      bottomNavigationBar: PromptTextField(),
    );
  }
}

// ignore: must_be_immutable
class PromptTextField extends StatefulWidget {
  PromptTextField({super.key});

  String contentText = '';

  @override
  State<PromptTextField> createState() => _PromptTextFieldState();
}

class _PromptTextFieldState extends State<PromptTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF302c2c),
          borderRadius: BorderRadius.circular(32),
        ),
        child: TextField(
          onChanged: (value) {
            widget.contentText = value;
          },
          decoration: InputDecoration(
            hintStyle: const TextStyle(fontSize: 16, color: Colors.white),
            hintText: 'Scrivi qui',
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.image,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 12,
                ),
                const Icon(
                  Icons.mic,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () => GeminiRepo().askToGemini(widget.contentText),
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(13),
          ),
        ),
      ),
    );
  }
}
