import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/models/service_model.dart';
import 'package:pagepals/screens/screens_reader/reader_main_screen/reader_main_screen.dart';
import 'package:pagepals/screens/screens_reader/reader_widgets/service_widget.dart';
import 'package:pagepals/screens/screens_reader/services_screen/create_service.dart';
import 'package:pagepals/services/service_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

class MyServiceScreen extends StatefulWidget {
  final String? readerId;

  const MyServiceScreen({super.key, this.readerId});

  @override
  State<MyServiceScreen> createState() => _MyServiceScreenState();
}

class _MyServiceScreenState extends State<MyServiceScreen> {
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  int limit = 10;
  String search = "";
  int currentPage = 0;
  List<ServiceModel> services = [];
  bool isLoadingNextPage = false;
  bool hasMorePages = true;

  final ScrollController _scrollController = ScrollController();

  Timer? _debounce;

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchNextPage();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_scrollListener);
    _fetchServices();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<List<ServiceModel>> getListServiceByReader(
      int page, int limit, String search) {
    return ServiceService.getListServiceByReader(
        widget.readerId!, page, limit, search);
  }

  Future<void> _fetchServices() async {
    try {
      List<ServiceModel> result = await ServiceService.getListServiceByReader(
          widget.readerId!, currentPage, limit, search);
      setState(() {
        services.addAll(result);
        currentPage++;
        if (result.isEmpty) {
          hasMorePages = false;
        }
      });
    } catch (error) {
      print("Error fetching books: $error");
    }
  }

  Future<void> _fetchNextPage() async {
    if (!isLoadingNextPage && hasMorePages) {
      setState(() {
        isLoadingNextPage = true;
      });
      try {
        List<ServiceModel> result =
            await await ServiceService.getListServiceByReader(
                widget.readerId!, currentPage, limit, search);
        if (result.isEmpty) {
          setState(() {
            hasMorePages = false;
            isLoadingNextPage = false;
          });
        } else {
          setState(() {
            // Filter out duplicates before adding them to services
            final filteredResult = result.where((service) => !services
                .any((existingService) => existingService.id == service.id));
            services.addAll(filteredResult);

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
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('My Services'),
        elevation: 0,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String account = prefs.getString('account')!;
            AccountModel accountModel =
                AccountModel.fromJson(json.decoder.convert(account));
            // Navigator.pop(context);
            Future.delayed(const Duration(milliseconds: 300), () {
              Navigator.of(context).push(
                PageTransition(
                  type: PageTransitionType.leftToRight,
                  child: ReaderMainScreen(accountModel: accountModel),
                ),
              );
            });
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(UniconsLine.plus_circle),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: CreateService(
                    readerId: widget.readerId!,
                    onCreated: (value) {
                      if (value != null && value) {
                        setState(() {
                          services.clear();
                          currentPage = 0;
                          hasMorePages = true;
                          _fetchServices();
                        });
                      }
                    },
                  ),
                  duration: const Duration(milliseconds: 300),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
              margin: const EdgeInsets.only(top: 80),
              child: services.isEmpty
                  ? Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: ColorHelper.getColor(ColorHelper.green),
                        size: 60,
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: services.length + (isLoadingNextPage ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == services.length) {
                          // Show loading indicator at the bottom
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: LoadingAnimationWidget.prograssiveDots(
                                color: ColorHelper.getColor(ColorHelper.green),
                                size: 50,
                              ),
                            ),
                          );
                        } else {
                          return ServiceWidget(
                            id: services[index].id,
                            readerId: widget.readerId!,
                            imageUrl: services[index].book!.smallThumbnailUrl,
                            book: services[index].book!.title,
                            duration: services[index].duration,
                            createdAt: services[index].createdAt!,
                            serviceType: services[index].serviceType!.id,
                            serviceName: services[index].description,
                            bookDescription: services[index].book!.description,
                            price: services[index].price,
                            rating: services[index].rating.toString(),
                            totalOfRating:
                                services[index].totalOfReview.toString(),
                            onDeleted: (value) {
                              if (value != null && value) {
                                setState(() {
                                  services.clear();
                                  currentPage = 0;
                                  hasMorePages = true;
                                  _fetchServices();
                                });
                              }
                            },
                          );
                        }
                      },
                    )),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              child: Theme(
                data: ThemeData(
                  splashFactory: NoSplash.splashFactory,
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: SearchBar(
                    autoFocus: true,
                    onChanged: (value) {
                      print('Searching for: $value');
                      if (value.isNotEmpty) {
                        setState(() {
                          services.clear();
                          currentPage = 0;
                          hasMorePages = true;
                          isSearching = true;
                        });
                        if (_debounce?.isActive ?? false) _debounce?.cancel();
                        _debounce =
                            Timer(const Duration(milliseconds: 300), () {
                          setState(() {
                            // do something with query
                            search = value;
                          });
                          _fetchServices();
                        });
                      } else {
                        setState(() {
                          isSearching = false;
                          search = "";
                        });
                      }
                    },
                    // onSubmitted: (value) {
                    //   print('Submit Searching for: $value');
                    // },
                    controller: searchController,
                    trailing: [
                      SizedBox.square(
                        dimension: 25,
                        child: IconButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.grey.shade400,
                            ),
                            iconSize: MaterialStateProperty.all(12),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.all(0),
                            ),
                          ),
                          icon: Icon(
                            isSearching
                                ? UniconsLine.multiply
                                : UniconsLine.search,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              if (isSearching) {
                                // Clear the search text
                                searchController.clear();
                                // Stop searching
                                isSearching = false;
                                currentPage = 0;
                                hasMorePages = true;
                                services.clear();
                                search = "";
                                _fetchServices();
                              } else {
                                // Start searching
                                isSearching = true;
                              }
                            });
                          },
                        ),
                      ),
                    ],
                    constraints: const BoxConstraints(
                      maxHeight: 50,
                      minHeight: 50,
                      minWidth: 100,
                      maxWidth: 100,
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(14),
                        ),
                        side: BorderSide(
                          color: ColorHelper.getColor(ColorHelper.green),
                          width: 2,
                        ),
                      ),
                    ),
                    surfaceTintColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shadowColor:
                        MaterialStateProperty.all(Colors.grey.withOpacity(0)),
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    hintText: 'Search by book title...',
                    hintStyle: MaterialStateProperty.all(
                      const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
