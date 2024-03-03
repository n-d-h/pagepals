import 'package:flutter/material.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/widgets/reader_info_widget/reader_info.dart';

class BookingTime extends StatelessWidget {
  final ReaderProfile? reader;

  const BookingTime({super.key, required this.reader});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book appointment'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: SpaceHelper.space24,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ReaderInfoWidget(
                reader: reader,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
