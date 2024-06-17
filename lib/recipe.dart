class Recipe {
  final String title;
  final List<String> ingredients;
  final String instructions;

  Recipe({
    required this.title,
    required this.ingredients,
    required this.instructions,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'] as String,
      ingredients: (json['ingredienti'] as String)
          .split(',')
          .map((ingredient) => ingredient.trim())
          .toList(),
      instructions: json['procedimento'] as String,
    );
  }
}
