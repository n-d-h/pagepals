import 'package:flutter/material.dart';
import 'package:pagepals/models/comment_model.dart';

class CommentCollectionItem extends StatelessWidget {
  const CommentCollectionItem({super.key, this.comment});

  final CommentItem? comment;

  @override
  Widget build(BuildContext context) {
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
                  Icons.star,
                  color: Colors.yellow,
                ),
              for (int i = 0; i < 5 - comment!.rating!; i++)
                const Icon(
                  Icons.star,
                  color: Colors.grey,
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(comment!.review!),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
