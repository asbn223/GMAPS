import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gmaps/helper/db_helper.dart';
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
    DBHelper.insert('user_spaces', {
      'id': newSpace.id,
      'title': newSpace.title,
      'img': newSpace.img.path,
    });
  }

  //Fetching data from the database
  Future<void> fetchandSetSpace() async {
    final spaceList = await DBHelper.getdata('user_spaces');
    _mapItems = spaceList
        .map((item) => Space(
              id: item['id'],
              title: item['title'],
              img: File(item['img']),
              location: null,
            ))
        .toList();
    notifyListeners();
  }
}
