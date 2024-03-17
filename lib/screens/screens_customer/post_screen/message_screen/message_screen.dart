import 'package:flutter/material.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/models/message_type_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pagepals/screens/screens_customer/post_screen/message_screen/message_item.dart';
import 'package:unicons/unicons.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            UniconsLine.multiply,
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Inbox',
          style: TextStyle(
            fontSize: SpaceHelper.space24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return modelBottomSheet(context);
                },
              );
            },
            icon: const Icon(
              UniconsLine.filter,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        physics: const BouncingScrollPhysics(),
        child: const Column(
          children: [
            MessageItem(),
            MessageItem(),
            MessageItem(),
            MessageItem(),
          ],
        ),
      ),
    );
  }

  Widget modelBottomSheet(BuildContext context) {
    List<MessageTypeModel> messageTypes = [
      MessageTypeModel(icon: Icons.all_inbox, name: 'All', isChecked: true),
      MessageTypeModel(
          icon: Icons.mail_outline, name: 'Unread', isChecked: false),
      MessageTypeModel(
          icon: Icons.star_border_outlined, name: 'Starred', isChecked: false),
      MessageTypeModel(
          icon: Icons.archive_rounded, name: 'Archived', isChecked: false),
      MessageTypeModel(
          icon: Icons.clear_rounded, name: 'Spam', isChecked: false),
    ];

    return Stack(
      alignment: Alignment.topRight,
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: const Icon(
              UniconsLine.multiply,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 24,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpaceHelper.space24,
                  vertical: SpaceHelper.space24,
                ),
                child: Text(
                  AppLocalizations.of(context)!.appMessageType,
                  style: const TextStyle(
                    fontSize: SpaceHelper.fontSize18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: SpaceHelper.space24),
              ListTile(
                leading: const Icon(
                  Icons.all_inbox,
                  color: Colors.black,
                ),
                title: const Text(
                  'All',
                  style: TextStyle(
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
                leading: const Icon(
                  Icons.mail_outline,
                  color: Colors.black,
                ),
                title: const Text(
                  'Unread',
                  style: TextStyle(
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
                leading: const Icon(
                  Icons.star_border_outlined,
                  color: Colors.black,
                ),
                title: const Text(
                  'Starred',
                  style: TextStyle(
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
                leading: const Icon(
                  Icons.archive_rounded,
                  color: Colors.black,
                ),
                title: const Text(
                  'Archived',
                  style: TextStyle(
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
                leading: const Icon(
                  Icons.clear_rounded,
                  color: Colors.black,
                ),
                title: const Text(
                  'Spam',
                  style: TextStyle(
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
      ],
    );
  }
}
