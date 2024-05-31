import 'package:flutter/material.dart';

class BookImage extends StatelessWidget {
  final String? url;

  const BookImage({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    // modify the thumbnailUrl to have a zoom parameter of 2
    String thumbnailUrl = url ??
        'https://via.placeholder.com/150';
    Uri originalUri = Uri.parse(thumbnailUrl);
    Map<String, String> queryParams = Map.from(originalUri.queryParameters);
    queryParams['zoom'] = '1'; // Change the zoom parameter to 2
    Uri modifiedUri = originalUri.replace(queryParameters: queryParams);
    String modifiedUrl = modifiedUri.toString();

    return Container(
      height: 300,
      width: 200,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(modifiedUrl),
          fit: BoxFit.fill,
          filterQuality: FilterQuality.high,
          scale: 1,
        ),
      ),
    );
  }
}
