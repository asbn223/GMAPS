import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPath;

class ImageInput extends StatefulWidget {
  final Function onSelectedImage;

  ImageInput({this.onSelectedImage});
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;
  final _imagePicker = ImagePicker();

  Future<void> _takePic() async {
    final img = await _imagePicker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
      imageQuality: 9,
    );

    setState(() {
      _storedImage = File(img.path);
    });

    final appDir = await sysPath.getApplicationDocumentsDirectory();
    final fileName = path.basename(img.path);
    final saveImage = await _storedImage.copy('${appDir.path}/$fileName');
    widget.onSelectedImage(saveImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          alignment: Alignment.center,
          child: _storedImage == null
              ? Text(
                  "No Image",
                  textAlign: TextAlign.center,
                )
              : Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            onPressed: _takePic,
            icon: Icon(Icons.camera_alt),
            label: Text("Take a Picture"),
            textColor: Theme.of(context).primaryColor,
          ),
        )
      ],
    );
  }
}
