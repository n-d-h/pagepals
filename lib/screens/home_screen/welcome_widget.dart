import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * SpaceHelper.spaceNineTenths,
      padding: const EdgeInsets.symmetric(
        horizontal: SpaceHelper.space24,
        vertical: SpaceHelper.space24,
      ),
      margin: const EdgeInsets.symmetric(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.account_circle_outlined,
            size: 80.0,
            color: Colors.black54,
          ),
          const SizedBox(height: SpaceHelper.space8),
          RichText(
            text: TextSpan(
                text: '${AppLocalizations.of(context)?.appWelcomeBack}, ',
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
                children: [
                  TextSpan(
                      text: 'Guest',
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: ColorHelper.getColor(ColorHelper.green)))
                ]),
          )
        ],
      ),
    );
  }
}
