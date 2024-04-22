import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/request_model.dart';
import 'package:pagepals/services/reader_service.dart';
import 'package:pagepals/services/video_conference_service.dart';

class ReaderPendingScreen extends StatefulWidget {
  const ReaderPendingScreen({super.key, this.readerId});

  final String? readerId;

  @override
  State<ReaderPendingScreen> createState() => _ReaderPendingScreenState();
}

class _ReaderPendingScreenState extends State<ReaderPendingScreen> {
  RequestModel? requestModel;

  @override
  void initState() {
    super.initState();
    getRequestByReaderId(widget.readerId ?? '');
  }

  Future<void> getRequestByReaderId(String readerId) async {
    var result = await ReaderService.getRequestByReaderId(readerId);
    setState(() {
      requestModel = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reader Pending Screen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: requestModel == null
          ? Container(
              child: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: ColorHelper.getColor(ColorHelper.green),
                  size: 60,
                ),
              ),
            )
          : requestModel?.state == 'ANSWER_CHECKING'
              ? Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Reader Request Status",
                          style: TextStyle(
                            color: ColorHelper.getColor(ColorHelper.black),
                            fontSize: 30,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Your request is being checked by staff",
                          style: TextStyle(
                            color: ColorHelper.getColor(ColorHelper.green),
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: ColorHelper.getColor(ColorHelper.green),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: const Text(
                                "Back to Home Screen",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "Reader Request Status",
                          style: TextStyle(
                            color: ColorHelper.getColor(ColorHelper.green),
                            fontSize: 30,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        ListTile(
                          title: Text("Meeting date: "),
                          trailing: Text(
                            (requestModel?.interviewAt ?? '').substring(0, 10),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text("Meeting time: "),
                          trailing: Text(
                            (requestModel?.interviewAt ?? '').substring(10),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text("Meeting code: "),
                          trailing: Text(
                            requestModel?.meetingCode ?? '',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text("Staff name: "),
                          trailing: Text(
                            requestModel?.staffName ?? '',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text("State: "),
                          trailing: Text(
                            requestModel?.state ?? '',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        requestModel?.state == 'INTERVIEW_PENDING'
                            ? InkWell(
                                onTap: () async {
                                  // String interviewAt = requestModel?.interviewAt ??
                                  //     DateTime.now().toString();
                                  // DateTime interviewDateTime =
                                  // DateTime.parse(interviewAt);
                                  //
                                  // if (DateTime.now().isAfter(interviewDateTime
                                  //     .add(Duration(minutes: 60))) ||
                                  //     DateTime.now().isBefore(interviewDateTime)) {
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //     SnackBar(
                                  //       content: Text(
                                  //         "Interview time has passed",
                                  //         style: GoogleFonts.roboto(
                                  //           color: Colors.white,
                                  //         ),
                                  //       ),
                                  //       backgroundColor: Colors.red,
                                  //     ),
                                  //   );
                                  //   return;
                                  // }

                                  await VideoConferenceService.joinMeeting(
                                    requestModel?.meetingCode ?? '',
                                    requestModel?.meetingPassword ?? '',
                                  );

                                  // Navigator.push(
                                  //   context,
                                  //   PageTransition(
                                  //     type: PageTransitionType.rightToLeft,
                                  //     child: VideoConferencePage(
                                  //       conferenceID:
                                  //           requestModel?.meetingCode ?? '',
                                  //     ),
                                  //   ),
                                  // );
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color:
                                        ColorHelper.getColor(ColorHelper.green),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: const Text(
                                      "Join Meeting Interview",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
    );
  }
}
