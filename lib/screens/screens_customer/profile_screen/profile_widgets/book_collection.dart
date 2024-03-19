import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/book_model.dart';
import 'package:shimmer/shimmer.dart';

class ProfileBookCollection extends StatelessWidget {
  final List<Book> books;

  const ProfileBookCollection({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      decoration: const BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.fromLTRB(25, 1, 25, 10),
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'My book collection',
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
          if (books.isEmpty)
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
          else
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: books.length,
                itemBuilder: (BuildContext context, int index) {
                  final book = books[index];
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(right: 23),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          height: 150,
                          width: 100,
                          child: Image(
                            image: NetworkImage(book.thumbnailUrl ??
                                'https://marketplace.canva.com/EAFaQMYuZbo/1/0/1003w/canva-brown-rusty-mystery-novel-book-cover-hG1QhA7BiBU.jpg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
