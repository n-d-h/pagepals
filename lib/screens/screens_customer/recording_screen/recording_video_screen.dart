import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecordingVideoScreen extends StatefulWidget {
  const RecordingVideoScreen({
    super.key,
    required this.recordingUrl,
    required this.recordingId,
    required this.startTime,
  });

  final String recordingUrl;
  final int recordingId;
  final String startTime;

  @override
  State<RecordingVideoScreen> createState() => _RecordingVideoScreenState();
}

class _RecordingVideoScreenState extends State<RecordingVideoScreen> {
  WebViewController? controller;
  double _progress = 0.0;
  bool isLoaded = true;

  @override
  void initState() {
    super.initState();
    if (widget.recordingUrl.isEmpty) {
      controller = WebViewController();
    } else {
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(Colors.white)
        ..enableZoom(false)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              setState(() {
                _progress = progress / 100;
                if (progress == 100) {
                  setState(() {
                    isLoaded = false;
                  });
                }
              });
            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) {},
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(widget.recordingUrl));
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller?.clearCache();
  }

  @override
  Widget build(BuildContext context) {
    print('Recording URL: ${widget.recordingUrl}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Recording Screen'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              setState(() {
                isLoaded = true;
                _progress = 0.0;
              });
              await controller?.reload();
            },
          ),
        ],
      ),
      body: widget.recordingUrl.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.access_alarms_rounded,
                    size: 200,
                  ),
                  Text(
                    'Recording Processing',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ],
              ),
            )
          : (_progress < 1 && isLoaded)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isLoaded
                        ? LinearProgressIndicator(
                            value: _progress,
                            color: ColorHelper.getColor(ColorHelper.green),
                          )
                        : LinearProgressIndicator(
                            value: 1,
                            color: ColorHelper.getColor(ColorHelper.green),
                          ),
                    Container(
                      width: double.infinity,
                      height: 400,
                      margin: const EdgeInsets.only(top: 50),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 300,
                          height: 160,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      child: WebViewWidget(
                        controller: controller ?? WebViewController(),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Recording ${widget.recordingId}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              widget.startTime,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
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
