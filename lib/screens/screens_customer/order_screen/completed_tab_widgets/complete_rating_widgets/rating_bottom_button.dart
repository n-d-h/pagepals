import 'package:flutter/material.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/bottom_nav_button.dart';
import 'package:pagepals/services/booking_service.dart';

class RatingBottomButton extends StatefulWidget {
  final String bookingId;
  final int rating;
  final String review;
  final Function(bool) setReviewSubmitted;

  const RatingBottomButton(
      {super.key,
      required this.bookingId,
      required this.rating,
      required this.review,
      required this.setReviewSubmitted});

  @override
  State<RatingBottomButton> createState() => _RatingBottomButtonState();
}

class _RatingBottomButtonState extends State<RatingBottomButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: BottomButton(
        title: 'Submit',
        onPressed: () async {
          setState(() {
            isLoading = true;
          });

          bool isSubmitted = await BookingService.reviewBooking(
              widget.bookingId, widget.rating, widget.review);
          if (isSubmitted) {
            Future.delayed(const Duration(milliseconds: 40), () {
              setState(() {
                isLoading = false;
              });
              widget.setReviewSubmitted(true);
              Navigator.pop(context);
            });
          } else {
            setState(() {
              isLoading = false;
            });
          }
        },
        isLoading: isLoading,
        isEnabled: widget.rating > 0,
      ),
    );
  }
}
