import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/service_models/book_service_model.dart';
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
    return bookService == null
        ? Scaffold(
            body: Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: ColorHelper.getColor(ColorHelper.green),
                size: 60,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Service'),
              centerTitle: true,
              surfaceTintColor: Colors.white,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: bookService?.services?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                var service = bookService?.services?[index];
                return Container(
                  width: 300,
                  height: 200,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 15,
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
                    onTap: () {},
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                          left: 16,
                                          right: 8,
                                        ),
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                service?.reader?.avatarUrl ??
                                                    'https://via.placeholder.com/150',
                                              ),
                                              fit: BoxFit.fill),
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
                                    horizontal: 16, vertical: 3),
                                child: Text(
                                  service?.description ??
                                      'Service description',
                                  textAlign: TextAlign.start,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    // wordSpacing: 1,
                                    height: 2.2,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              )
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
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
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
          );
  }
}
