import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gmaps/model/space.dart';

class MapSpaces with ChangeNotifier {
  List<Space> _mapItems = [];

  List<Space> get mapItems {
    return [..._mapItems];
  }

  void addSpace(String title, File pickedImg) {
    final newSpace = Space(
      id: DateTime.now().toString(),
      title: title,
      img: pickedImg,
      location: null,
    );
    _mapItems.add(newSpace);
    notifyListeners();
  }
}
