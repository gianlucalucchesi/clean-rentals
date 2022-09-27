import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gallery_saver/gallery_saver.dart';

class ImageInput extends StatefulWidget {
  final Function setSavedImagePath;

  const ImageInput({Key? key, required this.setSavedImagePath})
      : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future _takePicture() async {
    try {
      final pickedImage =
          await ImagePicker().getImage(source: ImageSource.camera);

      if (pickedImage == null) return;

      var success = await GallerySaver.saveImage(pickedImage.path);

      if (success!) {
        final imageFile = File(pickedImage.path);
        widget.setSavedImagePath(pickedImage.path);

        setState(() => _storedImage = imageFile);
      }
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  Future _selectFromGallery() async {
    try {
      final pickedImage =
          await ImagePicker().getImage(source: ImageSource.gallery);
      if (pickedImage == null) return;

      final imageFile = File(pickedImage.path);
      widget.setSavedImagePath(pickedImage.path);

      setState(() => _storedImage = imageFile);
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
                  'Take or select an image',
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
