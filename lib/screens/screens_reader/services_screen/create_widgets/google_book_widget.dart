import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/models/google_book.dart';
import 'package:pagepals/screens/screens_customer/book_screen/google_book_detail.dart';

class GoogleBookWidget extends StatefulWidget {
  final Function(GoogleBookModel?)? onTap;
  final GoogleBookModel book;

  const GoogleBookWidget({super.key, required this.book, this.onTap});

  @override
  State<GoogleBookWidget> createState() => _GoogleBookWidgetState();
}

class _GoogleBookWidgetState extends State<GoogleBookWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // setState(() {
        //   widget.onTap!(widget.book);
        // });
        // Navigator.pop(context);

        Navigator.of(context).push(
          PageTransition(
            child: GoogleBookDetailScreen(book: widget.book, onTap: widget.onTap,),
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 300),
          ),
        );
      },
      child: Container(
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 3),
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                      widget.book.volumeInfo?.imageLinks?.thumbnail ??
                          "https://via.placeholder.com/150"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.book.volumeInfo!.title!,
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
