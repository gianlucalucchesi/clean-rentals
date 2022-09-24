import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key}) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future _takePicture() async {
    try {
      final imageFile =
          await ImagePicker().getImage(source: ImageSource.camera);
      if (imageFile == null) return;

      final imageTemp = File(imageFile.path);
      setState(() {
        _storedImage = imageTemp;
      });
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  Future _selectFromGallery() async {
    try {
      final imageFile =
          await ImagePicker().getImage(source: ImageSource.gallery);
      if (imageFile == null) return;

      final imageTemp = File(imageFile.path);
      setState(() {
        _storedImage = imageTemp;
      });
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(20.0),
          width: double.infinity,
          height: 230,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.camera_alt),
              label: const Text('Take Picture'),
              onPressed: _takePicture,
            ),
            const Divider(),
            TextButton.icon(
              icon: const Icon(Icons.image_sharp),
              label: const Text('Select from gallery'),
              onPressed: _selectFromGallery,
            ),
          ],
        )
      ],
    );
  }
}
