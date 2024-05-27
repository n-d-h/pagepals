import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/book_models/book_model.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/models/service_models/book_service_model.dart';
import 'package:pagepals/screens/screens_customer/service_screen/service_list_screen.dart';
import 'package:pagepals/screens/screens_customer/service_screen/service_screen.dart';
import 'package:pagepals/screens/screens_customer/service_screen/service_widget.dart';

class ProfileServiceCollection extends StatefulWidget {
  const ProfileServiceCollection({
    super.key,
    required this.services,
    required this.book,
    required this.reader,
  });

  final List<Services> services;
  final Book book;
  final ReaderProfile reader;

  @override
  State<ProfileServiceCollection> createState() =>
      _ProfileServiceCollectionState();
}

class _ProfileServiceCollectionState extends State<ProfileServiceCollection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 401,
      decoration: const BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.fromLTRB(0, 1, 0, 10),
      margin: const EdgeInsets.only(bottom: 20, top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Service Collection',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        child: ServiceListScreen(
                          book: widget.book,
                          services: widget.services,
                          reader: widget.reader,
                        ),
                        type: PageTransitionType.bottomToTop,
                      ),
                    );
                  },
                  child: Text(
                    'See All',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: ColorHelper.getColor(ColorHelper.green),
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 320,
            margin: const EdgeInsets.only(top: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
                  widget.services.length > 5 ? 5 : widget.services.length,
              itemBuilder: (BuildContext context, int index) {
                Services serviceItem = widget.services[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        child: ServiceScreen(
                          serviceId: serviceItem.id ?? '',
                          closeIcon: Icons.close,
                        ),
                        type: PageTransitionType.bottomToTop,
                        duration: const Duration(milliseconds: 300),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 20, left: 5),
                    height: 450,
                    child: ServiceWidget(
                      service: BookServices(
                        id: serviceItem.id,
                        description: serviceItem.description,
                        price: serviceItem.price,
                        duration: serviceItem.duration,
                        rating: serviceItem.rating,
                        shortDescription: serviceItem.shortDescription,
                        totalOfReview: serviceItem.totalOfReview,
                        totalOfBooking: serviceItem.totalOfBooking,
                        imageUrl: serviceItem.imageUrl,
                        reader: Reader(
                          avatarUrl: widget.reader.profile?.avatarUrl!,
                          nickname: widget.reader.profile?.nickname!,
                        ),
                        serviceType: ServiceType(
                          name: serviceItem.serviceType?.name ?? '',
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
