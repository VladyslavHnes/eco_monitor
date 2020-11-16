import 'dart:convert';

import 'package:eco_monitor/model/place.dart';
import 'package:eco_monitor/screens/incident/incident_detail_screen.dart';
import 'package:eco_monitor/widgets/main_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyIncidents extends StatefulWidget {
  static const routeName = '/my-incidents';

  @override
  _MyIncidentsState createState() => _MyIncidentsState();
}

class _MyIncidentsState extends State<MyIncidents> {
  var url = 'http://10.0.2.2:8080/monitor/places/my?userId=';
  var places = new List<Place>();
  var userId;

  getPlaces(String userId) {
    var completeUrl = url + userId;
    http.get(completeUrl).then((response) => {
      setState(() {
        Iterable list = json.decode(response.body);
        places = list
            .map((element) => new Place(
          id: element['id'].toString(),
          title: element['title'],
          imageUrl: element['imageUrl'],
          location: PlaceLocation(
              latitude: element['place']['latitude'],
              longitude: element['place']['longitude'],
              address: element['place']['address']),
        ))
            .toList();
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    var userId = ModalRoute.of(context).settings.arguments;
    getPlaces(userId);
    return Scaffold(
      appBar: AppBar(
        title: Text('My incidents'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: MainDrawer(),
      body: places.isEmpty
          ? Center(
        child: Text('No incident yet? Add one!'),
      )
          : ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding:
            EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            title: Text(
              places[index].title,
              style: Theme.of(context).textTheme.title,
            ),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(places[index].imageUrl),
            ),
            subtitle: Text(places[index].location.address),
            onTap: () => Navigator.of(context).pushNamed(
                IncidentDetailScreen.routeName,
                arguments: places[index].id),
          );
        },
      ),
    );
  }
}