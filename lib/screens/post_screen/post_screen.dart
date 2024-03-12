import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/screens/post_screen/message_screen/message_screen.dart';
import 'package:pagepals/screens/post_screen/post_item.dart';
import 'package:pagepals/screens/post_screen/post_status_screen.dart';
import 'package:unicons/unicons.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              title: const Text(
                'PagePals and Friends',
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.2,
                ),
              ),
              automaticallyImplyLeading: false,
              centerTitle: false,
              floating: true,
              stretch: true,
              pinned: true,
              surfaceTintColor: Colors.white,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        PageTransition(
                          child: const MessageScreen(),
                          type: PageTransitionType.bottomToTop,
                          duration: const Duration(milliseconds: 500),
                        ),
                      );
                    },
                    splashRadius: 24,
                    icon: const Icon(
                      UniconsLine.comment_lines,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 24,
                          backgroundImage:
                              AssetImage('assets/image_reader.png'),
                        ),
                        const SizedBox(width: 20),
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
                                AppLocalizations.of(context)!
                                    .appWhatAreYouThinking,
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
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        PostItem(
                          username: 'John Doe',
                          timeAgo:
                              '2 ${AppLocalizations.of(context)!.appHoursAgo}',
                          postText:
                              'This is a post text sdklfjhskdjhffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffsdklfjhgsdlgdgggggggggggdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgdgd',
                          imageUrl:
                              'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg',
                        ),
                        PostItem(
                          username: 'John Doe',
                          timeAgo:
                              '2 ${AppLocalizations.of(context)!.appHoursAgo}',
                          postText: 'This is a post text',
                          imageUrl:
                              'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg',
                        ),
                        PostItem(
                          username: 'John Doe',
                          timeAgo:
                              '2 ${AppLocalizations.of(context)!.appHoursAgo}',
                          postText: 'This is a post text',
                          imageUrl:
                              'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg',
                        ),
                        PostItem(
                          username: 'John Doe',
                          timeAgo:
                              '2 ${AppLocalizations.of(context)!.appHoursAgo}',
                          postText: 'This is a post text',
                          imageUrl:
                              'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg',
                        ),
                        PostItem(
                          username: 'John Doe',
                          timeAgo:
                              '2 ${AppLocalizations.of(context)!.appHoursAgo}',
                          postText: 'This is a post text',
                          imageUrl:
                              'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg',
                        ),
                        const SizedBox(
                          height: 75,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
