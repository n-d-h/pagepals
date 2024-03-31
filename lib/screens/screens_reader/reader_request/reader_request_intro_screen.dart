import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/question_model.dart';
import 'package:pagepals/screens/screens_reader/reader_request/reader_request_screen.dart';
import 'package:pagepals/services/country_service.dart';
import 'package:pagepals/services/question_service.dart';

class ReaderRequestIntroScreen extends StatefulWidget {
  const ReaderRequestIntroScreen({super.key});

  @override
  State<ReaderRequestIntroScreen> createState() =>
      _ReaderRequestIntroScreenState();
}

class _ReaderRequestIntroScreenState extends State<ReaderRequestIntroScreen> {
  List<QuestionModel> listQuestions = [];
  List<String> listCountry = [];

  Future<List<QuestionModel>> getListQuestion() async {
    return QuestionService.getListQuestion();
  }

  Future<List<String>> getListCountry() async {
    return CountryService.getListCountry(null);
  }

  @override
  void initState() {
    super.initState();
    Future.wait([getListQuestion(), getListCountry()]).then((List results) {
      setState(() {
        listQuestions = results[0];
        listCountry = results[1];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reader Request'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/seminar.jpg'),
            const SizedBox(height: 20),
            const Text(
              'Welcome to the New Reader',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'This is the first step to become a reader',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Please click the Continue button below to proceed',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: ReaderRequestScreen(
                  listQuestions: listQuestions,
                  listCountry: listCountry,
                ),
              ),
            );
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: ColorHelper.getColor(ColorHelper.greenActive),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                'Continue',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
