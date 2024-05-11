import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';

import '../../../models/service_models/book_service_model.dart';

class ServiceWidget extends StatelessWidget {
  const ServiceWidget({super.key, required this.service});

  final BookServices? service;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 5,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                service?.imageUrl ??
                    'https://via.placeholder.com/150',
                width: 160,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 16,
                      right: 8,
                    ),
                    width: 35,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          service?.reader?.avatarUrl ??
                              'https://via.placeholder.com/150',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text(
                    service?.reader?.nickname ??
                        'reader name',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(right: 16),
                child: Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      color: Colors.black54,
                      size: 16,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '${service?.duration?.toInt() ?? '0'} mins',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 2),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Text(
              service?.serviceType?.name ?? 'Service name',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding:
            const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: ColorHelper.getColor('#FFA800'),
                      size: 16,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 2),
                      child: Text(
                        '${service?.rating?.toString() ?? '0'}.0',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 2),
                      child: Text(
                        '(${service?.totalOfReview?.toString() ?? '0'})',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    )
                  ],
                ),
                Text(
                  '${service?.price?.toString() ?? '0'} pals',
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
