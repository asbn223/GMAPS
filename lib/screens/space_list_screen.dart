import 'package:flutter/material.dart';
import 'package:gmaps/provider/map_spaces.dart';
import 'package:gmaps/screens/add_space_screen.dart';
import 'package:provider/provider.dart';

class SpaceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GMAPS Space"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(
              context,
              AddSpaceScreen.routeName,
            ),
          ),
        ],
      ),
      body: Consumer<MapSpaces>(
        builder: (BuildContext context, MapSpaces mapSpaces, Widget child) =>
            mapSpaces.mapItems.length <= 0
                ? child
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              FileImage(mapSpaces.mapItems[index].img),
                        ),
                        title: Text(
                          mapSpaces.mapItems[index].title,
                        ),
                      );
                    },
                    itemCount: mapSpaces.mapItems.length,
                  ),
        child: Center(
          child: const Text("There are no map spaces."),
        ),
      ),
    );
  }
}
