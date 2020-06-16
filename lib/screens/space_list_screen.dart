import 'package:flutter/material.dart';
import 'package:gmaps/provider/map_spaces.dart';
import 'package:gmaps/screens/add_space_screen.dart';
import 'package:gmaps/screens/space_detail_screen.dart';
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
      body: FutureBuilder(
        future:
            Provider.of<MapSpaces>(context, listen: false).fetchandSetSpace(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Consumer<MapSpaces>(
              builder: (BuildContext context, MapSpaces mapSpaces,
                      Widget child) =>
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
                              subtitle: Text(
                                  mapSpaces.mapItems[index].location.address),
                              onTap: () => Navigator.pushNamed(
                                context,
                                SpaceDetailScreen.routeName,
                                arguments: mapSpaces.mapItems[index].id,
                              ),
                            );
                          },
                          itemCount: mapSpaces.mapItems.length,
                        ),
              child: Center(
                child: const Text("There are no map spaces."),
              ),
            );
          }
        },
      ),
    );
  }
}
