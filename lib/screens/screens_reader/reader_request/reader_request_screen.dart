import 'dart:io';

import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pagepals/models/question_model.dart';
import 'package:pagepals/models/reader_request_model.dart';
import 'package:pagepals/providers/reader_request_provider.dart';
import 'package:pagepals/screens/screens_reader/reader_request/reader_request_step1.dart';
import 'package:pagepals/screens/screens_reader/reader_request/reader_request_step2.dart';
import 'package:pagepals/screens/screens_reader/reader_request/reader_request_step3.dart';
import 'package:pagepals/services/file_storage_service.dart';
import 'package:pagepals/services/reader_service.dart';
import 'package:provider/provider.dart';

class ReaderRequestScreen extends StatefulWidget {
  ReaderRequestScreen({
    super.key,
    this.listCountry,
    this.listQuestions,
  });

  List<QuestionModel>? listQuestions = [];
  List<String>? listCountry = [];

  @override
  State<ReaderRequestScreen> createState() => _ReaderRequestScreenState();
}

class _ReaderRequestScreenState extends State<ReaderRequestScreen> {
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
  Widget build(BuildContext context) {
    List listScreen = [
      ReaderRequestStep1(listCountry: widget.listCountry),
      ReaderRequestStep2(listQuestions: widget.listQuestions),
      ReaderRequestStep3(
        videoUploadCallback: setReaderVideoUpload,
        imageUploadCallback: setReaderImageUpload,
      ),
    ];

    final readerRequestProvider = context.watch<ReaderRequestProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appRequestToBeReader),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                AppLocalizations.of(context)!.appSave,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            clipBehavior: Clip.none,
            child: EasyStepper(
              activeStep: activeStep,
              lineStyle: LineStyle(
                lineLength: 70,
                lineSpace: 0,
                lineType: LineType.normal,
                defaultLineColor: Colors.grey[400],
                finishedLineColor: Colors.orange,
                lineThickness: 1.5,
              ),
              activeStepTextColor: Colors.black87,
              finishedStepTextColor: Colors.black87,
              internalPadding: 0,
              showLoadingAnimation: false,
              stepRadius: 8,
              showStepBorder: false,
              steps: [
                EasyStep(
                  customStep: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[200],
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor:
                          activeStep >= 0 ? Colors.orange : Colors.grey[200],
                      child: activeStep >= 0
                          ? const Icon(
                              Icons.check,
                              size: 15,
                              color: Colors.white,
                            )
                          : const SizedBox(),
                    ),
                  ),
                  title: AppLocalizations.of(context)!.appInformation,
                ),
                EasyStep(
                  customStep: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.grey[200],
                    child: CircleAvatar(
                        radius: 15,
                        backgroundColor:
                            activeStep >= 1 ? Colors.orange : Colors.grey[200],
                        child: activeStep >= 1
                            ? const Icon(
                                Icons.check,
                                size: 15,
                                color: Colors.white,
                              )
                            : const SizedBox()),
                  ),
                  title: AppLocalizations.of(context)!.appAnswerQuestion,
                  topTitle: true,
                ),
                EasyStep(
                  customStep: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.grey[200],
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor:
                          activeStep >= 2 ? Colors.orange : Colors.grey[200],
                      child: activeStep >= 2
                          ? const Icon(
                              Icons.check,
                              size: 15,
                              color: Colors.white,
                            )
                          : const SizedBox(),
                    ),
                  ),
                  title: AppLocalizations.of(context)!.appUploadVideo,
                ),
              ],
              onStepReached: (index) => setState(() => activeStep = index),
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
      bottomNavigationBar: activeStep == 2
          ? Container(
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
                child: InkWell(
                  onTap: () async {
                    String imageDownloadUrl =
                        await FileStorageService.uploadImage(File(imageUrl));
                    String videoDownloadUrl =
                        await FileStorageService.uploadFile(File(videoUrl));

                    var readerModel = readerRequestProvider.readerRequestModel;
                    readerModel.information?.audioDescriptionUrl =
                        videoDownloadUrl;
                    readerModel.information?.avatarUrl =
                        imageDownloadUrl;
                    readerModel.information?.introductionVideoUrl =
                        videoDownloadUrl;

                    await ReaderService.registerReader(readerModel);

                    // Future.delayed(const Duration(milliseconds: 300), () async {
                    //   final readerRequestProvider =
                    //       context.read<ReaderRequestProvider>();
                    //   readerRequestProvider.updateReaderRequestModelAtStep3(
                    //     avatarUrl: imageDownloadUrl,
                    //     introVideoUrl: videoDownloadUrl,
                    //     audioDescriptionUrl: '',
                    //   );
                    //
                    //   print(context
                    //       .watch<ReaderRequestProvider>()
                    //       .readerRequestModel
                    //       .toString());

                      // final readerRequestModel = context
                      //     .watch<ReaderRequestProvider>()
                      //     .readerRequestModel;
                      //
                      // ReaderService.registerReader(readerRequestModel)
                      //     .then((res) {
                      //   print(res);
                      //   Navigator.pop(context);
                      // });
                    // });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      AppLocalizations.of(context)!.appSubmit,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            )
          : Container(
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
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
                      child: InkWell(
                        onTap: () {
                          if (activeStep > 0) {
                            setState(() => activeStep -= 1);
                          }
                        },
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
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.orange,
                      ),
                    ),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          if (activeStep < upperBound - 1) {
                            setState(() => activeStep += 1);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            AppLocalizations.of(context)!.appNext,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
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
