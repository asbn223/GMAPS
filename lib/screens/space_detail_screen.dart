import 'package:flutter/material.dart';
import 'package:gmaps/provider/map_spaces.dart';
import 'package:gmaps/screens/map_screen.dart';
import 'package:provider/provider.dart';

class SpaceDetailScreen extends StatelessWidget {
  static String routeName = '/space_detail_screen';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final selectedSpace = Provider.of<MapSpaces>(context).findById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedSpace.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedSpace.img,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            selectedSpace.location.address,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            child: Text('View on Map'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MapScreen(
                          initialLocation: selectedSpace.location,
                          isSelecting: false,
                        )),
              );
            },
            textColor: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
