import 'package:flutter/material.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/screens/home_screen/popular_readers_widgets/popular_reader_leading.dart';
import 'package:pagepals/screens/home_screen/popular_readers_widgets/popular_reader_widget.dart';

class PopularReadersColumn extends StatelessWidget {
  const PopularReadersColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * SpaceHelper.spaceNineTenths,
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 20),
      child: const Column(
        children: [
          CardLeading(
            title: 'Popular Readers',
            seeAll: true,
          ),
          PopularReaderWidget()
        ],
      ),
    );
  }
}
