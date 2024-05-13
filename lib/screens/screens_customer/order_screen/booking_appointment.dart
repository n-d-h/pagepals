import 'package:flutter/material.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/report_reson_helper.dart';
import 'package:pagepals/models/authen_models/account_model.dart'
    as account_model;
import 'package:pagepals/models/booking_model.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/bottom_nav_button.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/book_row.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/service_row.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/time_row.dart';
import 'package:pagepals/screens/screens_customer/recording_screen/recording_screen.dart';
import 'package:pagepals/widgets/reader_info_widget/reader_info.dart';
import 'package:pagepals/widgets/report_dialog.dart';
import 'package:pagepals/widgets/space_between_row_widget.dart';

class BookingAppointment extends StatelessWidget {
  final Booking? booking;

  const BookingAppointment({super.key, this.booking});

  @override
  Widget build(BuildContext context) {
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
                readerInfo: booking!.service?.reader!,
              ),
              TimeRowWidget(
                time: DateTime.parse(booking?.startAt ?? '2021-2-1 12:00:00'),
              ),
              SpaceBetweenRowWidget(
                start: 'Duration',
                end: booking?.service != null
                    ? '${booking?.service?.duration?.toInt()} minutes'
                    : '${booking?.event?.seminar?.duration!.toInt()} minutes',
              ),
              BookRowWidget(
                book: booking?.service != null
                    ? booking?.service?.book?.title ?? 'Unknown'
                    : booking?.event?.seminar?.book?.title ?? 'Unknown',
              ),
              booking?.service != null
                  ? ServiceRowWidget(
                      service: booking!.service!.description!,
                      serviceType: booking!.service!.serviceType!.name!,
                    )
                  : ServiceRowWidget(
                      serviceType: "",
                      service: booking!.event!.seminar!.description!,
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
                end: booking?.service != null
                    ? '${booking!.service!.price!.toInt()} pals'
                    : '${booking!.event!.price!.toInt()} pals',
              ),
              Visibility(
                visible: DateTime.now().isAfter(
                  DateTime.parse(booking?.startAt ?? '2021-2-1 12:00:00'),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      PageTransition(
                        type: PageTransitionType.fade,
                        duration: const Duration(milliseconds: 300),
                        child: RecordingScreen(
                          booking: booking,
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
              ),
              Visibility(
                visible: booking!.state!.name == 'CANCEL',
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
                          booking?.cancelReason ?? '',
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
                  DateTime.parse(booking?.startAt ?? '2021-2-1 12:00:00'),
                ),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ReportDialogWidget(
                          bookingId: booking?.id,
                          accountModel: account_model.AccountModel(
                            customer: account_model.Customer(
                              id: booking?.customer?.id,
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
