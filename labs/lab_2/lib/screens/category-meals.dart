import 'package:flutter/material.dart';
import 'package:lab_2/screens/recipe-screen.dart';
import 'package:lab_2/services/api-service.dart';
import 'package:lab_2/widgets/meal-card.dart';

class CategoryMealsPage extends StatelessWidget {
  final String categoryName;

  const CategoryMealsPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryName)),
      body: FutureBuilder(
        future: fetchMealsByCategory(categoryName),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final meals = snapshot.data!;
            return ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                return InkWell(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipePage(mealId: meal.idMeal),
                      ),
                    ),
                  },
                  child: MealCard(meal: meal),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
