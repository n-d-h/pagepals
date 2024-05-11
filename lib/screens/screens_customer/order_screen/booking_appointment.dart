import 'package:flutter/material.dart';
import 'package:pagepals/models/booking_model.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/bottom_nav_button.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/book_row.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/service_row.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/time_row.dart';
import 'package:pagepals/widgets/reader_info_widget/reader_info.dart';
import 'package:pagepals/widgets/space_between_row_widget.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

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
        )
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
              if (booking!.state!.name == 'CANCEL')
                Column(
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
                )
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
