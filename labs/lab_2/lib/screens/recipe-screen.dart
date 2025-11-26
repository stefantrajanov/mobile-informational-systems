import 'package:flutter/material.dart';
import 'package:lab_2/services/api-service.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipePage extends StatelessWidget {
  final String mealId;

  const RecipePage({super.key, required this.mealId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Details'),
      ),
      body: FutureBuilder(
        future: fetchRecipeForMeal(mealId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final recipe = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.strMeal,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Image.network(recipe.strMealThumb),
                  const SizedBox(height: 20),
                  Text(
                    'Instructions',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(recipe.strInstructions),
                  const SizedBox(height: 10),
                  Text(
                    'Ingredients',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: recipe.ingredients.length,
                    itemBuilder: (context, index) {
                      final ingredient = recipe.ingredients[index];
                      return Text('- $ingredient');
                    },
                  ),
                  SizedBox(height: 20),
                InkWell(
                onTap: () => _launchURL(recipe.strYoutube),
                child: const Text(
                  'Watch Youtube Video',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontSize: 18,
                  ),
                ),
              ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

// Function to open the URL
  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }