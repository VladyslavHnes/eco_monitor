import 'dart:io';

import 'package:eco_monitor/model/place.dart';
import 'package:eco_monitor/providers/auth.dart';
import 'package:eco_monitor/providers/great_places.dart';
import 'package:eco_monitor/widgets/image_input.dart';
import 'package:eco_monitor/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddIncidentState extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddIncidentState createState() => _AddIncidentState();
}

class _AddIncidentState extends State<AddIncidentState> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _savePlace(String category) {
    // if (_titleController.text.isEmpty ||
    //     _pickedImage == null ||
    //     _pickedLocation == null) {
    //   return;
    // }
    var token = Provider.of<Auth>(context, listen: false).token;
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _descriptionController.text, category, _pickedImage, _pickedLocation, token);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments as Map<String, String>;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Description'),
                      controller: _descriptionController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                    SizedBox(
                      height: 10,
                    ),
                    LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            onPressed: () => _savePlace(args['title']),
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}
class ScreenArguments {
  final String id;
  final String title;

  ScreenArguments(this.title, this.id);
}
