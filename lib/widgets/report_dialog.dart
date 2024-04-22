import 'package:flutter/material.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/services/report_service.dart';

class ReportDialogWidget extends StatefulWidget {
  const ReportDialogWidget({
    super.key,
    this.readerId,
    this.accountModel,
    this.listReportReasons,
    required this.type,
  });

  final String? readerId;
  final AccountModel? accountModel;
  final List<String>? listReportReasons;
  final String type;

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
            bool result = await ReportService.createReport(
              widget.accountModel?.customer?.id ?? '',
              reportReason,
              widget.readerId!,
              widget.type,
            );

            if (result) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Reported successfully'),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Failed to report'),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
