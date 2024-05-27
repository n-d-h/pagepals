import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/book_models/book_model.dart' as book_model;
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/models/service_models/service_model.dart';
import 'package:pagepals/screens/screens_customer/book_screen/book_detail_widgets/book_description.dart';
import 'package:pagepals/screens/screens_customer/book_screen/book_detail_widgets/book_image_widget.dart';
import 'package:pagepals/screens/screens_customer/book_screen/book_detail_widgets/book_info_widget.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_time_screen.dart';
import 'package:pagepals/screens/screens_customer/profile_screen/profile_widgets/info_line.dart';
import 'package:pagepals/screens/screens_customer/service_screen/service_comment_widget.dart';
import 'package:pagepals/screens/screens_customer/service_screen/show_html_widget.dart';
import 'package:pagepals/services/service_service.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({
    super.key,
    required this.serviceId,
    required this.closeIcon,
  });

  final String serviceId;
  final IconData closeIcon;

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  ServiceModel? serviceModel;
  bool isShowMore = false;

  @override
  void initState() {
    super.initState();
    getServiceById(widget.serviceId);
  }

  getServiceById(String id) async {
    var result = await ServiceService.getServiceById(id);
    setState(() {
      serviceModel = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (serviceModel == null) {
      return Scaffold(
        body: Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: ColorHelper.getColor(ColorHelper.green),
            size: 60,
          ),
        ),
      );
    } else {
      book_model.Book book = serviceModel!.book!;
      String? authors = book.authors?.map((e) => e.name ?? '').join(', ');
      String? categories = book.categories?.map((e) => e.name ?? '').join(', ');
      return Scaffold(
        appBar: AppBar(
          title: const Text('Service Detail'),
          surfaceTintColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(widget.closeIcon),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                child: Image.network(
                  serviceModel?.imageUrl ?? '',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.grey[200]!),
                child: ProfileInfoLine(
                  reader: ReaderProfile(
                    profile: Profile(
                      id: serviceModel?.reader?.id ?? '',
                      avatarUrl: serviceModel?.reader?.avatarUrl ?? '',
                      nickname: serviceModel?.reader?.nickname ?? '',
                      countryAccent: serviceModel?.reader?.countryAccent ?? '',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  serviceModel?.serviceType?.name ?? '',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  bottom: 8.0,
                ),
                child: Text(
                  serviceModel?.shortDescription ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: ColorHelper.getColor(ColorHelper.green),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.monetization_on,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${serviceModel?.price ?? ''} pals',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: ColorHelper.getColor(ColorHelper.green),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.access_time_filled,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${serviceModel?.duration ?? ''} mins',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Book information',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    BookImage(url: book.thumbnailUrl),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              textAlign: TextAlign.center,
                              book.title ?? 'Book title',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          BookInfo(title: 'Authors: ', info: authors),
                          const SizedBox(height: 20),
                          BookInfo(title: 'Categories: ', info: categories),
                          const SizedBox(height: 20),
                          BookDescription(description: book.description),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Service information',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              ShowMoreHtmlWidget(
                htmlContent: serviceModel?.description ?? '',
                maxLines: 3,
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: (serviceModel?.bookings?.length ?? 0) > 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCommentWidget(
                    bookings: serviceModel?.bookings,
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          surfaceTintColor: Colors.white,
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              color: ColorHelper.getColor(ColorHelper.green),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    PageTransition(
                      child: BookingTimeScreen(
                        reader: ReaderProfile(
                          profile: Profile(
                            id: serviceModel?.reader?.id ?? '',
                            avatarUrl: serviceModel?.reader?.avatarUrl ?? '',
                            countryAccent:
                                serviceModel?.reader?.countryAccent ?? '',
                            nickname: serviceModel?.reader?.nickname ?? '',
                            rating: serviceModel?.reader?.rating ?? 0,
                            totalOfReviews:
                                serviceModel?.reader?.totalOfReviews ?? 0,
                          ),
                        ),
                        book: serviceModel?.book ?? book_model.Book(),
                        serviceType: serviceModel!.serviceType ??
                            book_model.ServiceType(),
                        service: book_model.Services(
                          id: serviceModel?.id ?? '',
                          description: serviceModel?.description ?? '',
                          duration: serviceModel?.duration ?? 0,
                          price: serviceModel?.price ?? 0,
                          rating: serviceModel?.rating ?? 0,
                          totalOfBooking: serviceModel?.totalOfBooking ?? 0,
                          totalOfReview: serviceModel?.totalOfReview ?? 0,
                          imageUrl: serviceModel?.imageUrl ?? '',
                          serviceType: serviceModel!.serviceType ??
                              book_model.ServiceType(),
                        ),
                      ),
                      type: PageTransitionType.rightToLeft,
                      duration: const Duration(milliseconds: 300),
                    ),
                  );
                },
                child: const Text(
                  'Book Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
