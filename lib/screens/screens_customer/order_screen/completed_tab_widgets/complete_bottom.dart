import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/booking_model.dart';
import 'package:pagepals/screens/screens_customer/order_screen/completed_tab_widgets/complete_rating_widgets/rating_bottom_sheet.dart';

class CompletedBottom extends StatefulWidget {
  final Booking booking;

  const CompletedBottom({super.key, required this.booking});

  @override
  State<CompletedBottom> createState() => _CompletedBottomState();
}

class _CompletedBottomState extends State<CompletedBottom> {
  bool isReviewSubmitted = false;

  void setReviewSubmitted(bool value) {
    setState(() {
      isReviewSubmitted = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 14),
      child: widget.booking.rating != null || isReviewSubmitted
          ? Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: ColorHelper.getColor('#C6F4DE'),
                      side: const BorderSide(color: Colors.transparent),
                      // fixedSize: const Size.fromWidth(148),
                    ),
                    child: Text(
                      'Re-book',
                      style: GoogleFonts.lexend(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: ColorHelper.getColor(ColorHelper.green),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: ColorHelper.getColor('#C6F4DE'),
                      side: const BorderSide(color: Colors.transparent),
                      fixedSize: const Size.fromWidth(148),
                    ),
                    child: Text(
                      'Re-book',
                      style: GoogleFonts.lexend(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: ColorHelper.getColor(ColorHelper.green),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      showBottomSheetRating(
                          context, widget.booking, setReviewSubmitted);
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: ColorHelper.getColor(ColorHelper.green),
                      side: const BorderSide(color: Colors.transparent),
                      fixedSize: const Size.fromWidth(148),
                    ),
                    child: Text(
                      'Review',
                      style: GoogleFonts.lexend(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

void showBottomSheetRating(
    BuildContext context, Booking booking, Function(bool) setReviewSubmitted) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return RatingBottomSheet(
        booking: booking,
        setReviewSubmitted: setReviewSubmitted,
      );
    },
  );
}
