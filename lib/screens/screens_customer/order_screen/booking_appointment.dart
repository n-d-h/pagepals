import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/report_reson_helper.dart';
import 'package:pagepals/models/authen_models/account_model.dart'
    as account_model;
import 'package:pagepals/models/booking_meeting_record_model.dart';
import 'package:pagepals/models/booking_model.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/bottom_nav_button.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/book_row.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/service_row.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/time_row.dart';
import 'package:pagepals/screens/screens_customer/recording_screen/recording_screen.dart';
import 'package:pagepals/services/booking_service.dart';
import 'package:pagepals/widgets/reader_info_widget/reader_info.dart';
import 'package:pagepals/widgets/report_dialog.dart';
import 'package:pagepals/widgets/space_between_row_widget.dart';

class BookingAppointment extends StatefulWidget {
  final Booking? booking;
  final bool isVisible;

  const BookingAppointment({super.key, this.booking, required this.isVisible});

  @override
  State<BookingAppointment> createState() => _BookingAppointmentState();
}

class _BookingAppointmentState extends State<BookingAppointment> {
  BookingMeetingRecordModel? bookingMeetingRecordModel;

  Future<void> getBookingById(String id) async {
    var res = await BookingService.isBookingReport(id);
    setState(() {
      bookingMeetingRecordModel = res;
    });
  }

  @override
  void initState() {
    super.initState();
    getBookingById(widget.booking!.id!);
  }

  @override
  Widget build(BuildContext context) {
    if (bookingMeetingRecordModel == null) {
      return Scaffold(
        body: Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
              color: ColorHelper.getColor(ColorHelper.green), size: 60),
        ),
      );
    }
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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
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
                readerInfo: widget.booking!.service?.reader!,
              ),
              TimeRowWidget(
                time: DateTime.parse(
                    widget.booking?.startAt ?? '2021-2-1 12:00:00'),
              ),
              SpaceBetweenRowWidget(
                start: 'Duration',
                end: widget.booking?.service != null
                    ? '${widget.booking?.service?.duration?.toInt()} minutes'
                    : '${widget.booking?.event?.seminar?.duration!.toInt()} minutes',
              ),
              BookRowWidget(
                book: widget.booking?.service != null
                    ? widget.booking?.service?.book?.title ?? 'Unknown'
                    : widget.booking?.event?.seminar?.book?.title ?? 'Unknown',
              ),
              widget.booking?.service != null
                  ? ServiceRowWidget(
                      service: widget.booking!.service!.description!,
                      serviceType: widget.booking!.service!.serviceType!.name!,
                    )
                  : ServiceRowWidget(
                      serviceType: "",
                      service: widget.booking!.event!.seminar!.description!,
                    ),
              const SizedBox(height: 16),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                height: 1,
                color: Colors.black.withOpacity(0.1),
              ),
              SpaceBetweenRowWidget(
                start: 'Amount',
                end: widget.booking?.service != null
                    ? '${widget.booking!.service!.price!.toInt()} pals'
                    : '${widget.booking!.event!.price!.toInt()} pals',
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 300),
                      child: RecordingScreen(
                        booking: widget.booking,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    'View Recording',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.booking!.state!.name == 'CANCEL',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Cancel Reason',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87.withOpacity(0.5),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: DashedBorder.fromBorderSide(
                          dashLength: 5,
                          side: BorderSide(
                            color: Colors.redAccent.shade200,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.booking?.cancelReason ?? '',
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: DateTime.now().isAfter(
                      DateTime.parse(
                          widget.booking?.startAt ?? '2021-2-1 12:00:00'),
                    ) &&
                    (bookingMeetingRecordModel?.isReported ?? false) == false,
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ReportDialogWidget(
                          bookingId: widget.booking?.id,
                          accountModel: account_model.AccountModel(
                            customer: account_model.Customer(
                              id: widget.booking?.customer?.id,
                            ),
                          ),
                          listReportReasons: reportBookingReasons,
                          type: "BOOKING",
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Report Booking',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible:
                    (bookingMeetingRecordModel?.isReported ?? false) == true,
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Reported',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomButton(
        onPressed: () {
          Navigator.pop(context);
        },
        title: 'Back',
        isEnabled: true,
      ),
    );
  }
}
