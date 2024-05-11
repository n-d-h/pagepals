import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';

class DatePickerWidget extends StatefulWidget {
  final Function(DateTime selectedDate)? onDateSelected;
  final bool? isWorkingTime;

  const DatePickerWidget({Key? key, this.onDateSelected, this.isWorkingTime})
      : super(key: key);

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  late DateTime now;
  late DateTime tomorrow;
  late DateTime todayMidnight;
  late DateTime sDate;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    tomorrow = DateTime(now.year, now.month, now.day + 1);
    todayMidnight = DateTime(now.year, now.month, now.day);
    sDate = now;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isWorkingTime == null) const SizedBox(height: 30),
        if (widget.isWorkingTime == null)
          const Text(
            'Day',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        if (widget.isWorkingTime == null) const SizedBox(height: 15),
        Theme(
          data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent),
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EasyDateTimeLine(
                  initialDate: widget.isWorkingTime != null ? tomorrow : now,
                  onDateChange: (selectedDate) {
                    if (widget.onDateSelected != null &&
                        !selectedDate.isBefore(todayMidnight)) {
                      widget.onDateSelected!(selectedDate);
                    } else if (widget.onDateSelected != null &&
                        widget.isWorkingTime != null) {
                      widget.onDateSelected!(selectedDate);
                    }
                    setState(() {
                      sDate = selectedDate;
                    });
                  },
                  dayProps: const EasyDayProps(
                    height: 52.0,
                    width: 115.0,
                  ),
                  headerProps: EasyHeaderProps(
                    // && !sDate.isBefore(todayMidnight)
                    showSelectedDate: widget.isWorkingTime != null,
                    dateFormatter: const DateFormatter.fullDateMonthAsStrDY(),
                    showMonthPicker: widget.isWorkingTime != null,
                    showHeader: widget.isWorkingTime != null,
                  ),
                  itemBuilder: (BuildContext context, String dayNumber, dayName,
                      monthName, fullDate, isSelected) {
                    final isToday = fullDate.year == now.year &&
                        fullDate.month == now.month &&
                        fullDate.day == now.day;
                    final isTomorrow = fullDate.year == tomorrow.year &&
                        fullDate.month == tomorrow.month &&
                        fullDate.day == tomorrow.day;
                    final isBeforeToday = fullDate.isBefore(todayMidnight);
                    return Container(
                      width: 115.0,
                      decoration: BoxDecoration(
                        color: isSelected && !isBeforeToday
                            ? ColorHelper.getColor(ColorHelper.green)
                            : isBeforeToday
                                ? Colors.grey.withOpacity(0.3)
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                        border: isSelected || isBeforeToday
                            ? null
                            : Border.all(width: 1, color: Colors.black12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.isWorkingTime == null)
                            Text(
                              isToday ? 'Today' : dayName,
                              style: TextStyle(
                                fontSize: 12,
                                color: isSelected && !isBeforeToday
                                    ? Colors.white
                                    : isBeforeToday
                                        ? Colors.grey
                                        : const Color(0xff6D5D6E),
                              ),
                            ),
                          if (widget.isWorkingTime != null)
                            Text(
                              isTomorrow ? 'Tomorrow' : dayName,
                              style: TextStyle(
                                fontSize: 12,
                                color: isSelected && !isBeforeToday
                                    ? Colors.white
                                    : isBeforeToday
                                        ? Colors.grey
                                        : const Color(0xff6D5D6E),
                              ),
                            ),
                          const SizedBox(width: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                dayNumber,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected && !isBeforeToday
                                      ? Colors.white
                                      : isBeforeToday
                                          ? Colors.grey
                                          : const Color(0xff393646),
                                ),
                              ),
                              const SizedBox(width: 5.0),
                              Text(
                                monthName,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected && !isBeforeToday
                                      ? Colors.white
                                      : isBeforeToday
                                          ? Colors.grey
                                          : const Color(0xff6D5D6E),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
