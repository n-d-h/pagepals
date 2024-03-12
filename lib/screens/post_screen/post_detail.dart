import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pagepals/screens/post_screen/post_comment.dart';
import 'package:unicons/unicons.dart';

class PostDetailScreen extends StatefulWidget {
  final String username;
  final String timeAgo;
  final String postText;
  final String imageUrl;

  const PostDetailScreen({
    super.key,
    required this.username,
    required this.timeAgo,
    required this.postText,
    required this.imageUrl,
  });

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  bool liked = false;
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('assets/image_reader.png'),
              ),
              SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jone Doe',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '2 hours ago',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              child: Text(
                widget.postText,
                style: const TextStyle(
                  fontSize: 16.0,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Image.network(
              widget.imageUrl,
              width: double.infinity,
              height: 300.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        liked = !liked;
                      });
                    },
                    child: Row(
                      children: [
                        IconButton(
                          icon: liked
                              ? const Icon(
                                  Icons.thumb_up,
                                  color: Colors.blue,
                                )
                              : const Icon(Icons.thumb_up_outlined),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 4.0),
                        Text(AppLocalizations.of(context)!.appLikes),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _commentFocusNode.requestFocus();
                    },
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 8.0),
                          child: const Icon(UniconsLine.comment),
                        ),
                        const SizedBox(width: 4.0),
                        Text(AppLocalizations.of(context)!.appComments),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              child: Text(
                AppLocalizations.of(context)!.appComments,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('assets/image_reader.png'),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: TextField(
                      focusNode: _commentFocusNode,
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.appAddComment,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.send),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            const PostComment(),
            const PostComment(),
            const PostComment(),
            const PostComment(),
          ],
        ),
      ),
    );
  }
}
