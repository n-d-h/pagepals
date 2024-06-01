import 'package:flutter/material.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/services/report_service.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ReportDialogWidget extends StatefulWidget {
  const ReportDialogWidget({
    super.key,
    this.readerId,
    this.accountModel,
    this.listReportReasons,
    this.bookingId,
    required this.type,
    this.onLoading,
  });

  final String? readerId;
  final String? bookingId;
  final AccountModel? accountModel;
  final List<String>? listReportReasons;
  final String type;
  final Function(bool)? onLoading;

  @override
  State<ReportDialogWidget> createState() => _ReportDialogWidgetState();
}

class _ReportDialogWidgetState extends State<ReportDialogWidget> {
  String reportReason = '';

  @override
  Widget build(BuildContext context) {
    List<String> reportReasons = widget.listReportReasons ?? [];

    return AlertDialog(
      title: const Text(
        'Report',
        style: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      content: SingleChildScrollView(
        controller: ScrollController(),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Give me a reason',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...List.generate(reportReasons.length ?? 0, (index) {
                return RadioListTile<String>(
                  title: Text(reportReasons[index]),
                  value: reportReasons[index],
                  groupValue: reportReason,
                  onChanged: (value) {
                    setState(() {
                      reportReason = value!;
                    });
                  },
                );
              }),
              Visibility(
                visible: reportReason == 'Others',
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your reason',
                  ),
                  maxLines: 5,
                  onChanged: (value) {
                    setState(() {
                      reportReason = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Submit'),
          onPressed: () async {
            try {
              bool result = false;
              if (widget.type == "READER") {
                result = await ReportService.createReport(
                  widget.accountModel?.customer?.id ?? '',
                  reportReason,
                  widget.readerId!,
                  widget.type,
                );
              } else if (widget.type == "BOOKING") {
                result = await ReportService.createReport(
                  widget.accountModel?.customer?.id ?? '',
                  reportReason,
                  widget.bookingId!,
                  widget.type,
                );

                widget.onLoading!(result);
              }

              if (result) {
                Navigator.of(context).pop();
                Future.delayed(const Duration(milliseconds: 100), () {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    title: 'Success',
                    text: 'Reported successfully',
                  );
                });
              } else {
                Navigator.of(context).pop();
                Future.delayed(const Duration(milliseconds: 100), () {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Failed',
                    text: 'Failed to report',
                  );
                });
              }
            } catch (e) {
              if (e.toString().contains("Reader has been reported")) {
                Navigator.of(context).pop();
                Future.delayed(const Duration(milliseconds: 100), () {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Failed',
                    text: 'Reader has been reported',
                  );
                });
              }
            }
          },
        ),
      ],
    );
  }
}
