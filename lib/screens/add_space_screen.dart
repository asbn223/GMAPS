import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gmaps/provider/map_spaces.dart';
import 'package:gmaps/widget/image_input.dart';
import 'package:gmaps/widget/space_input.dart';
import 'package:provider/provider.dart';

class AddSpaceScreen extends StatefulWidget {
  static String routeName = '/add_space_screen';
  @override
  _AddSpaceScreenState createState() => _AddSpaceScreenState();
}

class _AddSpaceScreenState extends State<AddSpaceScreen> {
  File _pickedImg;
  TextEditingController _titleController = TextEditingController();

  void _saveSpace() {
    if (_titleController.text.isEmpty || _pickedImg == null) {
      return;
    }
    Provider.of<MapSpaces>(context, listen: false)
        .addSpace(_titleController.text, _pickedImg);
    Navigator.pop(context);
  }

  void _selectedImge(File pickedImg) {
    _pickedImg = pickedImg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Your New Space"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: "Title",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(
                      onSelectedImage: _selectedImge,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SpaceInput(),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            color: Theme.of(context).accentColor,
            label: Text(
              "Add Space",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: _saveSpace,
          ),
        ],
      ),
    );
  }
}
