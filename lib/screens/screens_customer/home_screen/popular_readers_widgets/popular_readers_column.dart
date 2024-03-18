import 'package:flutter/material.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pagepals/screens/screens_customer/home_screen/popular_readers_widgets/popular_reader_leading.dart';
import 'package:pagepals/screens/screens_customer/home_screen/popular_readers_widgets/popular_reader_widget.dart';

class PopularReadersColumn extends StatelessWidget {
  const PopularReadersColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * SpaceHelper.spaceNineTenths,
      margin: const EdgeInsets.fromLTRB(24, 0, 0, 20),
      child: Column(
        children: [
          CardLeading(
            title: AppLocalizations.of(context)!.appPopularReader,
            seeAll: true,
          ),
          const PopularReaderWidget()
        ],
      ),
    );
  }
}
