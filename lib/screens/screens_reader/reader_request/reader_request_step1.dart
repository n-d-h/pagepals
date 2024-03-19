import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReaderRequestStep1 extends StatefulWidget {
  const ReaderRequestStep1({super.key});

  @override
  State<ReaderRequestStep1> createState() => _ReaderRequestStep1State();
}

class _ReaderRequestStep1State extends State<ReaderRequestStep1> {
  String? _name;
  int? _age;
  String? _address;
  File? _selectedImage;

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      maxHeight: 270,
      source: ImageSource.gallery,
    );

    if (result != null) {
      setState(() {
        _selectedImage = File(result.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
            onSaved: (value) {
              _name = value;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Age'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your age';
              }
              return null;
            },
            onSaved: (value) {
              _age = int.tryParse(value!);
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Address'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your address';
              }
              return null;
            },
            onSaved: (value) {
              _address = value;
            },
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Upload Image:',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          Container(
            width: double.infinity,
            height: 300.0,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(
                style: BorderStyle.solid,
                color: Colors.grey,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _selectedImage != null
                    ? Image.file(_selectedImage!)
                    : const Icon(
                        Icons.image,
                        size: 60.0,
                        color: Colors.grey,
                      ),
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: _handleImageSelection,
                child: const Text('Choose Image'),
              ),
              ElevatedButton(
                onPressed: () async {
                  print(_selectedImage);
                },
                child: const Text('Upload'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
