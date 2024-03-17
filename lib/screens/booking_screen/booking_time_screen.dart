import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/screens/booking_screen/booking_widgets/bottom_nav_button.dart';
import 'package:pagepals/screens/booking_screen/booking_widgets/day_picker_widget.dart';
import 'package:pagepals/screens/booking_screen/booking_widgets/dropdown_buttons/dropdown_button_widget.dart';
import 'package:pagepals/screens/booking_screen/booking_widgets/radio_buttons/radio_buttons_widget.dart';
import 'package:pagepals/screens/booking_screen/booking_widgets/request_schedule.dart';
import 'package:pagepals/screens/booking_screen/review_summary_screen.dart';
import 'package:pagepals/widgets/reader_info_widget/reader_info.dart';

import '../../models/book_model.dart';
import 'booking_widgets/time_slot_picker_widget.dart';

class BookingTimeScreen extends StatefulWidget {
  final ReaderProfile? reader;
  final List<BookModel> books;

  const BookingTimeScreen({
    super.key,
    required this.reader,
    required this.books,
  });

  @override
  State<BookingTimeScreen> createState() => _BookingTimeState();
}

class _BookingTimeState extends State<BookingTimeScreen> {
  late DateTime now;
  late DateTime selectedDate;
  int? _selectedRadioButtonValue;

  String? _selectedBook;
  String? _selectedChapter;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    selectedDate = DateTime(now.year, now.month, now.day);
  }

  // Function to handle book selection
  void handleBookSelected(String? book) {
    setState(() {
      _selectedBook = book;
    });
    debugPrint('Selected book: $_selectedBook');
  }

  // Function to handle chapter selection
  void handleChapterSelected(String? chapter) {
    setState(() {
      _selectedChapter = chapter;
    });
    debugPrint('Selected chapter: $_selectedChapter');
  }

  void handleDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
    debugPrint('selected date: ${selectedDate.toString()}');
  }

  // Function to check if all required fields are selected
  bool areFieldsSelected() {
    // selectedDate is always not null
    return _selectedBook != null &&
        _selectedChapter != null &&
        _selectedRadioButtonValue != null;
  }
    List<String> chapters = [];


  @override
  Widget build(BuildContext context) {
    final List<String> books = widget.books.map((e) => e.title!).toList();
    // final List<String> books =
    //     List.generate(10, (index) => 'This is book num $index');
    // final List<String> chapters = bookData
    //     .map((e) => e.chapters!.map((e) => e.chapterNumber!).toString())
    //     .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book appointment'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.black,
          fontSize: 24,
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
              DropdownButtonWidget(
                title: 'Book Selection',
                opt: 1,
                items: books,
                onValueChanged: handleBookSelected,
              ),
              DropdownButtonWidget(
                title: 'Chapter Selection',
                opt: 2,
                items: chapters,
                onValueChanged: handleChapterSelected,
              ),
              DatePickerWidget(
                onDateSelected: handleDateSelected,
              ),
              // Pass the updated selectedDate to the TimeSlotPicker widget
              TimeSlotPicker(
                selectedDate: selectedDate,
                onTimeSlotSelected: handleDateSelected,
              ),
              const RequestScheduleWidget(),
              RadioButtonsWidget(
                onValueChanged: (value) {
                  setState(() {
                    _selectedRadioButtonValue = value;
                    debugPrint(
                        'selected radio button value: ${_selectedRadioButtonValue.toString()}');
                  });
                },
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
                      time: selectedDate,
                      book: _selectedBook,
                      chapter: _selectedBook,
                      serviceType: _selectedRadioButtonValue,
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
