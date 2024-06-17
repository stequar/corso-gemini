import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:corso_gemini/recipe.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiRepo {
  // Access your API key as an environment variable (see "Set up your API key" above)
  // const apiKey = String.fromEnvironment('API_KEY');

  String apiKey = "AIzaSyBlrtBdIO7235u1caVtELjOFDFgiqpIUw0";

  Future<GenerateContentResponse> askToGemini(String content) async {
    final model =
        GenerativeModel(model: 'gemini-1.5-pro-latest', apiKey: apiKey);
    // final content = [Content.text('Write a story about a magic backpack.')];
    final response = await model.generateContent([Content.text(content)]);
    return response;
  }

  Future<GenerateContentResponse> sendImageToGemini(
      String content, XFile file) async {
    // For text-and-image input (multimodal), use the gemini-pro-vision model
    final model = GenerativeModel(
      model: 'gemini-pro-vision',
      apiKey: apiKey,
    );

    // Load the images into code as bytes
    final image = await file.readAsBytes();

    // Generate a prompt for the images
    final prompt = TextPart(content);

    // Convert the bytes images into Gemini understandable Data parts
    final imageParts = [
      DataPart('image/jpeg', image),
    ];

    // Fetch response using the pro model
    final response = await model.generateContent([
      Content.multi([prompt, ...imageParts])
    ]);
    print(response.text);
    return response;
  }

  Future<Recipe?> sendImageWithInstructionToGemini(
      String content, XFile file, String contentInstruction) async {
    // For text-and-image input (multimodal), use the gemini-pro-vision model
    final model = GenerativeModel(
      model: 'gemini-1.5-pro-latest',
      apiKey: apiKey,
      systemInstruction: Content.text(contentInstruction),
    );

    // Load the images into code as bytes
    final image = await file.readAsBytes();

    // Generate a prompt for the images
    final prompt = TextPart(content);

    // Convert the bytes images into Gemini understandable Data parts
    final imageParts = [
      DataPart('image/jpeg', image),
    ];

    // Fetch response using the pro model
    final response = await model.generateContent([
      Content.multi([prompt, ...imageParts])
    ]);
    print(response.text);
    if (response.text != null) {
      try {
        Map<String, dynamic> jsonData = json.decode(response.text!);
        Recipe recipe = Recipe.fromJson(jsonData);
        return recipe;
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }
}
