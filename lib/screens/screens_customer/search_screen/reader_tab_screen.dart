import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/models/reader_models/popular_reader_model.dart';
import 'package:pagepals/screens/screens_customer/profile_screen/overview_screen.dart';
import 'package:pagepals/screens/screens_customer/reader_screen/reader_profile/reader_profile.dart';
import 'package:pagepals/screens/screens_customer/reader_screen/reader_widget.dart';
import 'package:pagepals/services/reader_service.dart';

class ReaderTabScreen extends StatefulWidget {
  const ReaderTabScreen({super.key});

  @override
  State<ReaderTabScreen> createState() => _ReaderTabScreenState();
}

class _ReaderTabScreenState extends State<ReaderTabScreen> {
  Future<List<PopularReader>> getActiveReader() {
    return ReaderService.getListActiveReader();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          FutureBuilder<List<PopularReader>>(
            future: getActiveReader(),
            builder: (context, snapshot) {
              final data = snapshot.data;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: data!.map((reader) {
                    return ReaderWidget(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: ProfileOverviewScreen(
                              readerId: reader.id!,
                            ),
                          ),
                        );
                      },
                      reader: reader,
                    );
                  }).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
