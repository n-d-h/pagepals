import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagepals/custom_icons.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/booking_model.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/bottom_nav_button.dart';
import 'package:unicons/unicons.dart';

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
  final TextEditingController controller = TextEditingController();
  double keyboardPadding = 0.0;
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
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
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom +
                        keyboardPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 55,
                      ),
                      const Center(
                        child: Text(
                          'Bui Le Van Minh',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 3),
                      const Center(
                        child: Text(
                          '@minmin',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          'How was your experience with reader',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        color: Colors.black12,
                        thickness: 2,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 40),
                        child: Column(
                          children: [
                            const Text(
                              'Your rating',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: RatingBar(
                                itemSize: 45,
                                initialRating: 0,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                ratingWidget: RatingWidget(
                                  full: const Icon(
                                    CustomIcons.star,
                                    color: Colors.amber,
                                  ),
                                  half: const Icon(
                                    Icons.star_half,
                                    color: Colors.amber,
                                  ),
                                  empty: const Icon(
                                    UniconsLine.star,
                                    color: Colors.amber,
                                  ),
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.black12,
                        thickness: 2,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Add details (optional)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: const DashedBorder.fromBorderSide(
                              dashLength: 15,
                              side: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              )),
                          // borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                        child: TextField(
                          controller: controller,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: 'Type your note here ...',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black.withOpacity(0.3),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
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

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomButton(
                title: 'Submit',
                onPressed: () {
                  Navigator.pop(context);
                },
                isEnabled: true,
              ),
            )
          ],
        ),
      );
    },
  );
  // Listen for changes in viewInsets
  WidgetsBinding.instance.addPostFrameCallback((_) {
    keyboardPadding = MediaQuery.of(context).viewInsets.bottom;
  });
}
