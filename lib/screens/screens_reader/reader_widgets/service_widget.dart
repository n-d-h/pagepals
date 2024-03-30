import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/screens/screens_reader/services_screen/update_service.dart';
import 'package:pagepals/services/service_service.dart';
import 'package:quickalert/quickalert.dart';

class ServiceWidget extends StatefulWidget {
  final String? id;
  final String? readerId;
  final String? imageUrl;
  final String? book;
  final double? duration;
  final String createdAt;
  final String? serviceType;
  final String? serviceName;
  final String? bookDescription;
  final int? price;
  final String? rating;
  final String? totalOfRating;
  final Function(bool?)? onDeleted;

  const ServiceWidget({
    super.key,
    this.id,
    this.readerId,
    this.imageUrl,
    this.book,
    this.duration,
    required this.createdAt,
    this.serviceType,
    this.serviceName,
    this.bookDescription,
    this.price,
    this.rating,
    this.totalOfRating, this.onDeleted,
  });

  @override
  State<ServiceWidget> createState() => _ServiceWidgetState();
}

class _ServiceWidgetState extends State<ServiceWidget> {
  @override
  Widget build(BuildContext context) {
    DateTime startTime = DateTime.parse(widget.createdAt);
    String date = DateFormat('dd/MM/yyyy').format(startTime);
    String time = DateFormat('HH:mm').format(startTime);
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(widget.imageUrl!),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.serviceName!,
                      style: const TextStyle(
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Duration: ${widget.duration.toString()} hours',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      widget.book!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'Price: \$${widget.price.toString()}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      'Created at: $date $time',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageTransition(
                        child: UpdateServiceScreen(
                          serviceId: widget.id!,
                          bookTitle: widget.book!,
                          serviceType: widget.serviceType!,
                          serviceName: widget.serviceName!,
                          price: widget.price!.toString(),
                          readerId: widget.readerId!,
                        ),
                        type: PageTransitionType.rightToLeft,
                        duration: const Duration(milliseconds: 300),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: const BorderSide(color: Colors.grey),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.4, 40),
                  ),
                  child: const Center(
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    // Save the context in a variable
                    BuildContext dialogContext = context;
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Delete Service'),
                          content: const Text(
                              'Are you sure you want to delete this service?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(dialogContext)
                                    .pop(); // Use the saved context
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.of(dialogContext)
                                    .pop(); // Use the saved context
                                // Show loading
                                showDialog(
                                  context: dialogContext,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return Center(
                                      child: LoadingAnimationWidget
                                          .staggeredDotsWave(
                                        color: Colors.greenAccent,
                                        size: 60,
                                      ),
                                    );
                                  },
                                );
                                bool deleted =
                                    await ServiceService.deleteService(
                                        widget.id!);
                                Future.delayed(
                                    const Duration(milliseconds: 300), () {
                                  Navigator.of(dialogContext)
                                      .pop(); // Use the saved context
                                  if (deleted) {
                                    QuickAlert.show(
                                      context: dialogContext,
                                      type: QuickAlertType.success,
                                      title: 'Service Deleted',
                                      text:
                                          'Service has been deleted successfully',
                                    );
                                    widget.onDeleted!(true);
                                  } else {
                                    QuickAlert.show(
                                      context: dialogContext,
                                      type: QuickAlertType.error,
                                      title: 'Delete Failed',
                                      text:
                                          'Failed to delete service. Please try again.',
                                    );
                                  }
                                });
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: const BorderSide(color: Colors.grey),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.4, 40),
                  ),
                  child: const Center(
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
