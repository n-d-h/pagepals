import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/service_model.dart';
import 'package:pagepals/screens/screens_reader/reader_widgets/service_widget.dart';
import 'package:pagepals/services/service_service.dart';
import 'package:unicons/unicons.dart';

class MyServiceScreen extends StatefulWidget {
  MyServiceScreen({super.key, this.readerId});

  String? readerId;

  @override
  State<MyServiceScreen> createState() => _MyServiceScreenState();
}

class _MyServiceScreenState extends State<MyServiceScreen> {
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  Future<List<ServiceModel>> getListServiceByReader() {
    return ServiceService.getListServiceByReader(widget.readerId!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('My Services'),
          elevation: 0,
          surfaceTintColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 80),
              child: FutureBuilder(
                future: getListServiceByReader(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.green,
                        size: 60,
                      ),
                    );
                  } else {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      List<ServiceModel> services =
                          snapshot.data as List<ServiceModel>;
                      return ListView.builder(
                        itemCount: services.length,
                        itemBuilder: (context, index) {
                          return ServiceWidget(
                            imageUrl: services[index].book!.smallThumbnailUrl,
                            serviceName: services[index].book!.title,
                            serviceDescription:
                                services[index].book!.description,
                            price: services[index].price,
                            rating: services[index].rating.toString(),
                            totalOfRating:
                                services[index].totalOfReview.toString(),
                          );
                        },
                      );
                    }
                  }
                },
              ),
            ),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: SearchBar(
                      autoFocus: true,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            isSearching = true;
                          });
                        } else {
                          setState(() {
                            isSearching = false;
                          });
                        }
                      },
                      onSubmitted: (value) {
                        print('Submit Searching for: $value');
                      },
                      controller: searchController,
                      trailing: [
                        SizedBox.square(
                          dimension: 26,
                          child: IconButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.grey.shade400,
                              ),
                            ),
                            icon: Icon(
                              isSearching
                                  ? UniconsLine.multiply
                                  : UniconsLine.search,
                              size: 11,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                if (isSearching) {
                                  // Clear the search text
                                  searchController.clear();
                                  // Stop searching
                                  isSearching = false;
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
                      hintText: 'Search for products...',
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
      ),
    );
  }
}
