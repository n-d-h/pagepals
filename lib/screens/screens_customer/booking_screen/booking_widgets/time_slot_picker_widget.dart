import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';

class TimeSlotPicker extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onTimeSlotSelected;

  const TimeSlotPicker({
    Key? key,
    required this.selectedDate,
    required this.onTimeSlotSelected,
  }) : super(key: key);

  @override
  State<TimeSlotPicker> createState() => _TimeSlotPickerState();
}

class _TimeSlotPickerState extends State<TimeSlotPicker> {
  DateTime? selectedTimeSlot;

  @override
  Widget build(BuildContext context) {
    // Generate a list of time slots (for demonstration purposes)
    List<DateTime> timeSlots = generateTimeSlots();

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        const Text(
          'Time slot',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 15),
        Theme(
          data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent),
          child: SizedBox(
            height: 200, // Adjust the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: (timeSlots.length / 48).ceil(),
              itemBuilder: (BuildContext context, int index) {
                int startIndex = index * 48;
                int endIndex = (index + 1) * 48;
                if (endIndex > timeSlots.length) {
                  endIndex = timeSlots.length;
                }
                List<DateTime> columnTimeSlots =
                    timeSlots.sublist(startIndex, endIndex);

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    16, // 12 elements in a row
                    (rowIndex) {
                      int rowStartIndex = rowIndex * 3;
                      int rowEndIndex = (rowIndex + 1) * 3;
                      if (rowEndIndex > columnTimeSlots.length) {
                        rowEndIndex = columnTimeSlots.length;
                      }
                      List<DateTime> rowTimeSlots =
                          columnTimeSlots.sublist(rowStartIndex, rowEndIndex);

                      return buildTimeSlotColumn(context, rowTimeSlots);
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTimeSlotColumn(BuildContext context, List<DateTime> timeSlots) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: timeSlots.map((timeSlot) {
        bool isSelected = selectedTimeSlot == timeSlot;
        bool isAvailable =
            timeSlot.isAfter(DateTime.now().add(const Duration(minutes: 5)));

        return buildTimeSlotWidget(context, timeSlot, isSelected, isAvailable);
      }).toList(),
    );
  }

  Widget buildTimeSlotWidget(BuildContext context, DateTime timeSlot,
      bool isSelected, bool isAvailable) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: OutlinedButton(
        onPressed: isAvailable
            ? () {
                setState(() {
                  selectedTimeSlot = timeSlot;
                });
                widget.onTimeSlotSelected(timeSlot);
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
            '${timeSlot.hour}:${timeSlot.minute.toString().padLeft(2, '0')}',
            style: const TextStyle(
              // color: isAvailable ? Colors.white : Colors.grey,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  List<DateTime> generateTimeSlots() {
    // For demonstration purposes, generate a list of time slots for a day
    DateTime startTime = DateTime(
      widget.selectedDate.year,
      widget.selectedDate.month,
      widget.selectedDate.day,
    );
    List<DateTime> timeSlots = [];

    // Generate time slots with a 30-minute difference
    for (int i = 0; i < 48; i++) {
      // 48 slots for a 24-hour day with 30-minute intervals
      timeSlots.add(startTime.add(Duration(minutes: i * 30)));
    }

    return timeSlots;
  }
}
