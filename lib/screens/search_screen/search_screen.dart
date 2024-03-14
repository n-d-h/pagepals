import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/screens/search_screen/book_tab_screen.dart';
import 'package:pagepals/screens/search_screen/reader_tab_screen.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  late bool isSearching;
  late int tabIndex; // Track the current tab index

  @override
  void initState() {
    super.initState();
    isSearching = false;
    tabIndex = 0; // Initialize with the first tab index
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: DefaultTabController(
            initialIndex: 0,
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: true,
                centerTitle: true,
                toolbarHeight: 65,
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                titleSpacing: 0,
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Theme(
                        data: ThemeData(
                          splashFactory: NoSplash.splashFactory,
                        ),
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
                            print('Searching for: $value');
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
                                  padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(0),
                                  ),
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
                            maxWidth: 270,
                            minHeight: 50,
                            minWidth: 270,
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(14)),
                              side: BorderSide(
                                color: ColorHelper.getColor(ColorHelper.green),
                                width: 2,
                              ),
                            ),
                          ),
                          surfaceTintColor:
                              MaterialStateProperty.all(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shadowColor: MaterialStateProperty.all(
                              Colors.grey.withOpacity(0)),
                          textStyle: MaterialStateProperty.all(
                            const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          hintText: tabIndex == 1
                              ? AppLocalizations.of(context)!.appSearchForBook
                              : AppLocalizations.of(context)!.appSearchForReader,
                          hintStyle: MaterialStateProperty.all(
                            const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
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
                      const SizedBox(width: 10),
                    ],
                  ),
                bottom: TabBar(
                  onTap: (index) {
                    setState(() {
                      tabIndex =
                          index; // Update the tab index when a tab is selected
                    });
                  },
                  splashFactory: NoSplash.splashFactory,
                  indicatorColor: ColorHelper.getColor(ColorHelper.green),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: ColorHelper.getColor(ColorHelper.green),
                  labelStyle: GoogleFonts.lexend(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  unselectedLabelColor: Colors.grey.shade400,
                  tabs: [
                    Tab(text: AppLocalizations.of(context)!.appReaders),
                    Tab(text: AppLocalizations.of(context)!.appBooks),
                  ],
                ),
              ),
              body: const TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ReaderTabScreen(),
                  BookTabScreen(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
