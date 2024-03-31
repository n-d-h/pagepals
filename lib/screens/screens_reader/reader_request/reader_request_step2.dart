import 'package:flutter/material.dart';
import 'package:pagepals/models/question_model.dart';
import 'package:pagepals/providers/reader_request_provider.dart';
import 'package:provider/provider.dart';

class ReaderRequestStep2 extends StatefulWidget {
  ReaderRequestStep2({
    super.key,
    this.listQuestions,
  });

  List<QuestionModel>? listQuestions = [];

  @override
  State<ReaderRequestStep2> createState() => _ReaderRequestStep2State();
}

class _ReaderRequestStep2State extends State<ReaderRequestStep2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          children: [
            for (final question in widget.listQuestions!)
              QuestionWidget(
                question: question,
              ),
          ],
        ),
      ),
    );
  }
}

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({
    Key? key,
    required this.question,
  }) : super(key: key);

  final QuestionModel question;

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17.0),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.question.content ?? '',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _controller,
            maxLines: 6,
            decoration: const InputDecoration(
              hintText: 'Type your answer here',
              border: OutlineInputBorder(),
            ),
            onTapOutside: (value) {
              FocusScope.of(context).unfocus();
            },
            onChanged: (value) {
              final readerRequestProvider = context.read<ReaderRequestProvider>();

              readerRequestProvider.setAnswer(
                widget.question.id ?? '',
                value,
              );

              print(readerRequestProvider.readerRequestModel.toString());
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your answer';
              }
              return null;
            },
            cursorErrorColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
