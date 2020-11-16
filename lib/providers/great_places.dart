import 'dart:io';
import 'dart:convert';

import 'package:eco_monitor/helpers/location_helper.dart';
import 'package:eco_monitor/model/place.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';

class GreatPlaces with ChangeNotifier {
  var placesUrl = 'http://10.0.2.2:8080/monitor/places';
  var filesUrl = 'http://10.0.2.2:8081/file/files';

  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  Future<void> addPlace(String pickedTitle, String description, String category,
      File pickedImage, PlaceLocation pickedLocation, String token) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final location = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );
    var url = await uploadImage(pickedImage);

    var placesUri = Uri.parse(placesUrl);
    var bearerToken = 'Bearer ' + token;
    http
        .post(placesUri,
            headers: {
              'content-type': 'application/json',
              'Authorization': bearerToken,
            },
            body: json.encode(
              {
                "category": category,
                "title": pickedTitle,
                "description": description,
                "latitude": location.latitude.toString(),
                "longitude": location.longitude.toString(),
                "address": location.address,
                "imageUrl": url,
              },
            ))
        .then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
    }).catchError((err) {
      print(err);
    });
    notifyListeners();
  }

  Future<void> getPlaces() async {
    http.get(url).then((response) {
      Iterable list = json.decode(response.body);
      list
          .map((element) => new Place(
                id: element['id'].toString(),
                title: element['title'],
                image: File.fromUri(element['imageUrl']),
                // image: File(element['image'])
              ))
          .toList();
    });
    notifyListeners();
  }

  Future<String> uploadImage(File pickedImage) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(pickedImage.openRead()));
    var length = await pickedImage.length();

    var filesUri = Uri.parse(filesUrl);
    var request = new http.MultipartRequest("POST", filesUri);
    var multipartFile =
        new http.MultipartFile('file', stream, length, filename: "file.jpg");
    request.files.add(multipartFile);
    return request.send().then((response) {
      return response.headers['url'];
    });
  }
}
