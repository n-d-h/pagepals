import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pagepals/screens/screens_reader/reader_request/reader_request_step1.dart';
import 'package:pagepals/screens/screens_reader/reader_request/reader_request_step2.dart';
import 'package:pagepals/screens/screens_reader/reader_request/reader_request_step3.dart';

class ReaderRequestScreen extends StatefulWidget {
  const ReaderRequestScreen({super.key});

  @override
  State<ReaderRequestScreen> createState() => _ReaderRequestScreenState();
}

class _ReaderRequestScreenState extends State<ReaderRequestScreen> {
  late int activeStep = 0;
  int upperBound = 3;

  List listScreen = [
    const ReaderRequestStep1(),
    const ReaderRequestStep2(),
    const ReaderRequestStep3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.appRequestToBeReader),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(10.0),
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
            Navigator.pop(context);
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
      bottomNavigationBar: Container(
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
