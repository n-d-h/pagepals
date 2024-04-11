import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/working_time_model.dart';

class TimePickerWidget extends StatefulWidget {
  final DateTime selectedDate;
  final Function(String, DateTime)? onTimeSlotIdSelected;
  final WorkingTimeModel? workingTimeModels;

  const TimePickerWidget({
    Key? key,
    required this.selectedDate,
    this.onTimeSlotIdSelected,
    this.workingTimeModels,
  }) : super(key: key);

  @override
  State<TimePickerWidget> createState() => _TimeSlotPickerState();
}

class _TimeSlotPickerState extends State<TimePickerWidget> {
  List<WorkingDates> workingDates = [];
  WorkingDates? selectedWorkingDate;
  List<TimeSlots> timeSlots = [];
  TimeSlots? selectedTimeSlot;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void initializeDate() {
    // flag to check if there is no work date for the selected date
    bool noWorkDateForSelectedDate = true;
    var now = DateTime.now();
    var today = DateTime(now.year, now.month, now.day);

    setState(() {
      // Get all the working dates from reader
      workingDates = widget.workingTimeModels?.workingDates ?? [];

      // Get the selected working date if it exists
      if (workingDates.isNotEmpty) {
        // Loop through the working dates to find the selected working date
        for (var element in workingDates) {
          DateTime workingDate = DateTime.parse(element.date!);
          if (widget.selectedDate.isAfter(today) &&
              workingDate.day == widget.selectedDate.day &&
              workingDate.month == widget.selectedDate.month &&
              workingDate.year == widget.selectedDate.year) {
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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeDate();
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        RichText(
          softWrap: true,
          text: TextSpan(
            text: 'Time Slot ',
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: '- ${timeSlots.length} available',
                style: GoogleFonts.lexend(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Theme(
          data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent),
          child: SizedBox(
            height: 50, // Adjust the height as needed
            child: timeSlots.isEmpty
                ? const Center(
                    child: Text(
                      'No time slots available',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: timeSlots.length,
                    itemBuilder: (BuildContext context, int index) {
                      TimeSlots timeSlot = timeSlots[index];
                      bool isSelected = selectedTimeSlot?.id == timeSlot.id;
                      DateTime timeSlotDatetime = widget.selectedDate.add(
                        Duration(
                          hours:
                              int.parse(timeSlot.startTime!.split(":").first),
                          minutes: int.parse(timeSlot.startTime!.split(":")[1]),
                        ),
                      );
                      bool isAvailable = timeSlotDatetime.isAfter(
                          DateTime.now().add(const Duration(minutes: 5)));
                      return Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: OutlinedButton(
                          onPressed: isAvailable
                              ? () {
                                  setState(() {
                                    selectedTimeSlot = timeSlot;
                                  });
                                  widget.onTimeSlotIdSelected!(
                                      timeSlot.id!, timeSlotDatetime);
                                }
                              : null,
                          style: OutlinedButton.styleFrom(
                            backgroundColor: isSelected && isAvailable
                                ? ColorHelper.getColor(ColorHelper.green)
                                : !isAvailable
                                    ? Colors.grey.withOpacity(0.3)
                                    : Colors.transparent,
                            foregroundColor: isSelected && isAvailable
                                ? Colors.white
                                : !isAvailable
                                    ? Colors.grey
                                    : const Color(0xff6D5D6E),
                            side: BorderSide(
                              color: isSelected && isAvailable
                                  ? ColorHelper.getColor(ColorHelper.green)
                                  : !isAvailable
                                      ? Colors.transparent
                                      : Colors.black12,
                            ),
                            // disabledMouseCursor: !isAvailable ? SystemMouseCursors.basic : null,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: Container(
                            width: 100,
                            height: 50,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              // remove second from the time
                              timeSlot.startTime!.split(":").take(2).join(":"),
                              style: const TextStyle(
                                // color: isAvailable ? Colors.white : Colors.grey,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
