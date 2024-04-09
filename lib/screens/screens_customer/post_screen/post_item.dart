import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/custom_icons.dart';
import 'package:pagepals/screens/screens_customer/post_screen/post_detail.dart';
import 'package:pagepals/widgets/text_widget.dart';
import 'package:unicons/unicons.dart';

class PostItem extends StatefulWidget {
  final String username;
  final String timeAgo;
  final String postText;
  final List<String> imageUrls;

  const PostItem({
    super.key,
    required this.username,
    required this.timeAgo,
    required this.postText,
    required this.imageUrls,
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
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 20,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            PageTransition(
                              child: PostDetailScreen(
                                username: widget.username,
                                timeAgo: widget.timeAgo,
                                postText: widget.postText,
                                imageUrls: widget.imageUrls,
                              ),
                              type: PageTransitionType.fade,
                              duration: const Duration(milliseconds: 300),
                            ),
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.appReadMore,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
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
                    imageUrls: widget.imageUrls,
                  ),
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 300),
                ),
              );
            },
            child: SizedBox(
              height: 250,
              width: double.infinity,
              child: _buildMultiImagePost(widget.imageUrls),
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
                  padding:
                      const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
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
                        imageUrls: widget.imageUrls,
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

  Widget _buildMultiImagePost(images) {
    if (images.isEmpty) {
      return const SizedBox.shrink();
    } else if (images.length == 1) {
      return Image.network(images[0]);
    } else if (images.length == 2) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              images[0],
              height: 250,
              width: double.infinity / 2 - 5.0,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 5.0),
          Expanded(
            child: Image.network(
              images[1],
              height: 250,
              width: double.infinity / 2 - 5.0,
              fit: BoxFit.cover,
            ),
          ),
        ],
      );
    } else if (images.length == 3) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              images[0],
              height: 250,
              width: double.infinity / 2 - 5.0,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 5.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  images[1],
                  height: 122.5,
                  width: double.infinity / 2 - 5.0,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 5.0),
                Image.network(
                  images[2],
                  height: 122.5,
                  width: double.infinity / 2 - 5.0,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  images[0],
                  height: 250,
                  width: double.infinity / 2 - 5.0,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 5.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      images[1],
                      height: 122.5,
                      width: double.infinity / 2 - 5.0,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 5.0),
                    Stack(
                      children: [
                        Image.network(
                          images[2],
                          height: 121,
                          width: double.infinity / 2 - 5.0,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          height: 122.5,
                          color: Colors.grey.withOpacity(0.8),
                          alignment: Alignment.center,
                          child: Text(
                            '+${images.length - 2}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.white,
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
        ],
      );
    }
  }
}
