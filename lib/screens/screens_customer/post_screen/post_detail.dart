import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pagepals/custom_icons.dart';
import 'package:unicons/unicons.dart';

import 'comment_widget.dart';

class PostDetailScreen extends StatefulWidget {
  final String username;
  final String timeAgo;
  final String postText;
  final List<String> imageUrls;

  const PostDetailScreen({
    super.key,
    required this.username,
    required this.timeAgo,
    required this.postText,
    required this.imageUrls,
  });

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final listCommentModels = [
    CommentModel(
      comment: CommentItem(
        id: '1',
        avatar: 'null',
        userName: 'null',
        content: 'felangel made felangel/cubit_and_beyond public ',
      ),
      replies: [
        CommentItem(
          id: '1.1',
          avatar: 'null',
          userName: 'null',
          content: 'A Dart template generator which helps teams',
        ),
        CommentItem(
          id: '1.2',
          avatar: 'null',
          userName: 'null',
          content:
              'A Dart template generator which helps teams generator which helps teams generator which helps teams',
        ),
        CommentItem(
          id: '1.3',
          avatar: 'null',
          userName: 'null',
          content: 'A Dart template generator which helps teams',
        ),
        CommentItem(
          id: '1.4',
          avatar: 'null',
          userName: 'null',
          content:
              'A Dart template generator which helps teams generator which helps teams ',
        ),
      ],
    ),
    CommentModel(
      comment: CommentItem(
        id: '2',
        avatar: 'null',
        userName: 'null',
        content: 'felangel made felangel/cubit_and_beyond public ',
      ),
      replies: [
        CommentItem(
          id: '2.1',
          avatar: 'null',
          userName: 'null',
          content: 'A Dart template generator which helps teams',
        ),
        CommentItem(
          id: '2.2',
          avatar: 'null',
          userName: 'null',
          content:
              'A Dart template generator which helps teams generator which helps teams generator which helps teams',
        ),
      ],
    ),
  ];

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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
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
                  FlutterCarousel(
                    options: CarouselOptions(
                      height: 400.0,
                      showIndicator: true,
                      viewportFraction: 1.0,
                      slideIndicator: const CircularSlideIndicator(),
                    ),
                    items: widget.imageUrls.map((i) {
                      return Image.network(
                        i,
                        fit: BoxFit.cover,
                      );
                    }).toList(),
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
                        Theme(
                          data: ThemeData(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          child: InkWell(
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
                                          CustomIcons.thumbs_up,
                                          color: Colors.blue,
                                        )
                                      : const Icon(UniconsLine.thumbs_up),
                                  onPressed: () {},
                                ),
                                const SizedBox(width: 4.0),
                                Text(AppLocalizations.of(context)!.appLikes),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(12.0),
                          onTap: () {
                            _commentFocusNode.canRequestFocus = true;
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
                  CommentWidget(
                    commentFocusNode: _commentFocusNode,
                    listCommentModels: listCommentModels,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 12.0,
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
                      contentPadding: const EdgeInsets.all(12.0),
                      hintStyle: const TextStyle(
                        fontSize: 12.0,
                      ),
                      hintText: AppLocalizations.of(context)!.appAddComment,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          print('Comment: ${_commentController.text}');
                          _commentController.clear();
                          CommentItem commentItem = CommentItem(
                            id: '1.5',
                            avatar: 'null',
                            userName: 'null',
                            content: _commentController.text,
                          );
                          CommentModel commentModel = CommentModel(
                            comment: commentItem,
                            replies: [],
                          );
                          listCommentModels.add(commentModel);
                        },
                      ),
                    ),
                    onSubmitted: (value) {
                      print('Comment: $value');
                      _commentController.clear();
                      CommentItem commentItem = CommentItem(
                        id: '1.5',
                        avatar: 'null',
                        userName: 'null',
                        content: value,
                      );
                      CommentModel commentModel = CommentModel(
                        comment: commentItem,
                        replies: [],
                      );
                      listCommentModels.add(commentModel);
                      setState(() {
                        _commentFocusNode.unfocus();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
