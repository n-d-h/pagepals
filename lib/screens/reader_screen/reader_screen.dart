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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reader'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            ReaderWidget(
              onTap: () {
                Navigator.of(context).push(
                  PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: const ReaderProfileScreen(),
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
                    child: const ReaderProfileScreen(),
                    duration: const Duration(milliseconds: 500),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
