import 'package:corso_gemini/recipe.dart';
import 'package:flutter/material.dart';

class RecipeScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Titolo della ricetta (in grassetto)
              Text(
                recipe.title,
                style: const TextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),

              // Ingredienti (suddivisi su più righe)
              Text(
                "Ingredienti:",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5.0),
              Text(
                recipe.ingredients.join('\n'),
              ),
              const SizedBox(height: 20.0),

              // Istruzioni (suddivise su più paragrafi)
              Text(
                "Preparazione:",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5.0),
              Text(
                recipe.instructions,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
