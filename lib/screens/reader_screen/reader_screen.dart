import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/screens/reader_screen/reader_profile/reader_profile.dart';
import 'package:pagepals/screens/reader_screen/reader_widget.dart';

class ReaderScreen extends StatefulWidget {
  const ReaderScreen({super.key});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  @override
  Widget build(BuildContext context) {
    List<ReaderWidget> list = [
      ReaderWidget(
        onTap: () {
          Navigator.of(context).push(
            PageTransition(
              type: PageTransitionType.bottomToTop,
              child: const ReaderProfile(),
              duration: const Duration(milliseconds: 500),
            ),
          );
        },
      ),
      ReaderWidget(
        onTap: () {
          Navigator.of(context).push(
            PageTransition(
              type: PageTransitionType.bottomToTop,
              child: const ReaderProfile(),
              duration: const Duration(milliseconds: 500),
            ),
          );
        },
      ),
      ReaderWidget(
        onTap: () {
          Navigator.of(context).push(
            PageTransition(
              type: PageTransitionType.bottomToTop,
              child: const ReaderProfile(),
              duration: const Duration(milliseconds: 500),
            ),
          );
        },
      ),
      ReaderWidget(
        onTap: () {
          Navigator.of(context).push(
            PageTransition(
              type: PageTransitionType.bottomToTop,
              child: const ReaderProfile(),
              duration: const Duration(milliseconds: 500),
            ),
          );
        },
      ),
    ];

    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          children: [
            Row(
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
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      print('Searching for: ${searchController.text}');
                    },
                  ),
                  trailing: [
                    IconButton(
                      icon: const Icon(Icons.clear),
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
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.filter_alt),
                  ),
                ),
              ],
            ),
          ],
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
            ...list,
          ],
        ),
      ),
    );
  }
}
