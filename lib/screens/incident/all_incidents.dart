import 'dart:convert';

import 'package:eco_monitor/model/place.dart';
import 'package:eco_monitor/screens/incident/incident_detail_screen.dart';
import 'package:eco_monitor/widgets/main_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllIncidents extends StatefulWidget {
  static const routeName = '/all-incidents';

  @override
  _AllIncidentsState createState() => _AllIncidentsState();
}

class _AllIncidentsState extends State<AllIncidents> {
  var url = 'http://10.0.2.2:8080/monitor/places';
  var places = new List<Place>();

  _getPlaces() {
    http.get(url).then((response) => {
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

  initState() {
    super.initState();
    _getPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All incidents'),
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
