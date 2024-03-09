import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/models/reader_models/popular_reader_model.dart';
import 'package:pagepals/screens/reader_screen/reader_profile/reader_profile.dart';
import 'package:pagepals/screens/reader_screen/reader_widget.dart';
import 'package:pagepals/services/reader_service.dart';
import 'package:unicons/unicons.dart';

class ReaderScreen extends StatefulWidget {
  const ReaderScreen({super.key});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    Future<List<PopularReader>> getActiveReader() {
      return ReaderService.getListActiveReader();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          toolbarHeight: 70,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          flexibleSpace: Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                SearchBar(
                  onChanged: (value) {
                    print('Searching for: $value');
                  },
                  onSubmitted: (value) {
                    print('Submit Searching for: $value');
                  },
                  controller: searchController,
                  leading: IconButton(
                    icon: const Icon(UniconsLine.search),
                    onPressed: () {
                      print('Searching for: ${searchController.text}');
                    },
                  ),
                  trailing: [
                    IconButton(
                      icon: const Icon(UniconsLine.multiply),
                      onPressed: () {
                        searchController.clear();
                      },
                    ),
                  ],
                  constraints: const BoxConstraints(
                    maxHeight: 50,
                    maxWidth: 310,
                  ),
                  shadowColor:
                      MaterialStateProperty.all(Colors.grey.withOpacity(0)),
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  hintText: 'Search for a reader',
                ),
                const SizedBox(width: 15),
                InkWell(
                  onTap: () {
                    print('Filter button pressed');
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(UniconsLine.filter),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          controller: ScrollController(),
          physics: const AlwaysScrollableScrollPhysics(),
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
                                child: const ReaderProfile(),
                              ),
                            );
                          },
                          teacherName: reader.nickname,
                          language: reader.language,
                          rating: reader.rating,
                          voiceDescription: reader.description,
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
