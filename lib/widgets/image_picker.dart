import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWid extends StatefulWidget {
  final Function submitFn;

  ImagePickerWid(this.submitFn);

  @override
  _ImagePickerWidState createState() => _ImagePickerWidState();
}

class _ImagePickerWidState extends State<ImagePickerWid> {
  File _pickedImage;
  void _pickImage() async {
    final iamgePicker = ImagePicker();
    final pickedImage = await iamgePicker.getImage(
        source: ImageSource.camera, imageQuality: 50, maxWidth: 150);
    final imageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = imageFile;
    });
    widget.submitFn(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          backgroundImage:
              _pickedImage == null ? null : FileImage(_pickedImage),
          backgroundColor: Colors.grey[200],
          radius: 70,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('Add Image'),
        ),
      ],
    );
  }
}
