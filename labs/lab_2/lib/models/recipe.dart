class Recipe {
  final String idMeal;
  final String strMeal;
  final String strCategory;
  final String strInstructions;
  final String strMealThumb;
  final String strYoutube;
  final List<String> ingredients;

  Recipe({
    required this.idMeal,
    required this.strMeal,
    required this.strCategory,
    required this.strInstructions,
    required this.strMealThumb,
    required this.strYoutube,
    required this.ingredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    for (String key in json.keys) {
      if (key.startsWith('strIngredient') && json[key] != null && json[key].toString().isNotEmpty) {
        ingredients.add(json[key]);
      }
    }

    return Recipe(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strMealThumb: json['strMealThumb'],
      strCategory: json['strCategory'],
      strInstructions: json['strInstructions'],
      strYoutube: json['strYoutube'],
      ingredients: ingredients,
    );
  }
}