import 'package:flutter/material.dart';

class ServiceRowWidget extends StatelessWidget {
  final int service;

  const ServiceRowWidget({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String serviceType;
    switch (service) {
      case 1:
        serviceType = 'Read book';
        break;
      case 2:
        serviceType = 'Book explaining';
        break;
      case 3:
        serviceType = 'Not one of the above';
        break;
      default:
        serviceType = 'Unknown'; // Handle unknown service type
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Service type',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.black87.withOpacity(0.5),
              ),
            ),
            Text(
              serviceType,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
