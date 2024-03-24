import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/screens/screens_reader/reader_widgets/service_widget.dart';
import 'package:unicons/unicons.dart';

class MyProductScreen extends StatefulWidget {
  const MyProductScreen({super.key});

  @override
  State<MyProductScreen> createState() => _MyProductScreenState();
}

class _MyProductScreenState extends State<MyProductScreen> {
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('My Product'),
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
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              controller: ScrollController(),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 80),
                  ServiceWidget(),
                  ServiceWidget(),
                  ServiceWidget(),
                  ServiceWidget(),
                  ServiceWidget(),
                  ServiceWidget(),
                ],
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
                          dimension: 25,
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
                              size: 12,
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
