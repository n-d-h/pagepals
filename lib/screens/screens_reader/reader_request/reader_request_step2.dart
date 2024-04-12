import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/question_model.dart';
import 'package:pagepals/providers/reader_request_provider.dart';
import 'package:provider/provider.dart';

class ReaderRequestStep2 extends StatefulWidget {
  final List<QuestionModel>? listQuestions;

  const ReaderRequestStep2({
    Key? key,
    this.listQuestions,
  }) : super(key: key);

  @override
  State<ReaderRequestStep2> createState() => _ReaderRequestStep2State();
}

class _ReaderRequestStep2State extends State<ReaderRequestStep2> {
  @override
  Widget build(BuildContext context) {
    int count = 1;
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          children: [
            for (final question in widget.listQuestions!)
              QuestionWidget(
                question: question,
                count: count++,
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
    required this.count,
  }) : super(key: key);

  final QuestionModel question;
  final int count;

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final readerProvider = context.read<ReaderRequestProvider>();
      final readerRequestModel = readerProvider.readerRequestModel;
      setState(() {
        _controller.text = readerRequestModel.answers
                ?.firstWhere(
                  (element) => element?.questionId == widget.question.id,
                  orElse: () => null,
                )
                ?.content ??
            '';
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(17, 0, 17, 17),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.count}. ${widget.question.content ?? ''}',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _controller,
            maxLines: 6,
            decoration: InputDecoration(
              hintText: 'Type your answer here...',
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black12, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorHelper.getColor(ColorHelper.green), width: 2),
              ),
            ),
            onTapOutside: (value) {
              final readerRequestProvider =
                  context.read<ReaderRequestProvider>();

              readerRequestProvider.setAnswer(
                widget.question.id ?? '',
                _controller.text,
              );

              FocusScope.of(context).unfocus();
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
