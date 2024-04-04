import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';

class NotificationAppBarBottom extends StatelessWidget {
  final int unreadCount;
  final Function()? onReadAllPressed;

  const NotificationAppBarBottom({
    super.key,
    required this.unreadCount,
    this.onReadAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
        decoration: BoxDecoration(
          color: ColorHelper.getColor(ColorHelper.grey).withOpacity(0.3),
        ),
        height: 35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Messages',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black45,
              ),
            ),
            InkWell(
              onTap: onReadAllPressed != null && unreadCount > 0
                  ? onReadAllPressed
                  : null,
              child: Text('Read All ($unreadCount)',
                  style: TextStyle(
                    color:
                        unreadCount > 0 ? Colors.orange.shade700 : Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
