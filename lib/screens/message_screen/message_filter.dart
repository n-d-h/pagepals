import 'package:flutter/material.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/models/message_type_model.dart';

class MessageFilter extends StatefulWidget {
  const MessageFilter({super.key});

  @override
  State<MessageFilter> createState() => _MessageFilterState();
}

class _MessageFilterState extends State<MessageFilter> {
  List<MessageTypeModel> messageTypes = [
    MessageTypeModel(icon: Icons.all_inbox, name: 'All', isChecked: true),
    MessageTypeModel(
        icon: Icons.mail_outline, name: 'Unread', isChecked: false),
    MessageTypeModel(
        icon: Icons.star_border_outlined, name: 'Starred', isChecked: false),
    MessageTypeModel(
        icon: Icons.archive_rounded, name: 'Archived', isChecked: false),
    MessageTypeModel(icon: Icons.clear_rounded, name: 'Spam', isChecked: false),
  ];

  List<Widget> messageTypesSelection = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Filter Inbox',
          style: TextStyle(
            fontSize: SpaceHelper.space24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpaceHelper.space24,
                  vertical: SpaceHelper.space24,
                ),
                child: const Text(
                  'Message Type',
                  style: TextStyle(
                    fontSize: SpaceHelper.fontSize18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: SpaceHelper.space24),
              ListTile(
                leading: Icon(
                  Icons.all_inbox,
                  color: Colors.black,
                ),
                title: Text(
                  'All',
                  style: const TextStyle(
                    fontSize: SpaceHelper.fontSize16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Checkbox(
                  value: true,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.mail_outline,
                  color: Colors.black,
                ),
                title: Text(
                  'Unread',
                  style: const TextStyle(
                    fontSize: SpaceHelper.fontSize16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Checkbox(
                  value: false,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.star_border_outlined,
                  color: Colors.black,
                ),
                title: Text(
                  'Starred',
                  style: const TextStyle(
                    fontSize: SpaceHelper.fontSize16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Checkbox(
                  value: false,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.archive_rounded,
                  color: Colors.black,
                ),
                title: Text(
                  'Archived',
                  style: const TextStyle(
                    fontSize: SpaceHelper.fontSize16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Checkbox(
                  value: false,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.clear_rounded,
                  color: Colors.black,
                ),
                title: Text(
                  'Spam',
                  style: const TextStyle(
                    fontSize: SpaceHelper.fontSize16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Checkbox(
                  value: false,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
