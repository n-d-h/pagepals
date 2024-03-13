import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/reader_models/popular_reader_model.dart';
import 'package:pagepals/screens/reader_screen/reader_profile/reader_profile.dart';
import 'package:pagepals/screens/reader_screen/reader_widget.dart';
import 'package:pagepals/screens/search_screen/book_tab_screen.dart';
import 'package:pagepals/screens/search_screen/reader_tab_screen.dart';
import 'package:pagepals/services/reader_service.dart';
import 'package:unicons/unicons.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    Future<List<PopularReader>> getActiveReader() {
      return ReaderService.getListActiveReader();
    }

    return SafeArea(
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            toolbarHeight: 65,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            flexibleSpace: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      SearchBar(
                        onChanged: (value) {
                          print('Searching for: $value');
                        },
                        onSubmitted: (value) {
                          print('Submit Searching for: $value');
                        },
                        controller: searchController,
                        leading: IconButton(
                          icon: const Icon(UniconsLine.search),
                          onPressed: () {
                            print('Searching for: ${searchController.text}');
                          },
                        ),
                        trailing: [
                          IconButton(
                            icon: const Icon(UniconsLine.multiply),
                            onPressed: () {
                              searchController.clear();
                            },
                          ),
                        ],
                        constraints: const BoxConstraints(
                          maxHeight: 50,
                          maxWidth: 310,
                        ),
                        shadowColor:
                            MaterialStateProperty.all(Colors.grey.withOpacity(0)),
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        hintText: 'Search for a reader',
                      ),
                      const SizedBox(width: 15),
                      InkWell(
                        onTap: () {
                          print('Filter button pressed');
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Icon(UniconsLine.filter),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            bottom: TabBar(
              splashFactory: NoSplash.splashFactory,
              indicatorColor: ColorHelper.getColor(ColorHelper.green),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: ColorHelper.getColor(ColorHelper.green),
              labelStyle: GoogleFonts.lexend(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              unselectedLabelColor: Colors.grey.shade400,
              tabs: const [
                Tab(text: 'Readers'),
                Tab(text: 'Books'),
              ],
            ),
          ),

          body: const TabBarView(
            children: [
              ReaderTabScreen(),
              BookTabScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
