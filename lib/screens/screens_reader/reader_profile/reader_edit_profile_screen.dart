import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/bottom_nav_button.dart';
import 'package:pagepals/screens/screens_reader/reader_profile/reader_edit_field.dart';
import 'package:pagepals/screens/screens_reader/reader_request/video_player_from_file.dart';

class ReaderEditProfileScreen extends StatefulWidget {
  const ReaderEditProfileScreen({super.key, this.readerProfile});

  final ReaderProfile? readerProfile;

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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String avatarUrl = widget.readerProfile?.profile?.avatarUrl ??
        'https://via.placeholder.com/150';
    String nickname = widget.readerProfile?.profile?.nickname ?? 'Nick name';
    String email = widget.readerProfile?.profile?.account?.email ??
        'reader.account@email.com';
    String phoneNumber =
        widget.readerProfile?.profile?.account?.phoneNumber ?? '09xxx78580';

    String dob = widget.readerProfile?.profile?.account?.customer?.dob ??
        '03/07/2002 00:00:00';
    String formatDOB = DateFormat('dd/MM/yyyy').format(DateTime.parse(dob));

    String language = widget.readerProfile?.profile?.language ?? 'English';
    String videoUrl = widget.readerProfile?.profile?.introductionVideoUrl ??
        'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4';
    String audioUrl = widget.readerProfile?.profile?.audioDescriptionUrl ??
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';
    String countryAccent =
        widget.readerProfile?.profile?.countryAccent ?? 'Spanish';
    String description = widget.readerProfile?.profile?.description ??
        'I am a reader who loves to read books and share my thoughts with others.';
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
        surfaceTintColor: Colors.grey[100],
        backgroundColor: Colors.grey[100],
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
                                ? FileImage(_selectedImage!)
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
            ),
            Container(
              // padding: const EdgeInsets.only(left: 20),
              width: double.infinity,
              child: Text(
                textAlign: TextAlign.center,
                'Personal Information',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[300]!,
                          blurRadius: 5,
                          spreadRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ReaderEditField(
                          title: 'Nick Name',
                          value: nickname,
                          onTap: () {
                            showBottomSheet(
                              context,
                              initialValue: nickname,
                              title: 'Nick name',
                            ).then(
                              (value) => {
                                if (value != null) {print(value)}
                              },
                            );
                          },
                        ),
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: Colors.grey[300],
                        ),
                        buildDataField('Email', email, () {
                          // Email field is not editable
                        }),
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: Colors.grey[200],
                        ),
                        buildDataField('Phone Number', phoneNumber, () {
                          showBottomSheet(
                            context,
                            initialValue: phoneNumber,
                            title: 'Phone Number',
                          ).then(
                            (value) => {
                              if (value != null) {print(value)}
                            },
                          );
                        }),
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: Colors.grey[300],
                        ),
                        buildDataField('Date of Birth', formatDOB, () {
                          showBottomSheet(
                            context,
                            initialValue: formatDOB,
                            title: 'Date of Birth',
                          ).then(
                            (value) => {
                              if (value != null) {print(value)}
                            },
                          );
                        }),
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: Colors.grey[300],
                        ),
                        buildDataField('Language', language, () {
                          showBottomSheet(
                            context,
                            initialValue: language,
                            title: 'Language',
                          ).then(
                            (value) => {
                              if (value != null) {print(value)}
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const Text(
                            //   'Update Video',
                            //   style: TextStyle(
                            //     fontSize: 17,
                            //     fontWeight: FontWeight.w500,
                            //   ),
                            // ),
                            const SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                showBottomSheetForUpload(context);
                              },
                              child: Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[300]!,
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.cloud_upload,
                                      size: 50,
                                      color: Colors.blue,
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
                            // const Text(
                            //   'Update Audio',
                            //   style: TextStyle(
                            //     fontSize: 17,
                            //     fontWeight: FontWeight.w500,
                            //   ),
                            // ),
                            const SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                showBottomSheetForUpload(context);
                              },
                              child: Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[300]!,
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.cloud_upload,
                                      size: 50,
                                      color: Colors.deepOrange,
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
      // bottomNavigationBar: BottomButton(
      //   isEnabled: true,
      //   onPressed: () {},
      //   title: 'Save Changes',
      // ),
    );
  }

  Widget buildDataField(
    String title,
    String value,
    Function() onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        // margin: const EdgeInsets.only(bottom: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future showBottomSheet(BuildContext context,
      {String? initialValue, String? title}) {
    TextEditingController controller =
        TextEditingController(text: initialValue);

    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(10),
              alignment: Alignment.bottomCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: title ?? 'Nick Name',
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
            ),
            Positioned(
              top: 0,
              right: 2,
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
