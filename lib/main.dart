import 'package:flutter/material.dart';
import 'package:gmaps/provider/map_spaces.dart';
import 'package:gmaps/screens/add_space_screen.dart';
import 'package:gmaps/screens/space_detail_screen.dart';
import 'package:gmaps/screens/space_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MapSpaces(),
      child: MaterialApp(
        title: "GMAPS",
        theme: ThemeData(
          primaryColor: Color(0xFF1E90FF),
          accentColor: Color(0xFFFF6B6B),
        ),
        home: SpaceListScreen(),
        routes: {
          AddSpaceScreen.routeName: (context) => AddSpaceScreen(),
          SpaceDetailScreen.routeName: (context) => SpaceDetailScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
