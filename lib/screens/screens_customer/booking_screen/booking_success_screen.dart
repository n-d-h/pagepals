import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/success_widgets/bottom_success_button.dart';

class BookingSuccessScreen extends StatelessWidget {
  final ReaderProfile? reader;

  const BookingSuccessScreen({super.key, this.reader});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Success',
          style: GoogleFonts.lexend(
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        // backgroundColor: Colors.transparent, // Set AppBar background to transparent
        // elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: ScrollController(),
        child: Container(
          margin: const EdgeInsets.only(bottom: 70),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset('assets/booking_success.png'),
              const SizedBox(height: 10),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.lexend(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  children: [
                    const TextSpan(
                      text: 'You have successfully booked an appointment with ',
                    ),
                    TextSpan(
                      text: '@${reader!.profile!.account!.username!}',
                      style: GoogleFonts.lexend(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: ColorHelper.getColor(ColorHelper.green),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const SuccessBottomButton(),
    );
  }
}
