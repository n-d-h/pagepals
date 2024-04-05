import 'package:flutter/material.dart';

class ServiceRowWidget extends StatelessWidget {
  final String service;
  final String serviceType;

  const ServiceRowWidget({
    Key? key,
    required this.serviceType,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 113,
              child: Text(
                'Service type',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87.withOpacity(0.5),
                ),
              ),
            ),
            Expanded(
              child: Text(
                serviceType,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  overflow: TextOverflow.clip,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 113,
              child: Text(
                'Service',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87.withOpacity(0.5),
                ),
              ),
            ),
            Expanded(
              child: Text(
                service,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  overflow: TextOverflow.clip,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
