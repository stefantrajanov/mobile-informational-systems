import 'package:flutter/material.dart';
import 'package:lab_2/models/category.dart';
import 'package:lab_2/screens/category-meals.dart';
import 'package:lab_2/screens/recipe-screen.dart';
import 'package:lab_2/services/api-service.dart';
import 'package:lab_2/widgets/category-card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        leading: IconButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FutureBuilder(future: fetchRandomRecipe(), builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return RecipePage(mealId: snapshot.data!);
                }),
              ),
            ),
          },
          icon: Icon(Icons.restaurant_menu),
        ),
      ),
      body: FutureBuilder(
        future: fetchCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Category> categories = snapshot.data as List<Category>;
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryMealsPage(
                          categoryName: categories[index].strCategory,
                        ),
                      ),
                    ),
                  },
                  child: CategoryCard(category: categories[index]),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
