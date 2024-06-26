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
  final String? serviceTypeId;
  final String? serviceType;
  final String? serviceName;
  final String? bookDescription;
  final int? price;
  final String? rating;
  final String? totalOfRating;
  final Function(bool?)? onUpdated;

  const ServiceWidget({
    super.key,
    this.id,
    this.readerId,
    this.imageUrl,
    this.book,
    this.duration,
    required this.createdAt,
    this.serviceTypeId,
    this.serviceType,
    this.serviceName,
    this.bookDescription,
    this.price,
    this.rating,
    this.totalOfRating,
    this.onUpdated,
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
                      'Duration: ${widget.duration.toString()} minutes',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'Book: ${widget.book!}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      'Price: ${widget.price.toString()} pals',
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
                  onPressed: () async {
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
                                    widget.onUpdated!(true);
                                  } else {
                                    showDialog(
                                        context: dialogContext,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Pending Booking found'),
                                            content: const Text(
                                                'You will still have to complete all the '
                                                'pending bookings after deleting this service.'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                style: TextButton.styleFrom(
                                                  foregroundColor: Colors.red,
                                                ),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Center(
                                                        child: LoadingAnimationWidget
                                                            .staggeredDotsWave(
                                                          color: Colors
                                                              .greenAccent,
                                                          size: 60,
                                                        ),
                                                      );
                                                    },
                                                  );
                                                  bool result = await ServiceService
                                                      .keepBookingAndDeleteService(
                                                          widget.id!);
                                                  if (result) {
                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 100),
                                                        () {
                                                      widget.onUpdated!(true);
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                      QuickAlert.show(
                                                        context: dialogContext,
                                                        type: QuickAlertType
                                                            .success,
                                                        title:
                                                            'Service Deleted',
                                                        text:
                                                            'Service has been deleted successfully',
                                                      );
                                                    });
                                                  } else {
                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 100),
                                                        () {
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                      QuickAlert.show(
                                                        context: dialogContext,
                                                        type: QuickAlertType
                                                            .error,
                                                        title:
                                                            'Failed to delete service',
                                                        text:
                                                            'Failed to delete service',
                                                      );
                                                    });
                                                  }
                                                },
                                                style: TextButton.styleFrom(
                                                  foregroundColor: Colors.black,
                                                  backgroundColor: Colors.white,
                                                ),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          );
                                        });
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
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageTransition(
                        child: UpdateServiceScreen(
                          serviceId: widget.id!,
                          bookTitle: widget.book!,
                          serviceTypeId: widget.serviceTypeId!,
                          serviceType: widget.serviceType!,
                          serviceName: widget.serviceName!,
                          price: widget.price!.toString(),
                          readerId: widget.readerId!,
                          onUpdated: widget.onUpdated,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
