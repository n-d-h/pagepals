import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/material.dart';

class CommentItem {
  String? id;
  String? avatar;
  String? userName;
  String? content;

  CommentItem({
    this.id,
    this.content,
    this.avatar,
    this.userName,
  });
}

class CommentModel {
  final CommentItem comment;
  final List<CommentItem> replies;

  CommentModel({
    required this.comment,
    required this.replies,
  });
}

class CommentWidget extends StatelessWidget {
  const CommentWidget(
      {super.key,
      required this.commentFocusNode,
      required this.listCommentModels});

  final FocusNode commentFocusNode;
  final List<CommentModel> listCommentModels;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listCommentModels.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: CommentTreeWidget<CommentItem, CommentItem>(
            listCommentModels[index].comment,
            listCommentModels[index].replies,
            treeThemeData: TreeThemeData(
              lineColor: listCommentModels[index].replies.isNotEmpty
                  ? Colors.grey[500]!
                  : Colors.white,
              lineWidth: 1,
            ),
            avatarRoot: (context, data) => const PreferredSize(
              preferredSize: Size.fromRadius(18),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage('assets/image_reader.png'),
              ),
            ),
            avatarChild: (context, data) => const PreferredSize(
              preferredSize: Size.fromRadius(12),
              child: CircleAvatar(
                radius: 12,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage('assets/image_reader.png'),
              ),
            ),
            contentChild: (context, data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'dangngocduc',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${data.content}',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              Scrollable.ensureVisible(
                                context,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                                alignmentPolicy: ScrollPositionAlignmentPolicy
                                    .keepVisibleAtEnd,
                                alignment: 0.5,
                              );
                              commentFocusNode.canRequestFocus = true;
                              commentFocusNode.requestFocus();
                            },
                            child: const Text('Reply'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            contentRoot: (context, data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'dangngocduc',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${data.content}',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              Scrollable.ensureVisible(
                                context,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                                alignmentPolicy: ScrollPositionAlignmentPolicy
                                    .keepVisibleAtEnd,
                                alignment: 0.5,
                              );
                              commentFocusNode.canRequestFocus = true;
                              commentFocusNode.requestFocus();
                            },
                            child: const Text('Reply'),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}
