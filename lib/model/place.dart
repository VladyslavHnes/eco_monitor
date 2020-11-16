import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({
    @required this.latitude,
    @required this.longitude,
    this.address,
  });
}

class Place {
  final String id;
  final String title;
  final String description;
  final PlaceLocation location;
  final File image;
  final String imageUrl;

  Place({
    @required this.id,
    @required this.title,
    this.location,
    this.description,
    this.image,
    this.imageUrl
  });
}
