import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CardLeading extends StatelessWidget {
  final String title;
  final bool seeAll;

  const CardLeading({super.key, required this.title, required this.seeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: seeAll ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        if (seeAll)
          TextButton(
            onPressed: () {},
            child: Text(
              AppLocalizations.of(context)!.appSeeAll,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: ColorHelper.getColor(ColorHelper.green),
                fontSize: 14,
              ),
            ),
          ),
      ],
    );
  }
}
