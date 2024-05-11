import 'package:flutter/material.dart';
import 'package:pagepals/models/booking_model.dart';

class ServiceCommentWidget extends StatelessWidget {
  const ServiceCommentWidget({super.key, this.bookings});

  final List<Booking>? bookings;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Comments',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              decoration: TextDecoration.underline,
            ),
          ),
          const SizedBox(height: 10),
          if (bookings!.isEmpty)
            Center(
              child: const Text('No comments yet'),
            )
          else
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              controller: ScrollController()..addListener(() {}),
              child: Row(
                children: bookings!.map((booking) {
                  return Container(
                    width: 280,
                    height: 180,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 10),
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                booking.customer?.imageUrl ??
                                    'https://via.placeholder.com/150',
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              booking.customer?.fullName ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 260,
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            booking.review ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 3,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              (booking.createAt ?? '').split(' ').first,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
