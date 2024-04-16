import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/models/reader_models/reader_update_model.dart';

class ReaderEditAvatar extends StatefulWidget {
  final ReaderProfile? readerProfile;
  final ReaderUpdate? readerUpdate;
  final Function(String) onAvatarChanged;

  const ReaderEditAvatar(
      {super.key,
      this.readerProfile,
      required this.onAvatarChanged,
      this.readerUpdate});

  @override
  State<ReaderEditAvatar> createState() => _ReaderEditAvatarState();
}

class _ReaderEditAvatarState extends State<ReaderEditAvatar> {
  File? _selectedImage;
  String avatarUrl = 'https://via.placeholder.com/150';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    avatarUrl = widget.readerUpdate?.avatarUrl ??
        widget.readerProfile?.profile?.avatarUrl ??
        avatarUrl;
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      maxHeight: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      setState(() {
        _selectedImage = File(result.path);
        widget.onAvatarChanged(result.path);
      });
    }
  }

  void _handleViewImage() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Image.file(
            _selectedImage!,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey[500]!,
                  //     blurRadius: 5,
                  //     spreadRadius: 2,
                  //     // offset: Offset(0, 2),
                  //   ),
                  // ],
                  border: Border.fromBorderSide(
                    BorderSide(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    _handleImageSelection();
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _selectedImage != null
                        ? FileImage(_selectedImage!) as ImageProvider<Object>
                        : widget.readerUpdate?.avatarUrl != null
                            ? FileImage(File(avatarUrl))
                                as ImageProvider<Object>
                            : NetworkImage(avatarUrl),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 35,
                  width: 35,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.camera_alt,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
