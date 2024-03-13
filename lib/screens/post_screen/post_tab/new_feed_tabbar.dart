import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/screens/post_screen/post_item.dart';
import 'package:pagepals/screens/post_screen/post_status_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:unicons/unicons.dart';

class NewFeedTabbar extends StatefulWidget {
  const NewFeedTabbar({super.key});

  @override
  State<NewFeedTabbar> createState() => _NewFeedTabbarState();
}

class _NewFeedTabbarState extends State<NewFeedTabbar> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialIndicator(
      displacement: 20,
      onRefresh: () {
        return Future<void>.delayed(const Duration(seconds: 1));
      },
      indicatorBuilder: (BuildContext context, IndicatorController controller) {
        return const Icon(
          UniconsLine.book_open,
          color: Colors.blueAccent,
          size: 30,
          semanticLabel: 'Pull to refresh',
        );
      },
      child: SingleChildScrollView(
        controller: ScrollController(),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 0, 0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('assets/image_reader.png'),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Navigator.of(context).push(
                          PageTransition(
                            child: const PostStatusScreen(),
                            type: PageTransitionType.fade,
                            duration: const Duration(milliseconds: 300),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(9),
                        child: Text(
                          AppLocalizations.of(context)!.appWhatAreYouThinking,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  PostItem(
                    username: 'John Doe',
                    timeAgo: '2 ${AppLocalizations.of(context)!.appHoursAgo}',
                    postText:
                    'This is a post text sdklfjhskdjhffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffsdklfjhgsdlgdgggggggggggdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgd',
                    imageUrl:
                    'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg',
                  ),
                  PostItem(
                    username: 'John Doe',
                    timeAgo: '2 ${AppLocalizations.of(context)!.appHoursAgo}',
                    postText: 'This is a post text',
                    imageUrl:
                    'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg',
                  ),
                  PostItem(
                    username: 'John Doe',
                    timeAgo: '2 ${AppLocalizations.of(context)!.appHoursAgo}',
                    postText: 'This is a post text',
                    imageUrl:
                    'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg',
                  ),
                  PostItem(
                    username: 'John Doe',
                    timeAgo: '2 ${AppLocalizations.of(context)!.appHoursAgo}',
                    postText: 'This is a post text',
                    imageUrl:
                    'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg',
                  ),
                  PostItem(
                    username: 'John Doe',
                    timeAgo: '2 ${AppLocalizations.of(context)!.appHoursAgo}',
                    postText: 'This is a post text',
                    imageUrl:
                    'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 75,
            )
          ],
        ),
      ),
    );
  }
}
