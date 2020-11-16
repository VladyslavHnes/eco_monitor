import 'dart:convert';
import 'dart:io';

import 'package:eco_monitor/model/place.dart';
import 'package:eco_monitor/providers/great_places.dart';
import 'package:eco_monitor/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class IncidentDetailScreen extends StatefulWidget {
  static const routeName = '/incident-detail';

  @override
  _IncidentDetailScreenState createState() => _IncidentDetailScreenState();
}

class _IncidentDetailScreenState extends State<IncidentDetailScreen> {
  var url = 'http://10.0.2.2:8080/monitor/places';
  Place selectedPlace;

  void getPlace(String id) {
    http.get(url + "/" + id).then((response) {
      setState(() {
        Map element = json.decode(response.body) as Map;
        selectedPlace =  new Place(
          id: element['id'].toString(),
          title: element['title'],
          imageUrl: element['imageUrl'],
          description: element['description'],
          location: PlaceLocation(
              latitude: element['place']['latitude'],
              longitude: element['place']['longitude'],
              address: element['place']['address']),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    getPlace(id);
    return Scaffold(
      appBar: AppBar(title: Text(selectedPlace.title)),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image.network(
              selectedPlace.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(height: 10),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              selectedPlace.description, style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(height: 10),
          FlatButton(
            child: Text('View on Map'),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapScreen(
                    initialLocation: selectedPlace.location,
                    isSelecting: false,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
