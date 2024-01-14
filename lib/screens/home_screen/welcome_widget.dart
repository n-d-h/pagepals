import 'package:flutter/material.dart';
import 'package:pagepals/helpers/space_helper.dart';

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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.person,
            size: 80.0,
            color: Colors.black,
          ),
          SizedBox(height: SpaceHelper.space24),
          Text(
            'Welcome back, Guest!',
            style: TextStyle(
              fontSize: SpaceHelper.fontSize18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
