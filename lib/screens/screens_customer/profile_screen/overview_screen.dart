import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/report_reson_helper.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/models/book_models/book_model.dart';
import 'package:pagepals/models/comment_model.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/screens/screens_customer/home_screen/video_player/intro_video.dart';
import 'package:pagepals/screens/screens_customer/menu_item/menu_item_screen.dart';
import 'package:pagepals/screens/screens_customer/profile_screen/profile_widgets/book_collection.dart';
import 'package:pagepals/screens/screens_customer/profile_screen/profile_widgets/booking_button.dart';
import 'package:pagepals/screens/screens_customer/profile_screen/profile_widgets/info_line.dart';
import 'package:pagepals/screens/screens_customer/profile_screen/profile_widgets/review_widgets/review_widget.dart';
import 'package:pagepals/services/book_service.dart';
import 'package:pagepals/services/reader_service.dart';
import 'package:pagepals/widgets/report_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  GlobalKey<IntroVideoState> mainIntroVideoKey = GlobalKey<IntroVideoState>();

  void pauseVideo() {
    final IntroVideoState? mainIntroVideoState = mainIntroVideoKey.currentState;
    if (mainIntroVideoState != null) {
      mainIntroVideoState.pauseVideo();
    }
  }

  // late String readerId;
  ReaderProfile? reader = ReaderProfile();
  BookModel? bookModel;
  CommentModel? commentModel;
  AccountModel? accountModel;

  @override
  void initState() {
    super.initState();
    getReaderProfile(widget.readerId);
    getReaderBooks(widget.readerId);
    getListReaderComment(widget.readerId);
    getAccount();
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
      bookModel = result;
    });
  }

  Future<void> getListReaderComment(String id) async {
    var result = await ReaderService.getListReaderComment(id, 0, 10);
    setState(() {
      commentModel = result;
    });
  }

  Future<void> getAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accountString = prefs.getString('account') ?? '';
    if (accountString.isNotEmpty) {
      var accountMap = json.decoder.convert(accountString);
      if (accountMap['id'] != null) {
        var account = AccountModel.fromJson(accountMap);
        setState(() {
          accountModel = account;
        });
      }
    }
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
          surfaceTintColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            // iconSize: 30,
            onPressed: () {
              pauseVideo();
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          actions: [
            Visibility(
              visible: accountModel != null,
              child: Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child: DropdownButton(
                  icon: const Icon(Icons.more_vert_outlined),
                  iconSize: 30,
                  items: const [
                    DropdownMenuItem(
                      value: 'Main Page',
                      child: Text('Go to Main Page'),
                    ),
                    DropdownMenuItem(
                      value: 'Report',
                      child: Text('Report'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value == 'Report') {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ReportDialogWidget(
                            readerId: widget.readerId,
                            accountModel: accountModel,
                            listReportReasons: reportReasons,
                            type: 'READER',
                          );
                        },
                      );
                    } else if (value == 'Main Page') {
                      pauseVideo();
                      // Navigator.of(context).pop();
                      Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.fade,
                        child: const MenuItemScreen(index: 0),
                        duration: const Duration(milliseconds: 300),
                      ));
                    }
                  },
                  underline: Container(),
                ),
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
          child: reader?.profile == null ||
                  bookModel == null ||
                  accountModel == null
              ? SizedBox(
                  height: MediaQuery.of(context).size.height - 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: ColorHelper.getColor(ColorHelper.green),
                          size: 60,
                        ),
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
                    ProfileInfoLine(reader: reader, pauseVideo: pauseVideo),
                    if (bookModel != null)
                      ProfileBookCollection(
                          books: bookModel!.list!
                              .map((e) => e.book ?? Book(id: ''))
                              .toList()),
                    ProfileReviewWidget(reader: reader, comment: commentModel),
                    if (bookModel!.list!.isNotEmpty &&
                        bookModel!.list!.first.book != null)
                      ProfileBookingButton(
                        reader: reader,
                        pauseVideo: pauseVideo,
                        bookModel: bookModel!,
                      ),
                    // const ProfileReaderCollection(),
                  ],
                ),
        ),
      ),
    );
  }
}
