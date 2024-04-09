import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pagepals/screens/screens_customer/post_screen/seminar_widgets/seminar_post_item.dart';

class SeminarTabbar extends StatefulWidget {
  const SeminarTabbar({super.key});

  @override
  State<SeminarTabbar> createState() => _SeminarTabbarState();
}

class _SeminarTabbarState extends State<SeminarTabbar> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: const Column(
          children: [
            SeminarPostItem(
              hostName: 'Van Minh',
              seminarTitle: 'Phủ định của phủ định',
              date: 'Feb 23, 2024',
              time: '10:00 AM',
              description: 'This is the seminar post test '
                  'des udjfhsj kdfhjksdh fjkshfkj shfjkshf '
                  'kjdshfj dhfjsdhf jksdhf kjsdh kjsdhfkj sdhfjksd '
                  'hfjksh dsfsd sdfs sdfsd sdfsd sdfdsfs sdfsd sfsdf '
                  'sdfsd sdf sdfs sdfsd sfsfd sdfsd sfsdf sfsdf sfsdf ',
              hostAvatarUrl:
              'https://th.bing.com/th/id/OIP.JBpgUJhTt8cI2V05-Uf53AHaG1?rs=1&pid=ImgDetMain',
              bannerImageUrl:
              'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg',
            ),
            SeminarPostItem(
              hostName: 'Duc Huy',
              seminarTitle: 'Cuộc sống của người lao động',
              date: 'Mar 23, 2024',
              time: '20:00 AM',
              description: 'This is the seminar post test '
                  'des udjfhsj kdfhjksdh fjkshfkj shfjkshf '
                  'kjdshfj dhfjsdhf jksdhf kjsdh kjsdhfkj sdhfjksd '
                  'hfjksh dsfsd sdfs sdfsd sdfsd sdfdsfs sdfsd sfsdf '
                  'sdfsd sdf sdfs sdfsd sfsfd sdfsd sfsdf sfsdf sfsdf ',
              hostAvatarUrl:
              'https://th.bing.com/th/id/OIP.JBpgUJhTt8cI2V05-Uf53AHaG1?rs=1&pid=ImgDetMain',
              bannerImageUrl:
              'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg',
            ),
            SeminarPostItem(
              hostName: 'Duc Hoang',
              seminarTitle: 'Bảo vệ môi trường',
              date: 'Feb 23, 2024',
              time: '10:00 AM',
              description: 'This is the seminar post test '
                  'des udjfhsj kdfhjksdh fjkshfkj shfjkshf '
                  'kjdshfj dhfjsdhf jksdhf kjsdh kjsdhfkj sdhfjksd '
                  'hfjksh dsfsd sdfs sdfsd sdfsd sdfdsfs sdfsd sfsdf '
                  'sdfsd sdf sdfs sdfsd sfsfd sdfsd sfsdf sfsdf sfsdf ',
              hostAvatarUrl:
                  'https://th.bing.com/th/id/OIP.JBpgUJhTt8cI2V05-Uf53AHaG1?rs=1&pid=ImgDetMain',
              bannerImageUrl:
              'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg',
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
