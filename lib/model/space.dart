import 'dart:io';

import 'package:flutter/material.dart';

class SpaceLocation {
  final double latitude, longitude;
  final String address;

  const SpaceLocation({
    @required this.latitude,
    @required this.longitude,
    this.address,
  });
}

class Space {
  final String id, title;
  final SpaceLocation location;
  final File img;

  Space({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.img,
  });
}
