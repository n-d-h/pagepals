import 'package:flutter/material.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/widgets/text_widget.dart';

class CommentCollectionWidget extends StatefulWidget {
  const CommentCollectionWidget({super.key});

  @override
  State<CommentCollectionWidget> createState() =>
      _CommentCollectionWidgetState();
}

class _CommentCollectionWidgetState extends State<CommentCollectionWidget> {
  bool showFullComment = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: SpaceHelper.space10,
        bottom: SpaceHelper.space10,
      ),
      padding: const EdgeInsets.all(SpaceHelper.space10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/image_reader.png'),
          ),
          const SizedBox(width: SpaceHelper.space10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                '@builevanminh',
                style: TextStyle(
                  fontSize: SpaceHelper.fontSize10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: SpaceHelper.space8),
              const Row(children: [
                Image(image: AssetImage('assets/image_vn.png')),
                SizedBox(width: SpaceHelper.space4),
                Text(
                  'Vietnamese',
                  style: TextStyle(
                    fontSize: SpaceHelper.fontSize10,
                  ),
                ),
              ]),
              SizedBox(height: SpaceHelper.space8),
              const Text(
                '2 months ago',
                style: TextStyle(
                  fontSize: SpaceHelper.fontSize10,
                ),
              ),
              const SizedBox(height: SpaceHelper.space8),
              TextWidget(
                length: 200,
                height: showFullComment ? 160 : 50,
                content: 'Giọng đọc hay, lôi cuốn, nghe không biết chán, đẹp trai, có múi, da ngăm giọng trầm đeo kính cận, lịch sự, take care tốt khách hàng',
                overflow: TextOverflow.ellipsis,
                maxLines: showFullComment ? 10 : 2,
                softWrap: true,
                fontSize: SpaceHelper.fontSize12,
              ),
              const SizedBox(height: SpaceHelper.space4),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showFullComment = !showFullComment;
                  });
                },
                child: Text(
                  showFullComment ? 'Less' : 'More',
                  style: const TextStyle(
                    fontSize: SpaceHelper.fontSize10,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          const Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.orange,
              ),
              Text(
                '5.0',
                style: TextStyle(
                  fontSize: SpaceHelper.fontSize14,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
