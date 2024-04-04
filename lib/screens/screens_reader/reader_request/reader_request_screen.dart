import 'dart:io';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/question_model.dart';
import 'package:pagepals/models/reader_request_model.dart';
import 'package:pagepals/providers/reader_request_provider.dart';
import 'package:pagepals/screens/screens_reader/reader_pending_screen/reader_pending_screen.dart';
import 'package:pagepals/screens/screens_reader/reader_request/reader_request_step1.dart';
import 'package:pagepals/screens/screens_reader/reader_request/reader_request_step2.dart';
import 'package:pagepals/screens/screens_reader/reader_request/reader_request_step3.dart';
import 'package:pagepals/services/file_storage_service.dart';
import 'package:pagepals/services/reader_service.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:unicons/unicons.dart';

class ReaderRequestScreen extends StatefulWidget {
  final List<QuestionModel>? listQuestions;

  final List<String>? listCountry;

  const ReaderRequestScreen({
    super.key,
    this.listCountry,
    this.listQuestions,
  });

  @override
  State<ReaderRequestScreen> createState() => _ReaderRequestScreenState();
}

class _ReaderRequestScreenState extends State<ReaderRequestScreen> {
  bool isLoading = true;

  late int activeStep = 0;
  int upperBound = 3;

  ReaderRequestModel readerRequestModel = ReaderRequestModel();

  String videoUrl = '';
  String imageUrl = '';

  void setReaderVideoUpload(value) {
    setState(() {
      videoUrl = value;
    });
  }

  void setReaderImageUpload(value) {
    setState(() {
      imageUrl = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    // await Future.delayed(const Duration(seconds: 2));
    // setState(() {
    //   isLoading = false;
    // });
    await Future.delayed(
      const Duration(milliseconds: 2300),
      () {
        if (widget.listCountry!.isNotEmpty &&
            widget.listQuestions!.isNotEmpty) {
          setState(() {
            isLoading = false;
          });
        }
      },
    );
    // print('List Country: ${widget.listCountry!.length}');
  }

  @override
  Widget build(BuildContext context) {
    List listScreen = [
      ReaderRequestStep1(listCountry: widget.listCountry!),
      ReaderRequestStep2(listQuestions: widget.listQuestions!),
      ReaderRequestStep3(
        videoUploadCallback: setReaderVideoUpload,
        imageUploadCallback: setReaderImageUpload,
      ),
    ];

    final readerRequestProvider = context.watch<ReaderRequestProvider>();

    return isLoading
        ? Scaffold(
            body: Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: ColorHelper.getColor(ColorHelper.green),
                size: 60,
              ),
            ),
          )
        : Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.appRequestToBeReader),
              centerTitle: true,
              // actions: [
              //   InkWell(
              //     onTap: () {},
              //     child: Container(
              //       margin: const EdgeInsets.symmetric(horizontal: 5),
              //       padding: const EdgeInsets.all(10.0),
              //       decoration: BoxDecoration(
              //         color: Colors.orange,
              //         borderRadius: BorderRadius.circular(5),
              //       ),
              //       child: Text(
              //         AppLocalizations.of(context)!.appSave,
              //         style: const TextStyle(
              //           fontWeight: FontWeight.bold,
              //         ),
              //         textAlign: TextAlign.center,
              //       ),
              //     ),
              //   ),
              // ],
              leading: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Exit"),
                        content: const Text(
                          "Are you sure you want to exit? "
                          "If you exit, all your progress will be lost.",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("No"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              final ReaderRequestProvider
                                  readerRequestProvider =
                                  context.read<ReaderRequestProvider>();
                              readerRequestProvider.clearReaderRequestModel();
                              // Navigator.pop(context);
                            },
                            child: const Text("Yes"),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                children: [
                  Theme(
                    data: ThemeData(
                      splashFactory: NoSplash.splashFactory,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                      clipBehavior: Clip.none,
                      child: EasyStepper(
                        activeStep: activeStep,
                        lineStyle: LineStyle(
                          lineLength: 90,
                          lineSpace: 15,
                          lineType: LineType.dashed,
                          defaultLineColor: Colors.grey[400],
                          finishedLineColor:
                              ColorHelper.getColor(ColorHelper.green),
                          lineThickness: 1.5,
                        ),
                        activeStepTextColor:
                            ColorHelper.getColor(ColorHelper.green),
                        finishedStepTextColor: Colors.black87,
                        finishedStepBackgroundColor:
                            ColorHelper.getColor(ColorHelper.green),
                        finishedStepBorderType: BorderType.dotted,
                        stepAnimationCurve: Curves.easeInOut,
                        internalPadding: 10,
                        showLoadingAnimation: true,
                        stepRadius: 10,
                        showStepBorder: true,
                        activeStepBorderColor:
                            ColorHelper.getColor(ColorHelper.green),
                        unreachedStepTextColor: Colors.black45,
                        steps: [
                          EasyStep(
                            customStep: CircleAvatar(
                              radius: 20,
                              backgroundColor: activeStep >= 0
                                  ? ColorHelper.getColor(ColorHelper.green)
                                  : Colors.grey[200],
                              child: activeStep >= 0
                                  ? const Icon(
                                      UniconsLine.check,
                                      size: 15,
                                      color: Colors.white,
                                    )
                                  : const SizedBox(),
                            ),
                            // title: AppLocalizations.of(context)!.appInformation,
                            customTitle: Text(
                              textAlign: TextAlign.center,
                              AppLocalizations.of(context)!.appInformation,
                              style: GoogleFonts.lexend(
                                color: activeStep == 0
                                    ? ColorHelper.getColor(ColorHelper.green)
                                    : Colors.black,
                              ),
                            ),
                          ),
                          EasyStep(
                            customStep: CircleAvatar(
                                radius: 20,
                                backgroundColor: activeStep >= 1
                                    ? ColorHelper.getColor(ColorHelper.green)
                                    : Colors.grey[200],
                                child: activeStep >= 1
                                    ? const Icon(
                                        Icons.check,
                                        size: 15,
                                        color: Colors.white,
                                      )
                                    : const SizedBox()),
                            // title:
                            //     AppLocalizations.of(context)!.appAnswerQuestion,
                            customTitle: Text(
                              textAlign: TextAlign.center,
                              AppLocalizations.of(context)!.appAnswerQuestion,
                              style: GoogleFonts.lexend(
                                color: activeStep == 1
                                    ? ColorHelper.getColor(ColorHelper.green)
                                    : activeStep > 1
                                        ? Colors.black
                                        : Colors.black45,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            topTitle: true,
                          ),
                          EasyStep(
                            customStep: CircleAvatar(
                              radius: 20,
                              backgroundColor: activeStep >= 2
                                  ? ColorHelper.getColor(ColorHelper.green)
                                  : Colors.grey[200],
                              child: activeStep >= 2
                                  ? const Icon(
                                      Icons.check,
                                      size: 15,
                                      color: Colors.white,
                                    )
                                  : const SizedBox(),
                            ),
                            // title: AppLocalizations.of(context)!.appUploadVideo,
                            customTitle: Text(
                              textAlign: TextAlign.center,
                              AppLocalizations.of(context)!.appUploadVideo,
                              style: GoogleFonts.lexend(
                                color: activeStep == 2
                                    ? ColorHelper.getColor(ColorHelper.green)
                                    : Colors.black45,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                        onStepReached: (index) =>
                            setState(() => activeStep = index),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: ScrollController(),
                      physics: const BouncingScrollPhysics(),
                      child: listScreen[activeStep],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: activeStep == 2
                ? InkWell(
                    onTap: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Center(
                            child: LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.greenAccent,
                              size: 60,
                            ),
                          );
                        },
                      );
                      String imageDownloadUrl =
                          await FileStorageService.uploadImage(File(imageUrl));
                      String videoDownloadUrl =
                          await FileStorageService.uploadFile(File(videoUrl));

                      if (imageDownloadUrl != "" && videoDownloadUrl != "") {
                        var readerModel =
                            readerRequestProvider.readerRequestModel;
                        readerModel.information?.audioDescriptionUrl =
                            videoDownloadUrl;
                        readerModel.information?.avatarUrl = imageDownloadUrl;
                        readerModel.information?.introductionVideoUrl =
                            videoDownloadUrl;

                        print('Reader Model: ${readerModel.toString()}');
                        String response =
                            await ReaderService.registerReader(readerModel);
                        if (response == "OK") {
                          Future.delayed(
                            const Duration(milliseconds: 0),
                            () {
                              Navigator.pop(context);
                              readerRequestProvider.clearReaderRequestModel();

                              Navigator.of(context).push(
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const ReaderPendingScreen(),
                                  duration: const Duration(milliseconds: 300),
                                ),
                              );

                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                title: 'Request submitted',
                                text:
                                    'Your request has been submitted successfully. \n'
                                    'Please wait for the admin to approve your request.',
                              );
                            },
                          );
                        }
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.green,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            AppLocalizations.of(context)!.appSubmit,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(5, 0, 5, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            if (activeStep > 0) {
                              setState(() => activeStep -= 1);
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.grey[300]!,
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  AppLocalizations.of(context)!.appBack,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (activeStep < upperBound - 1) {
                              setState(() => activeStep += 1);
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: 50,
                            decoration: BoxDecoration(
                              color: ColorHelper.getColor(ColorHelper.green),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: ColorHelper.getColor(ColorHelper.green),
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  AppLocalizations.of(context)!.appNext,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          );
  }
}
