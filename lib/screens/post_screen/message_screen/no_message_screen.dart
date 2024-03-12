import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/screens/post_screen/message_screen/message_chat_screen.dart';

class NoMessageWidget extends StatelessWidget {
  const NoMessageWidget({super.key});

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
              image: AssetImage('assets/no_message.png'),
              width: SpaceHelper.space256,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: SpaceHelper.space24),
            const Text(
              'No messages yet',
              style: TextStyle(
                fontSize: SpaceHelper.fontSize18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: SpaceHelper.space24),
            const Text(
              'You have no messages yet. When you have a message, you will see it here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SpaceHelper.fontSize16,
              ),
            ),
            const SizedBox(height: SpaceHelper.space24),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).push(
                  PageTransition(
                    child: MessageChatScreen(),
                    type: PageTransitionType.bottomToTop,
                    duration: const Duration(milliseconds: 300),
                  ),
                );
              },
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
