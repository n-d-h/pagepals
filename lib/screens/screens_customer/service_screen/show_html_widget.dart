import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pagepals/helpers/color_helper.dart';

class ShowMoreHtmlWidget extends StatefulWidget {
  final String htmlContent;
  final int maxLines;

  ShowMoreHtmlWidget({
    required this.htmlContent,
    this.maxLines = 3,
  });

  @override
  _ShowMoreHtmlWidgetState createState() => _ShowMoreHtmlWidgetState();
}

class _ShowMoreHtmlWidgetState extends State<ShowMoreHtmlWidget> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    final String trimmedContent = getTrimmedHtmlContent();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpand = !isExpand;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: HtmlWidget(
              isExpand ? widget.htmlContent : trimmedContent,
              textStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis,
              ),
              onLoadingBuilder: (context, element, progress) {
                return LoadingAnimationWidget.staggeredDotsWave(
                  color: ColorHelper.getColor(ColorHelper.green),
                  size: 60,
                );
              },
              onErrorBuilder: (context, element, error) {
                return const Text('Error loading description');
              },
              renderMode: RenderMode.column,
            ),
          ),
        ),
        if (trimmedContent != widget.htmlContent)
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                radius: 10,
                onTap: () {
                  setState(() {
                    isExpand = !isExpand;
                  });
                },
                child: Text(
                  isExpand ? 'Read less' : 'Read more',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  String getTrimmedHtmlContent() {
    int count = 0;
    String trimmedContent = '';

    for (int i = 0; i < widget.htmlContent.length; i++) {
      if (widget.htmlContent[i] == '.') {
        count++;
        if (count == 1) {
          break;
        }
      } else {
        trimmedContent += widget.htmlContent[i];
      }
    }
    return '$trimmedContent...';
  }
}
