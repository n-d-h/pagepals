import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/services/file_storage_service.dart';
import 'package:pagepals/services/post_service.dart';

class PostStatusScreen extends StatefulWidget {
  const PostStatusScreen({super.key, this.accountModel});

  final AccountModel? accountModel;

  @override
  State<PostStatusScreen> createState() => _PostStatusScreenState();
}

class _PostStatusScreenState extends State<PostStatusScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  List<File> _images = [];

  void _handleChooseMultiImage() async {
    final result = await ImagePicker().pickMultiImage();
    setState(() {
      _images = result.map((e) => File(e.path)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(context);
          },
          splashRadius: 24,
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.appCreatePost,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.2,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ElevatedButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: ColorHelper.getColor(ColorHelper.green),
                        size: 60,
                      ),
                    );
                  },
                );

                String content = _textEditingController.text;
                List<String> images = await FileStorageService.uploadMultiImage(
                  _images,
                );
                String readerId = widget.accountModel?.reader?.id ?? '';
                String title = 'Post';

                await PostService.createPost(
                  content,
                  images,
                  readerId,
                  title,
                );

                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 3,
                  vertical: 3,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.appPost,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.2,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      widget.accountModel?.reader?.avatarUrl ??
                          'https://via.placeholder.com/150',
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.accountModel?.reader?.nickname ?? 'John Doe',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Public',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: _handleChooseMultiImage,
                    icon: const Icon(
                      Icons.photo,
                      color: Colors.green,
                      size: 25,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Colors.blueAccent,
                      size: 25,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                autofocus: true,
                maxLines: 10,
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.appWhatAreYouThinking,
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.blueAccent,
                      width: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _images.isEmpty
                  ? Container()
                  : SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _images.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                _images[index],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
