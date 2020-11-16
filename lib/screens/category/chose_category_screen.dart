import 'file:///D:/flutter_projects/eco_monitor/lib/screens/category/categories_screen.dart';
import 'package:flutter/material.dart';

class ChooseCategoryScreen extends StatelessWidget {

  static const String routeName = '/choose-category';

  ChooseCategoryScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chose category of incident'),),
      body: CategoriesScreen(),
    );
  }
}
