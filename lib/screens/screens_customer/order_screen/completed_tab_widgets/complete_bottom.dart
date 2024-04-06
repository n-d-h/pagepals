import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/booking_model.dart';

class CompletedBottom extends StatelessWidget {
  final Booking booking;

  const CompletedBottom({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OutlinedButton(
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
          OutlinedButton(
            onPressed: () {
              showBottomSheetRating(context);
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
        ],
      ),
    );
  }
}
// show bottom sheet rating

void showBottomSheetRating(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    // Set background color to transparent
    // useSafeArea: true,

    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8 + 70,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
          ),
          // Modal Bottom Sheet Content
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20), // Add border radius to top
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 65,
                  ),
                  const Text(
                    'Rate your experience',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'How was your experience with the service provider?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Rating',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Rating bar widget
                  // Add your RatingBar.builder widget here
                  const SizedBox(height: 20),
                  const Text(
                    'Review',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: 'Write your review here',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12, width: 1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorHelper.getColor(ColorHelper.green),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Circular Avatar
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CircleAvatar(
              radius: 70,
              backgroundColor: Colors.white, // Change color as needed
              child: CircleAvatar(
                radius: 65,
                backgroundColor: Colors.white, // Change color as needed
                backgroundImage: NetworkImage(
                    'https://via.placeholder.com/150'), // Add your image here
              ),
            ), // Add your avatar here
          ),
        ],
      );
    },
  );
}
