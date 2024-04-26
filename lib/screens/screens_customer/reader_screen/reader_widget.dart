import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/reader_models/search_reader_model.dart';

class ReaderWidget extends StatefulWidget {
  final Function() onTap;
  final Reader reader;

  // String? teacherImage;
  // String? teacherName;
  // String? voiceDescription;
  // int? rating;
  // String? language;
  const ReaderWidget({
    super.key,
    required this.onTap,
    required this.reader,
  });

  @override
  State<ReaderWidget> createState() => _ReaderWidgetState();
}

class _ReaderWidgetState extends State<ReaderWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 45,
              backgroundImage: NetworkImage(
                widget.reader.avatarUrl ??
                    'https://th.bing.com/th/id/OIP.JBpgUJhTt8cI2V05-Uf53AHaG1?rs=1&pid=ImgDetMain',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.reader.nickname ?? 'John Doe',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Genre: ',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.reader.genre ?? 'Clear and engaging voice',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        'Language: ',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.reader.language ?? 'English, Vietnamese',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Rating:',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 3),
                      for (int i = 0; i < (widget.reader.rating ?? 0); i++)
                        Icon(
                          Icons.star_rounded,
                          color: ColorHelper.getColor('#FFA800'),
                          size: 20,
                        ),
                      for (int i = (widget.reader.rating ?? 0); i < 5; i++)
                        Icon(
                          Icons.star_outline_rounded,
                          color: ColorHelper.getColor('#FFA800'),
                          size: 20,
                        ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
