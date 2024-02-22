import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * SpaceHelper.spaceNineTenths,
      padding: const EdgeInsets.symmetric(
        horizontal: SpaceHelper.space24,
        vertical: SpaceHelper.space24,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(SpaceHelper.space16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: SpaceHelper.space8,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(
            children: [
              Expanded(
                flex: 9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Find your favor',
                      style: TextStyle(
                        fontSize: SpaceHelper.fontSize10,
                      ),
                    ),
                    Text(
                      'View readers and explore '
                      'new point of view to your '
                      'favorite books',
                      style: TextStyle(
                        fontSize: SpaceHelper.fontSize16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Start explore now, find your favorite '
                      'book and start record, having your '
                      'own meeting 1 on 1 with readers',
                      style: TextStyle(
                        fontSize: SpaceHelper.fontSize14,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Image(
                  image: AssetImage('assets/book_reader.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(height: SpaceHelper.space24),
          ElevatedButton(
            onPressed: () {
              // TODO: Navigate to list of readers
              // Navigator.of(context).push(
              //   PageTransition(
              //   //   child: const ProfileOverviewScreen(),
              //   //   type: PageTransitionType.bottomToTop,
              //   //   duration: const Duration(milliseconds: 300)
              //   // )
              //   ),
              // );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: ColorHelper.getColor(ColorHelper.white),
              backgroundColor: ColorHelper.getColor(ColorHelper.normal),
              padding: const EdgeInsets.symmetric(
                horizontal: SpaceHelper.space32,
                vertical: SpaceHelper.space16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(SpaceHelper.space16),
              ),
            ),
            child: const Text(
              'Explore Now',
              style: TextStyle(
                fontSize: SpaceHelper.fontSize16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
