import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/working_time_model.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/bottom_nav_button.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/day_picker_widget.dart';
import 'package:pagepals/screens/screens_reader/reader_working_time/time_picker_widget/ndh_time_range_picker.dart';
import 'package:pagepals/services/working_time_service.dart';

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
  ).add(const Duration(hours: 5)));

  @override
  Widget build(BuildContext context) {
    initializeData();
    return workingTimeModels == null
        ? Scaffold(
            body: Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: ColorHelper.getColor(ColorHelper.green),
              size: 60,
            ),
          ))
        : Scaffold(
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
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: DatePickerWidget(
                      isWorkingTime: true,
                      onDateSelected: (value) {
                        setState(() {
                          selectedDate = value;
                          workingTimeModels = null;
                          getWorkingTime();
                        });
                      },
                    ),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 15,
                  ),
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
                      labelStyle:
                          const TextStyle(fontSize: 18, color: Colors.black),
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
                ],
              ),
            ),
            bottomNavigationBar: BottomButton(
              title: 'Save',
              onPressed: () {
                print('selectedDate: $selectedDate');
                print('Start: $_startTime');
                print('End: $_endTime');
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
