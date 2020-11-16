import 'package:eco_monitor/providers/auth.dart';
import 'package:eco_monitor/screens/incident/all_incidents.dart';
import 'package:eco_monitor/screens/incident/all_incidents.dart';
import 'package:eco_monitor/screens/incident/my_incidents.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {

  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontFamily: "RobotoCondensed",
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text('Incidents', style: TextStyle(fontSize: 24),),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile('Add incident', Icons.add, () {
            Navigator.of(context).pushReplacementNamed("/");
          }),
          buildListTile('My incidents', Icons.home, () {
            var userId = Provider.of<Auth>(context, listen: false).userId;
            Navigator.of(context).pushReplacementNamed(MyIncidents.routeName, arguments: userId);
          }),
          buildListTile('All incidents', Icons.map, () {
            Navigator.of(context).pushReplacementNamed(AllIncidents.routeName);
          }),
        ],
      ),
    );
  }
}