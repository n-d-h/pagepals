import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/book_models/book_model.dart';
import 'package:pagepals/screens/screens_customer/profile_screen/profile_widgets/service_collection.dart';
import 'package:shimmer/shimmer.dart';

class ProfileBookCollection extends StatefulWidget {
  final List<Books> books;

  const ProfileBookCollection({super.key, required this.books});

  @override
  State<ProfileBookCollection> createState() => _ProfileBookCollectionState();
}

class _ProfileBookCollectionState extends State<ProfileBookCollection> {
  List<Services> listServices = [];
  int currentBookIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.books.isNotEmpty && widget.books.first.book?.id != '') {
      listServices = widget.books.first.services!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.books.first.services!.length > 0 ? 460 : 230,
      decoration: const BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.fromLTRB(25, 1, 0, 0),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Book Collection',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See All',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: ColorHelper.getColor(ColorHelper.green),
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
          ),
          if (widget.books.isEmpty)
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      // Adjust the right margin as needed
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: const SizedBox(
                        height: 150,
                        width: 100,
                      ),
                    ),
                  );
                },
              ),
            )
          else if (widget.books.isNotEmpty && widget.books.first.book?.id != '')
            Column(
              children: [
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        widget.books.length > 5 ? 5 : widget.books.length,
                    itemBuilder: (BuildContext context, int index) {
                      final bookItem = widget.books[index];
                      return InkWell(
                        onTap: () {
                          setState(() {
                            listServices = bookItem.services!;
                            currentBookIndex = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 23),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: currentBookIndex == index && listServices.isNotEmpty
                                  ? ColorHelper.getColor(ColorHelper.green)
                                  : Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: SizedBox(
                                height: 150,
                                width: 100,
                                child: Image(
                                  image: NetworkImage(bookItem
                                          .book?.thumbnailUrl ??
                                      'https://marketplace.canva.com/EAFaQMYuZbo/1/0/1003w/canva-brown-rusty-mystery-novel-book-cover-hG1QhA7BiBU.jpg'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: listServices.isNotEmpty,
                  child: ProfileServiceCollection(services: listServices),
                ),
              ],
            )
          else
            Container(
              height: 150,
              margin: const EdgeInsets.only(right: 25),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/no_book.png',
                      height: 125,
                      width: 170,
                    ),
                    // const SizedBox(height: 5),
                    Text(
                      'Reader is still building their collection',
                      style: TextStyle(
                        overflow: TextOverflow.clip,
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
