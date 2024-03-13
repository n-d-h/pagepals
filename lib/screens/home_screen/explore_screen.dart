import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      margin: const EdgeInsets.only(bottom: 24),
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
          Row(
            children: [
              Expanded(
                flex: 9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.appFindYourFavor,
                      style: const TextStyle(
                        fontSize: SpaceHelper.fontSize10,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.appExploreText1,
                      style: const TextStyle(
                        fontSize: SpaceHelper.fontSize16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.appExploreText2,
                      style: TextStyle(
                        fontSize: SpaceHelper.fontSize14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
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
            child: Text(
              AppLocalizations.of(context)!.appExploreNow,
              style: const TextStyle(
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
