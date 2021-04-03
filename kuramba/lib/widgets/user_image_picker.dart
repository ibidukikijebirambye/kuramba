import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(
    File pickedImage,
  ) pickImage;

  UserImagePicker(
    this.pickImage,
  );

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _previewImage;

  void _pickImage() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        content: Text(
          'Take a picture or choose one from your gallery!',
        ),
        actions: [
          TextButton.icon(
            onPressed: () async {
              final pickedImage = await ImagePicker().getImage(
                source: ImageSource.gallery,
                maxHeight: 400,
                maxWidth: 400,
              );
              setState(() {
                _previewImage = pickedImage == null
                    ? _previewImage
                    : File(
                        pickedImage.path,
                      );
              });
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.image_rounded,
            ),
            label: Text(
              'Gallery',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () async {
              final pickedImage = await ImagePicker().getImage(
                source: ImageSource.camera,
                maxHeight: 400,
                maxWidth: 400,
              );
              setState(() {
                _previewImage = pickedImage == null
                    ? _previewImage
                    : File(
                        pickedImage.path,
                      );
              });
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.camera_alt_rounded,
            ),
            label: Text(
              'Camera',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
    widget.pickImage(
      _previewImage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Theme.of(context).primaryColor,
          child: _previewImage == null
              ? Icon(
                  Icons.person_rounded,
                  size: 50,
                  color: Colors.white,
                )
              : null,
          backgroundImage: _previewImage == null
              ? null
              : FileImage(
                  _previewImage,
                ),
        ),
        SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: _pickImage,
          child: Text(
            'Add an image',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
