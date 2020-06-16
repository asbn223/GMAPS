import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyB87_rzA8Bb7bCD7VaOs6vxYHDL12UTW3Y';

class LocationHelper {
  static String getLocationPreviewImg(double latitude, double longitude) {
    return '''https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap
    &markers=color:blue%7Clabel:S%7C$latitude,$longitude
    &key=$GOOGLE_API_KEY''';
  }

  static Future<String> getSpaceAddress(
      double latitude, double longitude) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$GOOGLE_API_KEY';
    final res = await http.get(url);
    final extractedData =
        json.decode(res.body)['results'][0]['formatted_address'];
    print(extractedData);
    return extractedData;
  }
}
