import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookDescription extends StatefulWidget {
  final String? description;

  const BookDescription({super.key, this.description});

  @override
  State<BookDescription> createState() => _BookDescriptionState();
}

class _BookDescriptionState extends State<BookDescription> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text(
            widget.description ?? 'Book description',
            maxLines: isExpanded ? null : 5,
            overflow: isExpanded ? TextOverflow.clip : TextOverflow.ellipsis,
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 5),
        if(widget.description != null && widget.description!.length > 150)
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(
              isExpanded ? 'Read less' : 'Read more',
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
