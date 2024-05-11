import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/models/book_models/book_model.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/models/working_time_model.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/bottom_nav_button.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/day_picker_widget.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/radio_buttons/time_picker_widget.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/review_summary_screen.dart';
import 'package:pagepals/services/working_time_service.dart';
import 'package:pagepals/widgets/reader_info_widget/reader_info.dart';
import 'package:pagepals/widgets/space_between_row_widget.dart';

class BookingTimeScreen extends StatefulWidget {
  final ReaderProfile? reader;
  final Book book;
  final ServiceType serviceType;
  final Services service;

  const BookingTimeScreen({
    super.key,
    required this.reader,
    required this.book,
    required this.serviceType,
    required this.service,
  });

  @override
  State<BookingTimeScreen> createState() => _BookingTimeState();
}

class _BookingTimeState extends State<BookingTimeScreen> {
  late DateTime now;
  late DateTime selectedDate;

  WorkingTimeModel? workingTimeModels = WorkingTimeModel();
  String? selectedTimeSlotId;
  DateTime selectedTimeSlotDate = DateTime.now();

  TextEditingController controller = TextEditingController();

  Future<void> getWorkingTime() async {
    var result =
        await WorkingTimeService.getWorkingTime(widget.reader!.profile!.id!);
    setState(() {
      workingTimeModels = result;
    });
  }

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    selectedDate = DateTime(now.year, now.month, now.day);
    getWorkingTime();
  }

  void handleDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  void handleTimeSlotIdSelected(String? timeSlotId, DateTime? timeSlotDate) {
    setState(() {
      // Set the selected time slot
      selectedTimeSlotId = timeSlotId;
      selectedTimeSlotDate = timeSlotDate!;
    });
  }

  // Function to check if all required fields are selected
  bool areFieldsSelected() {
    return selectedTimeSlotId != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: const Text('Booking Detail'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ReaderInfoWidget(
                reader: widget.reader,
              ),
              const SizedBox(height: 20),
              SpaceBetweenRowWidget(
                start: 'Service Type',
                end: widget.serviceType.name ?? '',
              ),
              const SizedBox(height: 20),
              SpaceBetweenRowWidget(
                start: 'Book',
                end: widget.book.title ?? '',
              ),
              DatePickerWidget(
                onDateSelected: handleDateSelected,
                isWorkingTime: true,
              ),
              TimePickerWidget(
                selectedDate: selectedDate,
                workingTimeModels: workingTimeModels ?? WorkingTimeModel(),
                onTimeSlotIdSelected: handleTimeSlotIdSelected,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomButton(
        onPressed: areFieldsSelected()
            ? () {
                // Handle button press action here
                Navigator.of(context).push(
                  PageTransition(
                    child: ReviewSummaryScreen(
                      reader: widget.reader,
                      time: selectedTimeSlotDate,
                      timeSlotId: selectedTimeSlotId!,
                      book: widget.book,
                      service: widget.service,
                      serviceType: widget.serviceType,
                    ),
                    type: PageTransitionType.rightToLeft,
                    duration: const Duration(milliseconds: 200),
                  ),
                );
              }
            : null, // Disable button if fields are not selected
        title: 'Make appointment',
        isEnabled: areFieldsSelected(),
      ),
    );
  }
}
