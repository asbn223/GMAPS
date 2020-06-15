import 'package:flutter/material.dart';
import 'package:gmaps/helper/location_helper.dart';
import 'package:gmaps/screens/map_screen.dart';
import 'package:location/location.dart';

class SpaceInput extends StatefulWidget {
  @override
  _SpaceInputState createState() => _SpaceInputState();
}

class _SpaceInputState extends State<SpaceInput> {
  String _previewImageUrl;

  Future<void> _getUserLocation() async {
    final locData = await Location().getLocation();
    final staticMapImageUrl = LocationHelper.getLocationPreviewImg(
        locData.latitude, locData.longitude);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> selectYourLocation() async {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => MapScreen(
                isSelecting: true,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: _previewImageUrl == null
              ? Text(
                  "No Location Selected",
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              onPressed: _getUserLocation,
              icon: Icon(Icons.location_on),
              label: Text("Your Location"),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: () {},
              icon: Icon(Icons.map),
              label: Text("Select from Map"),
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        )
      ],
    );
  }
}
