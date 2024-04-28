import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/models/book_models/book_model.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/models/working_time_model.dart';
import 'package:pagepals/screens/screens_customer/book_screen/search_reader_book_screen.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/book_text_form.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/bottom_nav_button.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/day_picker_widget.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/dropdown_buttons/dropdown_button_widget.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/dropdown_buttons/select_service_dropdown.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/radio_buttons/time_picker_widget.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/request_schedule.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/review_summary_screen.dart';
import 'package:pagepals/services/book_service.dart';
import 'package:pagepals/services/service_type_service.dart';
import 'package:pagepals/services/working_time_service.dart';
import 'package:pagepals/widgets/reader_info_widget/reader_info.dart';

class BookingTimeScreen extends StatefulWidget {
  final ReaderProfile? reader;
  final BookModel bookModel;

  const BookingTimeScreen({
    super.key,
    required this.reader,
    required this.bookModel,
  });

  @override
  State<BookingTimeScreen> createState() => _BookingTimeState();
}

class _BookingTimeState extends State<BookingTimeScreen> {
  late DateTime now;
  late DateTime selectedDate;

  Book? _selectedBook;
  Book? _oldSelectedBook;

  List<ServiceType> serviceTypesByBook = [];
  ServiceType? _selectServiceType;
  ServiceType? _oldSelectServiceType;

  List<Services> servicesByBook = [];
  List<Services> servicesByServiceType = [];
  Services? _selectedService;

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

  // Function to handle book selection
  void handleBookSelected(String bookId) async {
    // Get the selected book model
    var bookModel = await BookService.getBookById(bookId);
    // Set the selected book
    setState(() {
      if (_oldSelectedBook != null) {
        if (_oldSelectedBook!.id != bookId) {
          servicesByBook = [];
          serviceTypesByBook = [];
          servicesByServiceType = [];
        }
      }
    });
    Future.delayed(const Duration(milliseconds: 40), () async {
      var serviceTypes =
          await ServiceTypeService.getListServiceTypesByServicesOfReaderBook(
              bookId, widget.reader!.profile!.id!);

      setState(() {
        _selectedBook = bookModel;
        controller.text = _selectedBook!.title!;

        if (serviceTypes.isNotEmpty) {
          // reloading page if the book is changed
          _oldSelectedBook = _selectedBook;
          _selectServiceType = null;
          _oldSelectServiceType = null;
          _selectedService = null;
          servicesByServiceType = [];

          // Set the service types by book
          serviceTypesByBook = serviceTypes;
        }
      });
    });
  }

  // Function to handle chapter selection
  void handleSelectedTypeSelected(String? selectedTypeId) async {
    // Get the services from the selected book model
    var services =
        await ServiceTypeService.getListServiceByServiceTypeAndBookAndReader(
            widget.reader!.profile!.id!, _selectedBook!.id!, selectedTypeId!);
    setState(() {
      // Set the selected service type
      _selectServiceType = serviceTypesByBook
          .firstWhere((serviceType) => serviceType.id == selectedTypeId);
    });

    if (_oldSelectServiceType != null) {
      if (_oldSelectServiceType!.id != _selectServiceType!.id) {
        setState(() {
          servicesByServiceType = [];
        });
      }
    }
    Future.delayed(const Duration(milliseconds: 40), () {
      setState(() {
        _oldSelectServiceType = _selectServiceType;
        // Filter services in book by the selected service type
        servicesByServiceType = services;
      });
    });
  }

  void handleServiceSelected(String? serviceId) {
    setState(() {
      _selectedService = servicesByServiceType
          .firstWhere((service) => service.id == serviceId);
    });
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
    return _selectedBook != null &&
        _selectServiceType != null &&
        _selectedService != null &&
        selectedTimeSlotId != null;
  }

  @override
  Widget build(BuildContext context) {
    print('selectedBook: ${_selectedBook?.id ?? ''}');
    print('old selected book: ${_oldSelectedBook?.id ?? ''}');
    print('service types by book: ${serviceTypesByBook.length}');
    print('service by service type: ${servicesByServiceType.length}');
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: const Text('Booking Detail'),
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
              BookTextFormField(
                  controller: controller,
                  hint: 'Select Item',
                  onTap: () {
                    Navigator.of(context).push(
                      PageTransition(
                        child: SearchReaderBooks(
                          readerId: widget.reader!.profile!.id!,
                          onSelected: handleBookSelected,
                        ),
                        type: PageTransitionType.rightToLeft,
                        duration: const Duration(milliseconds: 300),
                      ),
                    );
                  }),
              if (serviceTypesByBook.isNotEmpty)
                SelectServiceDropdown(
                  title: 'Service Type',
                  opt: 1,
                  selectedItemBuilder: (value) {
                    return serviceTypesByBook
                        .map<Widget>(
                          (e) => Text(
                            e.name ?? 'Service Type',
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        )
                        .toList();
                  },
                  items: serviceTypesByBook
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item.id,
                          child: Text(
                            item.name ?? 'Service',
                            style: const TextStyle(
                              overflow: TextOverflow.clip,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onValueChanged: handleSelectedTypeSelected,
                ),
              if (servicesByServiceType.isNotEmpty)
                SelectServiceDropdown(
                  title: 'Service',
                  opt: 2,
                  selectedItemBuilder: (value) {
                    return servicesByServiceType
                        .map<Widget>(
                          (e) => Text(
                            e.description ?? 'Service',
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        )
                        .toList();
                  },
                  items: servicesByServiceType
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item.id,
                          child: Text(
                            item.description ?? 'Service',
                            style: const TextStyle(
                              overflow: TextOverflow.clip,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onValueChanged: handleServiceSelected,
                ),
              DatePickerWidget(
                onDateSelected: handleDateSelected,
              ),
              TimePickerWidget(
                selectedDate: selectedDate,
                workingTimeModels: workingTimeModels ?? WorkingTimeModel(),
                onTimeSlotIdSelected: handleTimeSlotIdSelected,
              ),
              const RequestScheduleWidget(),
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
                      book: _selectedBook,
                      service: _selectedService,
                      serviceType: _selectServiceType,
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
