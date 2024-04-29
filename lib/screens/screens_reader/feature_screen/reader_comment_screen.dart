import 'package:flutter/material.dart';
import 'package:pagepals/models/comment_model.dart';

class ReaderCommentScreen extends StatefulWidget {
  const ReaderCommentScreen({super.key, this.commentModel});

  final CommentModel? commentModel;

  @override
  State<ReaderCommentScreen> createState() => _ReaderCommentScreenState();
}

class _ReaderCommentScreenState extends State<ReaderCommentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        centerTitle: true,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(
            color: Colors.black.withOpacity(0.1),
            height: 0.5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.commentModel?.list?.length ?? 0,
              itemBuilder: (context, index) {
                CommentItem? comment = widget.commentModel?.list![index];
                return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      width: 0.3,
                      color: Colors.black.withOpacity(0.4),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.2),
                        blurRadius: 3,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              comment?.customer?.imageUrl ??
                                  'https://via.placeholder.com/150',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comment?.customer?.fullName ?? 'Anonymous',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                comment?.date ?? DateTime.now().toString(),
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          for (int i = 0; i < comment!.rating!; i++)
                            const Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                            ),
                          for (int i = 0; i < 5 - comment.rating!; i++)
                            const Icon(
                              Icons.star_border_rounded,
                              color: Colors.amber,
                            ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(comment.review!),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
