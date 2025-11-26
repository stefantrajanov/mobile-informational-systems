import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lab_2/models/category.dart';
import 'package:lab_2/models/meal.dart';
import 'package:lab_2/models/recipe.dart';

Future<List<Category>> fetchCategories() async {
  final response = await http.get(
    Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'),
  );

  if (response.statusCode == 200) {
    // 1. Decode into a Map first (because the root is {})
    Map<String, dynamic> responseData = jsonDecode(response.body);

    // 2. Access the 'categories' key to get the List
    List<dynamic> body = responseData['categories'];

    // 3. Now map the list as usual
    List<Category> categories = body
        .map((dynamic item) => Category.fromJson(item))
        .toList();

    return categories;
  } else {
    throw Exception('Failed to load categories');
  }
}

Future<List<Meal>> fetchMealsByCategory(String categoryName) async {
  final response = await http.get(
    Uri.parse(
      'https://www.themealdb.com/api/json/v1/1/filter.php?c=$categoryName',
    ),
  );

  if (response.statusCode == 200) {
    // 1. Decode into a Map first (because the root is {})
    Map<String, dynamic> responseData = jsonDecode(response.body);

    // 2. Access the 'categories' key to get the List
    List<dynamic> body = responseData['meals'];

    // 3. Now map the list as usual
    List<Meal> meals = body.map((dynamic item) => Meal.fromJson(item)).toList();

    return meals;
  } else {
    throw Exception('Failed to load meals for category $categoryName');
  }
}

Future<Recipe> fetchRecipeForMeal(String mealId) async {
  final response = await http.get(
    Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$mealId'),
  );

  if (response.statusCode == 200) {
    // 1. Decode into a Map first (because the root is {})
    Map<String, dynamic> responseData = jsonDecode(response.body);

    // 2. Access the 'categories' key to get the List
    List<dynamic> body = responseData['meals'];

    // 3. Now map the list as usual
    Recipe recipe = body.map((dynamic item) => Recipe.fromJson(item)).first;

    return recipe;
  } else {
    throw Exception('Failed to load meal recipe for $mealId');
  }
}


Future<String> fetchRandomRecipe() async {
  final response = await http.get(
    Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'),
  );

  if (response.statusCode == 200) {
    // 1. Decode into a Map first (because the root is {})
    Map<String, dynamic> responseData = jsonDecode(response.body);

    // 2. Access the 'categories' key to get the List
    List<dynamic> body = responseData['meals'];

    // 3. Now map the list as usual
    Recipe recipe = body.map((dynamic item) => Recipe.fromJson(item)).first;

    return recipe.idMeal;
  } else {
    throw Exception('Failed to load a random recipe');
  }
}


