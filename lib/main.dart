import 'file:///D:/flutter_projects/eco_monitor/lib/screens/category/chose_category_screen.dart';
import 'package:eco_monitor/providers/auth.dart';
import 'package:eco_monitor/providers/great_places.dart';
import 'package:eco_monitor/screens/auth_screen.dart';
import 'package:eco_monitor/screens/incident/add_incident_state.dart';
import 'package:eco_monitor/screens/incident/all_incidents.dart';
import 'package:eco_monitor/screens/incident/incident_detail_screen.dart';
import 'package:eco_monitor/screens/incident/all_incidents.dart';
import 'package:eco_monitor/screens/incident/my_incidents.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: GreatPlaces(),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.green,
              accentColor: Colors.grey,
              canvasColor: Colors.white,
              fontFamily: "Raleway",
              textTheme: TextTheme(
                  title: TextStyle(
                fontSize: 22,
                fontFamily: "RobotoCondensed",
                fontWeight: FontWeight.bold,
              ))),
          home: auth.isAuth ? TabsScreen() : AuthScreen(),
          routes: {
            ChooseCategoryScreen.routeName: (ctx) => ChooseCategoryScreen(),
            AddIncidentState.routeName: (ctx) => AddIncidentState(),
            AllIncidents.routeName: (ctx) => AllIncidents(),
            IncidentDetailScreen.routeName: (ctx) => IncidentDetailScreen(),
            MyIncidents.routeName: (ctx) => MyIncidents(),
          },
          onGenerateRoute: (settings) {
            return MaterialPageRoute(builder: (ctx) => TabsScreen());
          },
        ),
      ),
    );
  }
}
