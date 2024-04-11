import 'package:flutter/material.dart';
import 'package:pagepals/models/booking_model.dart';
import 'package:pagepals/widgets/reader_info_widget/booking_badge.dart';

class CustomerInfoWidget extends StatelessWidget {
  final CustomerBooked? customer;

  const CustomerInfoWidget({super.key, this.customer});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12, width: 1))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(customer?.imageUrl ??
                'https://th.bing.com/th/id/OIP.JBpgUJhTt8cI2V05-Uf53AHaG1?rs=1&pid=ImgDetMain'),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BookingBadge(
                  title: '@${customer?.account?.username ?? 'username'}'),
              Text(
                customer?.fullName ?? 'full name',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              // SizedBox(height: 10,),
              Text(
                '${customer?.account?.email ?? 'customer@email.com'}',
                style: const TextStyle(
                    overflow: TextOverflow.clip,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${customer?.gender ?? 'GENDER'}',
                style: const TextStyle(
                    overflow: TextOverflow.clip,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
            ],
          )
        ],
      ),
    );
  }
}
