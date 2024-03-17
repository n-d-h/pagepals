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
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Image(
            image: AssetImage('assets/image_rabbit.png'),
            fit: BoxFit.cover,
            width: 80,
          ),
          const SizedBox(
            width: SpaceHelper.space8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const TextWidget(
                length: 220,
                height: 45,
                content: 'Thỏ Bảy Màu Và Những Người Nghĩ Nó Là Bạn',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                softWrap: false,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'by',
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          color: Colors.grey),
                    ),
                    const SizedBox(width: 3),
                    TextWidget(
                      length: 220,
                      height: 20,
                      content: 'Author Name',
                      color: Colors.black.withOpacity(0.6),
                      overflow: TextOverflow.ellipsis,
                      fontSize: SpaceHelper.space14,
                      maxLines: 1,
                      softWrap: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
