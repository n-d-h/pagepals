import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/service_models/book_service_model.dart';
import 'package:pagepals/screens/screens_customer/book_screen/service_relate_to_book_screen.dart';
import 'package:pagepals/screens/screens_customer/service_screen/service_list_screen.dart';
import 'package:pagepals/screens/screens_customer/service_screen/service_screen.dart';
import 'package:pagepals/screens/screens_customer/service_screen/service_widget.dart';
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
    return bookService == null || bookService?.services?.length == 0
        ? SizedBox(
            height: 266,
            child: Center(
              child: Text(
                'No service found',
                style: TextStyle(
                  color: ColorHelper.getColor(ColorHelper.grey),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        : Column(
            children: [
              SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: (bookService?.services?.length ?? 0) > 5
                      ? 5
                      : bookService?.services?.length,
                  itemBuilder: (BuildContext context, int index) {
                    var service = bookService?.services?[index];
                    return InkWell(
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
                      child: ServiceWidget(
                        service: service,
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
                                bookId: widget.bookId ?? '',
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
                          backgroundColor:
                              ColorHelper.getColor(ColorHelper.green),
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
