import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/custom_icons.dart';
import 'package:pagepals/screens/post_screen/post_detail.dart';
import 'package:pagepals/widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:unicons/unicons.dart';

class PostItem extends StatefulWidget {
  final String username;
  final String timeAgo;
  final String postText;
  final String imageUrl;

  const PostItem({
    super.key,
    required this.username,
    required this.timeAgo,
    required this.postText,
    required this.imageUrl,
  });

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  int likesCount = 0;
  int cmtCount = 0;
  bool showFullComment = false;
  bool liked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 5.0,
            color: Colors.grey[300],
            margin: const EdgeInsets.symmetric(vertical: 12.0),
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/image_reader.png'),
                ),
                const SizedBox(width: 12.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.username,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.timeAgo,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                length: double.infinity,
                height: 50,
                content: widget.postText,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
              if (widget.postText.length > 100)
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      PageTransition(
                        child: PostDetailScreen(
                          username: widget.username,
                          timeAgo: widget.timeAgo,
                          postText: widget.postText,
                          imageUrl: widget.imageUrl,
                        ),
                        type: PageTransitionType.fade,
                        duration: const Duration(milliseconds: 300),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.appReadMore,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8.0),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                PageTransition(
                  child: PostDetailScreen(
                    username: widget.username,
                    timeAgo: widget.timeAgo,
                    postText: widget.postText,
                    imageUrl: widget.imageUrl,
                  ),
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 300),
                ),
              );
            },
            child: Image.network(
              widget.imageUrl,
              height: 200.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    liked = !liked;
                    liked == true ? likesCount++ : likesCount--;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                  child: Row(
                    children: [
                      liked
                          ? const Icon(
                              CustomIcons.thumbs_up,
                              color: Colors.blue,
                            )
                          : const Icon(UniconsLine.thumbs_up),
                      const SizedBox(width: 4.0),
                      Text(
                        '$likesCount ${AppLocalizations.of(context)!.appLikes}',
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    PageTransition(
                      child: PostDetailScreen(
                        username: widget.username,
                        timeAgo: widget.timeAgo,
                        postText: widget.postText,
                        imageUrl: widget.imageUrl,
                      ),
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 300),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 8),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 8.0),
                        child: const Icon(UniconsLine.comment),
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        '$cmtCount ${AppLocalizations.of(context)!.appComments}',
                      ),
                    ],
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
