import 'package:flutter/material.dart';
import 'package:pagepals/models/reader_models/popular_reader_model.dart';
import 'package:pagepals/screens/screens_customer/home_screen/popular_readers_widgets/favorite_button.dart';
import 'package:pagepals/screens/screens_customer/home_screen/popular_readers_widgets/popular_reader_box.dart';
import 'package:pagepals/screens/screens_customer/home_screen/popular_readers_widgets/popular_reader_shimmer.dart';
import 'package:pagepals/services/reader_service.dart';

class PopularReaderWidget extends StatefulWidget {
  const PopularReaderWidget({super.key});

  @override
  State<PopularReaderWidget> createState() => _PopularReaderWidgetState();
}

class _PopularReaderWidgetState extends State<PopularReaderWidget> {
  List<PopularReader> readers = [];

  @override
  void initState() {
    super.initState();
    getListPopularReaders();
  }

  Future<void> getListPopularReaders() async {
    var list = await ReaderService.getPopularReaders();
    setState(() {
      readers = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: readers.isEmpty
          ? const PopularReaderShimmer()
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: readers
                    .map(
                      (reader) => PopularReaderBox(
                        reader: reader,
                        index: readers.indexOf(reader),
                        iconButton: FavoriteButton(
                          readers: readers,
                          index: readers.indexOf(reader),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
    );
  }
}
