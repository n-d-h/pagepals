import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/book_model.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/screens/home_screen/video_player/intro_video.dart';
import 'package:pagepals/screens/profile_screen/profile_widgets/book_collection.dart';
import 'package:pagepals/screens/profile_screen/profile_widgets/booking_button.dart';
import 'package:pagepals/screens/profile_screen/profile_widgets/info_line.dart';
import 'package:pagepals/screens/profile_screen/profile_widgets/reader_collection.dart';
import 'package:pagepals/screens/profile_screen/profile_widgets/review_widgets/review_widget.dart';
import 'package:pagepals/services/book_service.dart';
import 'package:pagepals/services/reader_service.dart';

class ProfileOverviewScreen extends StatefulWidget {
  final String readerId;

  const ProfileOverviewScreen({
    super.key,
    required this.readerId,
  });

  @override
  State<ProfileOverviewScreen> createState() => _ProfileOverviewScreenState();
}

class _ProfileOverviewScreenState extends State<ProfileOverviewScreen> {
  GlobalKey<IntroVideoState> introVideoKey = GlobalKey<IntroVideoState>();
  GlobalKey<IntroVideoState> mainIntroVideoKey = GlobalKey<IntroVideoState>();

  void pauseVideo() {
    final IntroVideoState? introVideoState = introVideoKey.currentState;
    final IntroVideoState? mainIntroVideoState = mainIntroVideoKey.currentState;
    if (introVideoState != null) {
      introVideoState.pauseVideo();
    }
    if (mainIntroVideoState != null) {
      mainIntroVideoState.pauseVideo();
    }
  }

  // late String readerId;
  ReaderProfile? reader = ReaderProfile();
  List<BookModel> books = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // readerId = widget.readerId;
    getReaderProfile(widget.readerId);
    getReaderBooks(widget.readerId);
  }

  @override
  void dispose() {
    pauseVideo(); // Call the pauseVideo method here
    super.dispose();
  }

  Future<void> getReaderProfile(String id) async {
    var result = await ReaderService.getReaderProfile(id);
    setState(() {
      reader = result;
    });
  }

  Future<void> getReaderBooks(String id) async {
    var result = await BookService.getReaderBooks(id);
    setState(() {
      books = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorHelper.getColor(ColorHelper.white),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            // iconSize: 30,
            onPressed: () {
              pauseVideo();
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: IconButton(
                icon: const Icon(Icons.more_horiz_outlined),
                iconSize: 30,
                onPressed: () {
                  // Handle the first action
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                icon: const Icon(Icons.favorite_border_outlined),
                iconSize: 30,
                onPressed: () {
                  // Handle the second action
                },
              ),
            ),
          ],
        ),
        backgroundColor: ColorHelper.getColor('#F2F2F2'),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: ScrollController(),
          // padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: reader?.profile == null
              ? SizedBox(
                  height: MediaQuery.of(context).size.height - 100,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IntroVideo(
                      key: mainIntroVideoKey,
                      videoUrl: reader!.profile!.introductionVideoUrl!,
                      width: MediaQuery.of(context).size.width,
                    ),
                    ProfileInfoLine(reader: reader),
                    ProfileBookCollection(books: books),
                    ProfileReviewWidget(reader: reader),
                    ProfileBookingButton(
                      reader: reader,
                      pauseVideo: pauseVideo,
                      books: books,
                    ),
                    ProfileReaderCollection(introVideoKey: introVideoKey),
                  ],
                ),
        ),
      ),
    );
  }
}
