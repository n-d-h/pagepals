import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/working_time_model.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/bottom_nav_button.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/day_picker_widget.dart';
import 'package:pagepals/screens/screens_reader/reader_working_time/time_picker_widget/ndh_time_range_picker.dart';
import 'package:pagepals/services/working_time_service.dart';
import 'package:quickalert/quickalert.dart';

class ReaderWorkingTime extends StatefulWidget {
  final String title;
  final String readerId;

  const ReaderWorkingTime(
      {super.key, required this.title, required this.readerId});

  @override
  State<ReaderWorkingTime> createState() => _ReaderWorkingTimeState();
}

class _ReaderWorkingTimeState extends State<ReaderWorkingTime> {
  WorkingTimeModel? workingTimeModels;
  List<WorkingDates> workingDates = [];
  WorkingDates? selectedWorkingDate;
  List<TimeSlots> timeSlots = [];
  late DateTime selectedDate;
  bool isCheck = false;

  Future<void> getWorkingTime() async {
    var result = await WorkingTimeService.getWorkingTime(widget.readerId);
    setState(() {
      // Set the working time models for loading
      workingTimeModels = result;
    });
  }

  void initializeData() {
    // flag to check if there is no work date for the selected date
    bool noWorkDateForSelectedDate = true;
    // Set the state
    setState(() {
      // Get all the working dates from reader
      workingDates = workingTimeModels?.workingDates ?? [];

      // Get the selected working date if it exists
      if (workingDates.isNotEmpty) {
        // Loop through the working dates to find the selected working date
        for (var element in workingDates) {
          DateTime workingDate = DateTime.parse(element.date!);
          if (workingDate.day == selectedDate.day &&
              workingDate.month == selectedDate.month &&
              workingDate.year == selectedDate.year) {
            // Set the selected working date
            selectedWorkingDate = element;
            // Set the flag to false
            noWorkDateForSelectedDate = false;
          }
        }

        // If there is no work date for the selected date, set the selected working date to null
        if (noWorkDateForSelectedDate) {
          selectedWorkingDate = null;
        }

        // Get the time slots for the selected working date
        timeSlots = selectedWorkingDate?.timeSlots ?? [];
        // print('timeSlots');
        // var times = timeSlots
        //     .map(
        //       (slot) => TimeRange(
        //         startTime: TimeOfDay(
        //           hour: int.parse(slot.startTime!.split(":")[0]),
        //           minute: 0,
        //         ),
        //         endTime: TimeOfDay(
        //           hour: (int.parse(slot.startTime!.split(":")[0]) + 1),
        //           minute: 0,
        //         ),
        //       ),
        //     )
        //     .toList();
        // print(times);
      }
    });
  }

  List<TimeRange> generateDisabledTimes() {
    List<TimeRange> disabledTimes = [];
    if (selectedDate ==
        DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        )) {
      for (int i = 0; i < 24; i++) {
        TimeRange time = TimeRange(
          startTime: TimeOfDay(
            hour: i,
            minute: 0,
          ),
          endTime: TimeOfDay(
            hour: (i + 1),
            minute: 0,
          ),
        );
        disabledTimes.add(time);
      }
    }

    if (selectedWorkingDate != null) {
      List<TimeRange> slots = timeSlots
          .map((slot) => TimeRange(
                startTime: TimeOfDay(
                  hour: int.parse(slot.startTime!.split(":")[0]),
                  minute: 0,
                ),
                endTime: TimeOfDay(
                  hour: (int.parse(slot.startTime!.split(":")[0]) + 1),
                  minute: 0,
                ),
              ))
          .toList();
      disabledTimes.addAll(slots);
    }
    return disabledTimes;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime now = DateTime.now();
    selectedDate = DateTime(now.year, now.month, now.day + 1);
    getWorkingTime();
  }

  TimeOfDay _startTime = TimeOfDay(hour: (DateTime.now().hour + 1), minute: 0);
  TimeOfDay _endTime = TimeOfDay.fromDateTime(DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    (DateTime.now().hour + 1),
    0,
  ).add(const Duration(hours: 2)));

  @override
  Widget build(BuildContext context) {
    initializeData();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: ScrollController(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: DatePickerWidget(
                isWorkingTime: true,
                onDateSelected: (value) {
                  setState(() {
                    if (value != selectedDate) {
                      selectedDate = value;
                      workingTimeModels = null;
                      getWorkingTime();
                    }
                  });
                },
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 15,
            ),
            workingTimeModels == null
                ? Container(
                    margin: const EdgeInsets.only(top: 120),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: LoadingAnimationWidget.prograssiveDots(
                            color: ColorHelper.getColor(ColorHelper.green),
                            size: 60,
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Start: ${_startTime.format(context)}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "End: ${_endTime.format(context)}",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Container(
                        height: 400,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: TimeRangePicker(
                          paintingStyle: PaintingStyle.stroke,
                          hideButtons: true,
                          hideTimes: true,
                          interval: const Duration(hours: 1),
                          minDuration: const Duration(hours: 1),
                          strokeWidth: 10,
                          ticks: 12,
                          ticksOffset: 2,
                          ticksLength: 8,
                          handlerRadius: 8,
                          ticksColor: Colors.grey,
                          rotateLabels: false,
                          backgroundColor: Colors.grey[200]!,
                          handlerColor: Colors.blueAccent,
                          strokeColor: ColorHelper.getColor(ColorHelper.green),
                          labels: [
                            "0 h",
                            "3 h",
                            "6 h",
                            "9 h",
                            "12 h",
                            "15 h",
                            "18 h",
                            "21 h"
                          ].asMap().entries.map((e) {
                            return ClockLabel.fromIndex(
                                idx: e.key, length: 8, text: e.value);
                          }).toList(),
                          labelOffset: 30,
                          padding: 55,
                          labelStyle: const TextStyle(
                              fontSize: 18, color: Colors.black),
                          start: _startTime,
                          end: _endTime,
                          disabledTimes: generateDisabledTimes(),
                          clockRotation: 180.0,
                          onStartChange: (start) {
                            setState(() {
                              _startTime = start;
                            });
                          },
                          onEndChange: (end) {
                            setState(() {
                              _endTime = end;
                            });
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.grey[100]!,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              side: const BorderSide(
                                color: Colors.grey,
                                width: 1.4,
                              ),
                              checkColor: Colors.white,
                              fillColor:
                                  MaterialStateColor.resolveWith((states) {
                                const Set<MaterialState> interactiveStates =
                                    <MaterialState>{
                                  MaterialState.pressed,
                                  MaterialState.hovered,
                                  MaterialState.selected,
                                };
                                if (states.any(interactiveStates.contains)) {
                                  return ColorHelper.getColor(
                                      ColorHelper.green);
                                }
                                return ColorHelper.getColor(ColorHelper.white);
                              }),
                              value: isCheck,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheck = value!;
                                });
                              },
                            ),
                            Expanded(
                                child: RichText(
                              textAlign: TextAlign.start,
                              // Align the text inside RichText
                              text: TextSpan(
                                text:
                                    'Repeat for the next 3 months with this time frame on ',
                                style: GoogleFonts.lexend(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        DateFormat('EEEE').format(selectedDate),
                                    style: GoogleFonts.lexend(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: ColorHelper.getColor(
                                          ColorHelper.green),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                    ],
                  )
          ],
        ),
      ),
      bottomNavigationBar: BottomButton(
        title: 'Save',
        onPressed: () async {
          if (_endTime.hour - _startTime.hour <= 0) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Invalid End Time"),
                  content: const Text(
                      "The end time must be before 12:00 AM. Please select a valid end time."),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          } else {
            // reload the working time
            setState(() {
              workingTimeModels = null;
            });

            // Get the date
            String date = selectedDate.toString().split(' ').first;

            // Get the start time
            DateTime start = DateTime(selectedDate.year, selectedDate.month,
                selectedDate.day, _startTime.hour, _startTime.minute);

            // Get the end time
            DateTime endTime = DateTime(selectedDate.year, selectedDate.month,
                selectedDate.day, _endTime.hour, _endTime.minute);

            // Get the slots between the start and end time
            int slots = endTime.difference(start).inHours;

            // Get the start times
            List<String>? startTimes = [];
            for (int slot = 0; slot < slots; slot++) {
              startTimes.add(
                  start.add(Duration(hours: slot)).toString().split('.').first);
            }

            // call the create working time function
            bool created = await WorkingTimeService.createWorkingTime(
                widget.readerId, isCheck, date, startTimes);

            if (created) {
              getWorkingTime();
              Future.delayed(Duration.zero, () {
                QuickAlert.show(
                  context: context,
                  title: 'Success',
                  text: 'Working time created successfully',
                  type: QuickAlertType.success,
                );
              });
              setState(() {
                _startTime =
                    TimeOfDay(hour: (DateTime.now().hour + 1), minute: 0);
                _endTime = TimeOfDay.fromDateTime(DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  (DateTime.now().hour + 1),
                  0,
                ).add(const Duration(hours: 2)));
              });
            } else {
              getWorkingTime();
              Future.delayed(Duration.zero, () {
                QuickAlert.show(
                  context: context,
                  title: 'Error',
                  text: 'Failed to create working time',
                  type: QuickAlertType.error,
                );
              });
            }
          }
        },
        isEnabled: selectedDate.isBefore(DateTime(
          DateTime.now().year,
          DateTime.now().month,
          (DateTime.now().day + 1),
        ))
            ? false
            : true,
      ),
    );
  }
}
