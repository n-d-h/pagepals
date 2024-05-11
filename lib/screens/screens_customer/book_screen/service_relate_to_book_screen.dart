import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/service_models/book_service_model.dart';
import 'package:pagepals/screens/screens_customer/service_screen/service_screen.dart';
import 'package:pagepals/screens/screens_customer/service_screen/service_widget.dart';
import 'package:pagepals/services/service_service.dart';

class ServiceRelateToBookScreen extends StatefulWidget {
  const ServiceRelateToBookScreen({super.key, this.bookId});

  final String? bookId;

  @override
  State<ServiceRelateToBookScreen> createState() =>
      _ServiceRelateToBookScreenState();
}

class _ServiceRelateToBookScreenState extends State<ServiceRelateToBookScreen> {
  BookServiceModel? bookService;
  int currentPage = 0;
  bool isLoadingNextPage = false;
  bool hasMorePages = true;
  List<BookServices> list = [];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    if (widget.bookId != null) _fetchBookService();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchNextPage();
    }
  }

  Future<void> _fetchBookService() async {
    var result = await ServiceService.getBookService(
        widget.bookId!, "", 10, currentPage, "desc");
    setState(() {
      bookService = result;
    });
  }

  Future<void> _fetchNextPage() async {
    if (!isLoadingNextPage && hasMorePages) {
      setState(() {
        isLoadingNextPage = true;
      });
      try {
        var result = await ServiceService.getBookService(
            widget.bookId!, "", 10, currentPage, "desc");
        if (result.services!.isEmpty) {
          setState(() {
            hasMorePages = false;
            isLoadingNextPage = false;
          });
        } else {
          setState(() {
            list.addAll(result.services!);
            currentPage++;
            isLoadingNextPage = false;
          });
        }
      } catch (error) {
        print("Error fetching next page: $error");
        setState(() {
          isLoadingNextPage = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (bookService == null) {
      return Scaffold(
        body: Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: ColorHelper.getColor(ColorHelper.green),
            size: 60,
          ),
        ),
      );
    } else if (bookService!.services!.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text(
            'No service found',
            style: TextStyle(
              color: ColorHelper.getColor(ColorHelper.grey),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Services'),
          centerTitle: true,
          surfaceTintColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
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
                ...bookService!.services!.map((serviceItem) {
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
                        service: serviceItem,
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
}
