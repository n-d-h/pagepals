import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pagepals/models/google_book.dart';

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
        setState(() {
          widget.onTap!(widget.book);
        });
        Navigator.pop(context);
      },
      child: Container(
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 3),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
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
            // const SizedBox(height: 10),
            // Padding(
            //   padding: const EdgeInsets.all(15),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Container(
            //         width: MediaQuery.of(context).size.width * 0.4,
            //         height: 40,
            //         decoration: BoxDecoration(
            //           color: Colors.blue,
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //         child: InkWell(
            //           onTap: () {},
            //           child: const Center(
            //             child: Text(
            //               'Edit',
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 16,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Container(
            //         width: MediaQuery.of(context).size.width * 0.4,
            //         height: 40,
            //         decoration: BoxDecoration(
            //           color: Colors.red,
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //         child: InkWell(
            //           onTap: () {},
            //           child: const Center(
            //             child: Text(
            //               'Delete',
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 16,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
