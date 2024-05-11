import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/models/book_models/book_model.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/models/service_models/book_service_model.dart';
import 'package:pagepals/screens/screens_customer/service_screen/service_screen.dart';
import 'package:pagepals/screens/screens_customer/service_screen/service_widget.dart';

class ServiceListScreen extends StatefulWidget {
  const ServiceListScreen({
    super.key,
    required this.book,
    required this.services,
    required this.reader,
  });

  final Book? book;
  final List<Services> services;
  final ReaderProfile reader;

  @override
  State<ServiceListScreen> createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services'),
        centerTitle: true,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        physics: const BouncingScrollPhysics(),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...widget.services.map((serviceItem) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        child: ServiceScreen(
                          serviceId: serviceItem.id ?? '',
                          closeIcon: Icons.arrow_back_ios,
                        ),
                        type: PageTransitionType.bottomToTop,
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 350,
                    child: ServiceWidget(
                      service: BookServices(
                        id: serviceItem.id,
                        description: serviceItem.description,
                        price: serviceItem.price,
                        duration: serviceItem.duration,
                        rating: serviceItem.rating,
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
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
