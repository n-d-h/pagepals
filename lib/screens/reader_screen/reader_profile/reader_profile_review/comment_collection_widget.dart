import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pagepals/helpers/color_helper.dart';
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
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(
        top: SpaceHelper.space4,
        bottom: SpaceHelper.space10,
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/image_reader.png'),
              ),
              SizedBox(width: SpaceHelper.space12),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      '@builevanminh',
                      style: TextStyle(
                        fontSize: SpaceHelper.fontSize14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: ColorHelper.getColor('#FFA800'),
                        ),
                        const SizedBox(width: 0.5),
                        const Text(
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
                const SizedBox(height: SpaceHelper.space4),
                const Row(
                  children: [
                    Image(image: AssetImage('assets/image_vn.png')),
                    SizedBox(width: SpaceHelper.space4),
                    Text(
                      'Vietnamese',
                      style: TextStyle(
                        fontSize: SpaceHelper.fontSize10,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: SpaceHelper.space4),
                const Text(
                  '2 months ago',
                  style: TextStyle(
                    fontSize: SpaceHelper.fontSize10,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: SpaceHelper.space8),
                TextWidget(
                  length: double.infinity,
                  height: showFullComment ? 155 : 50,
                  content: 'Giọng đọc hay, lôi cuốn, nghe không biết chán, '
                      'đẹp trai, có múi, da ngăm giọng trầm đeo kính cận, '
                      'lịch sự, take care tốt khách hàng',
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
          ),
        ],
      ),
    );
  }
}
