import 'file:///D:/flutter_projects/eco_monitor/lib/screens/category/chose_category_screen.dart';
import 'file:///D:/flutter_projects/eco_monitor/lib/screens/category/categories_screen.dart';
import 'package:eco_monitor/widgets/category_item.dart';
import 'package:eco_monitor/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

import '../category_data.dart';

class TabsScreen extends StatelessWidget {
  void redirectToAddIncident(BuildContext context) {
    Navigator.of(context).pushNamed(ChooseCategoryScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EcoAct'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text(
          'Act for nature!',
          style: TextStyle(
              fontSize: 30,
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoCondensed'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: () => redirectToAddIncident(context),
      ),
    );
  }
}
