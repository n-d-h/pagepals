import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';

class NoOrderWidget extends StatelessWidget {
  const NoOrderWidget({super.key});

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
      child: Center(
        child: Column(
          children: [
            const Image(
              image: AssetImage('assets/order.png'),
              width: SpaceHelper.space256,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: SpaceHelper.space24),
            const Text(
              'No order yet',
              style: TextStyle(
                fontSize: SpaceHelper.fontSize18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: SpaceHelper.space24),
            const Text(
              'You have no order yet. When you have a message, you will see it here',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SpaceHelper.fontSize16,
              ),
            ),
            const SizedBox(height: SpaceHelper.space24),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                 foregroundColor: ColorHelper.getColor(ColorHelper.normal),
                side: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              child: const Text(
                'Explore Now',
                style: TextStyle(
                  fontSize: SpaceHelper.fontSize16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
