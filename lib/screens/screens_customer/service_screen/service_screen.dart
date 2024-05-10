import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/models/service_models/service_model.dart';
import 'package:pagepals/screens/screens_customer/profile_screen/profile_widgets/info_line.dart';
import 'package:pagepals/screens/screens_customer/service_screen/show_html_widget.dart';
import 'package:pagepals/services/service_service.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({
    super.key,
    required this.serviceId,
    required this.closeIcon,
  });

  final String serviceId;
  final IconData closeIcon;

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  ServiceModel? serviceModel;
  bool isShowMore = false;

  @override
  void initState() {
    super.initState();
    getServiceById(widget.serviceId);
  }

  getServiceById(String id) async {
    var result = await ServiceService.getServiceById(id);
    setState(() {
      serviceModel = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (serviceModel == null) {
      return Scaffold(
        body: Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: ColorHelper.getColor(ColorHelper.green),
            size: 60,
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Service Detail'),
          surfaceTintColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(widget.closeIcon),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          controller: ScrollController(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                child: Image.network(
                  serviceModel?.imageUrl ?? '',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.grey[200]!),
                child: ProfileInfoLine(
                  reader: ReaderProfile(
                    profile: Profile(
                      id: serviceModel?.reader?.id ?? '',
                      avatarUrl: serviceModel?.reader?.avatarUrl ?? '',
                      nickname: serviceModel?.reader?.nickname ?? '',
                      countryAccent: serviceModel?.reader?.countryAccent ?? '',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  serviceModel?.serviceType?.name ?? '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: ColorHelper.getColor(ColorHelper.green),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            const Text(
                              'Price',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '${serviceModel?.price ?? ''} pals',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: ColorHelper.getColor(ColorHelper.green),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            const Text(
                              'Duration',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '${serviceModel?.duration ?? ''} mins',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Description',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ShowMoreHtmlWidget(
                htmlContent: serviceModel?.description ?? '',
                maxLines: 3,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: ColorHelper.getColor(ColorHelper.green),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Book Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
