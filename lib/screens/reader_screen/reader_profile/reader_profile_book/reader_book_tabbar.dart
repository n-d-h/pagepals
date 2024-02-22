import 'package:flutter/material.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/screens/reader_screen/reader_profile/reader_profile_book/book_collection_widget.dart';

class ReaderBookTabbar extends StatefulWidget {
  const ReaderBookTabbar({super.key});

  @override
  State<ReaderBookTabbar> createState() => _ReaderBookTabbarState();
}

class _ReaderBookTabbarState extends State<ReaderBookTabbar> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(SpaceHelper.space16),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BookCollectionWidget(),
            BookCollectionWidget(),
            BookCollectionWidget(),
            BookCollectionWidget(),
            BookCollectionWidget(),
          ],
        ),
      ),
    );
  }
}
