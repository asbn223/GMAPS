import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gmaps/helper/db_helper.dart';
import 'package:gmaps/helper/location_helper.dart';
import 'package:gmaps/model/space.dart';

class MapSpaces with ChangeNotifier {
  List<Space> _mapItems = [];

  List<Space> get mapItems {
    return [..._mapItems];
  }

  Future<void> addSpace(
      String title, File pickedImg, SpaceLocation selectedLocation) async {
    final address = await LocationHelper.getSpaceAddress(
        selectedLocation.latitude, selectedLocation.longitude);
    print(address);
    final updatedLocation = SpaceLocation(
      latitude: selectedLocation.latitude,
      longitude: selectedLocation.longitude,
      address: address,
    );
    final newSpace = Space(
      id: DateTime.now().toString(),
      title: title,
      img: pickedImg,
      location: updatedLocation,
    );
    _mapItems.add(newSpace);
    notifyListeners();
    DBHelper.insert('user_spaces', {
      'id': newSpace.id,
      'title': newSpace.title,
      'img': newSpace.img.path,
      'loc_lat': newSpace.location.latitude,
      'loc_long': newSpace.location.longitude,
      'address': newSpace.location.address,
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
              location: SpaceLocation(
                latitude: item['loc_lat'],
                longitude: item['loc_long'],
                address: item['address'],
              ),
            ))
        .toList();
    notifyListeners();
  }

  //Find by Id
  Space findById(String id) {
    return _mapItems.firstWhere((space) => space.id == id);
  }
}
