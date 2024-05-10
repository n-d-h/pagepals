import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/models/book_models/book_model.dart';
import 'package:pagepals/screens/screens_customer/service_screen/service_screen.dart';

class ProfileServiceCollection extends StatefulWidget {
  const ProfileServiceCollection({
    super.key,
    required this.services,
  });

  final List<Services> services;

  @override
  State<ProfileServiceCollection> createState() =>
      _ProfileServiceCollectionState();
}

class _ProfileServiceCollectionState extends State<ProfileServiceCollection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      decoration: const BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.fromLTRB(0, 1, 0, 10),
      margin: const EdgeInsets.only(bottom: 20, top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Service Collection',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 150,
            margin: const EdgeInsets.only(top: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.services.length > 5 ? 5 : widget.services
                  .length,
              itemBuilder: (BuildContext context, int index) {
                final serviceItem = widget.services[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          child: ServiceScreen(
                            serviceId: serviceItem.id ?? '',
                            closeIcon: Icons.close,
                          ),
                          type: PageTransitionType.bottomToTop,
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 23),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      border: Border.all(
                        color: Colors.grey[400]!,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            image: DecorationImage(
                              image: NetworkImage(serviceItem.imageUrl ??
                                  'https://marketplace.canva.com/EAFaQMYuZbo/1/0/1003w/canva-brown-rusty-mystery-novel-book-cover-hG1QhA7BiBU.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: 120,
                          height: 150,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                serviceItem.serviceType?.name ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${serviceItem.duration} mins',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    '${serviceItem.price} pals',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
