import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/service_models/book_service_model.dart';
import 'package:pagepals/screens/screens_customer/book_screen/service_relate_to_book_screen.dart';
import 'package:pagepals/screens/screens_customer/profile_screen/overview_screen.dart';
import 'package:pagepals/screens/screens_customer/service_screen/service_screen.dart';
import 'package:pagepals/services/service_service.dart';

class BookServiceBox extends StatefulWidget {
  final String? bookId;

  const BookServiceBox({super.key, this.bookId});

  @override
  State<BookServiceBox> createState() => _BookServiceBoxState();
}

class _BookServiceBoxState extends State<BookServiceBox> {
  BookServiceModel? bookService;

  Future<void> _fetchBookService() async {
    var result =
        await ServiceService.getBookService(widget.bookId!, "", 10, 0, "sort");
    setState(() {
      bookService = result;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.bookId != null) _fetchBookService();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 266,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: (bookService?.services?.length ?? 0) > 5
                ? 5
                : bookService?.services?.length,
            itemBuilder: (BuildContext context, int index) {
              var service = bookService?.services?[index];
              return Container(
                width: 300,
                margin: const EdgeInsets.fromLTRB(2, 10, 25, 10),
                padding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 18,
                ),
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
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.bottomToTop,
                        duration: const Duration(milliseconds: 300),
                        child: ServiceScreen(
                          serviceId: service?.id ?? '',
                          closeIcon: Icons.close,
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5,
                                        vertical: 10,
                                      ),
                                      child: Image.network(
                                        service?.imageUrl ??
                                            'https://via.placeholder.com/150',
                                        width: 160,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Container(
                                    width: 100,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        fontWeight: FontWeight.w300),
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
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        if (bookService != null && bookService!.services!.length > 0)
          Column(
            children: [
              const SizedBox(height: 10),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: ServiceRelateToBookScreen(
                          bookId: widget.bookId,
                        ),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.transparent),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 10,
                    ),
                    backgroundColor: ColorHelper.getColor(ColorHelper.green),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: SizedBox(
                    width: 200,
                    child: Center(
                      child: Text(
                        'View all services',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          )
      ],
    );
  }
}
