import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pagepals/screens/screens_reader/reader_request/video_player_from_file.dart';

class ReaderEditProfileScreen extends StatefulWidget {
  const ReaderEditProfileScreen({super.key});

  @override
  State<ReaderEditProfileScreen> createState() =>
      _ReaderEditProfileScreenState();
}

class _ReaderEditProfileScreenState extends State<ReaderEditProfileScreen> {
  File? _selectedVideo;
  File? _selectedImage;

  void _handleVideoSelection() async {
    final result = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (result != null) {
      setState(() {
        _selectedVideo = File(result.path);
      });
    }
  }

  void _handleViewVideo() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          child: VideoPlayerFromFile(
            videoFile: _selectedVideo!,
          ),
        );
      },
    );
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/image_reader.png'),
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
                  const SizedBox(height: 20),
                  const Text(
                    'Change Profile Picture',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDataField('Full Name', 'John Doe', () {
                    showBottomSheet(
                      context,
                      initialValue: 'John Doe',
                      title: 'Full Name',
                    ).then(
                      (value) => {
                        if (value != null) {print(value)}
                      },
                    );
                  }),
                  buildDataField('Email', 'john@gmail.com', () {
                    showBottomSheet(
                      context,
                      initialValue: 'Email',
                      title: 'Email',
                    ).then(
                      (value) => {
                        if (value != null) {print(value)}
                      },
                    );
                  }),
                  buildDataField('Phone Number', '08012345678', () {
                    showBottomSheet(
                      context,
                      initialValue: '08012345678',
                      title: 'Phone Number',
                    ).then(
                      (value) => {
                        if (value != null) {print(value)}
                      },
                    );
                  }),
                  buildDataField('Date of Birth', '12/12/1990', () {
                    showBottomSheet(
                      context,
                      initialValue: '12/12/1990',
                      title: 'Date of Birth',
                    ).then(
                      (value) => {
                        if (value != null) {print(value)}
                      },
                    );
                  }),
                  buildDataField('Location', 'Lagos', () {
                    showBottomSheet(
                      context,
                      initialValue: 'Lagos',
                      title: 'Location',
                    ).then(
                      (value) => {
                        if (value != null) {print(value)}
                      },
                    );
                  }),
                  buildDataField('Language', 'English', () {
                    showBottomSheet(
                      context,
                      initialValue: 'English',
                      title: 'Language',
                    ).then(
                      (value) => {
                        if (value != null) {print(value)}
                      },
                    );
                  }),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Update Video',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 12),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.cloud_upload,
                                      size: 50,
                                    ),
                                    Text('Change Video'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Update Audio',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 12),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.cloud_upload,
                                      size: 50,
                                    ),
                                    Text('Change Audio'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDataField(
    String title,
    String value,
    Function() onTap,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            radius: 10,
            splashColor: Colors.white,
            onTap: onTap,
            child: Row(
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future showBottomSheet(BuildContext context,
      {String? initialValue, String? title}) {
    TextEditingController controller =
        TextEditingController(text: initialValue);

    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: title ?? 'Full Name',
                      hintText: 'John Doe',
                    ),
                  ),
                  const Text(
                    'This information will be visible to other users',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context, {
                          'value': controller.text,
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context, {
                      'value': controller.text,
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future showBottomSheetForUpload(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.3,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  _handleVideoSelection();
                  Navigator.pop(context);
                },
                child: const Text(
                  'Upload Video',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  _handleImageSelection();
                  Navigator.pop(context);
                },
                child: const Text(
                  'Upload Image',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
