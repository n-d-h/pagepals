import 'package:flutter/material.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/widgets/text_widget.dart';

class BookCollectionWidget extends StatefulWidget {
  const BookCollectionWidget({super.key});

  @override
  State<BookCollectionWidget> createState() => _BookCollectionWidgetState();
}

class _BookCollectionWidgetState extends State<BookCollectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(SpaceHelper.space8),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(
            image: AssetImage('assets/image_rabbit.png'),
            fit: BoxFit.cover,
            width: 100,
          ),
          SizedBox(
            width: SpaceHelper.space8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextWidget(
                length: 230,
                content: 'Thỏ Bảy Màu Và Những Người Nghĩ Nó Là Bạn',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                softWrap: false,
                fontWeight: FontWeight.bold,
              ),
              TextWidget(
                length: 230,
                height: 70,
                content: 'Author Name',
                overflow: TextOverflow.ellipsis,
                fontSize: SpaceHelper.space14,
                maxLines: 1,
                softWrap: false,
              ),
              TextWidget(
                length: 230,
                content: '15000VND',
                overflow: TextOverflow.ellipsis,
                fontSize: SpaceHelper.space14,
                maxLines: 1,
                softWrap: false,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
