import 'package:flutter/material.dart';

class ReaderRequestStep2 extends StatefulWidget {
  const ReaderRequestStep2({super.key});

  @override
  State<ReaderRequestStep2> createState() => _ReaderRequestStep2State();
}

class _ReaderRequestStep2State extends State<ReaderRequestStep2> {
  @override
  Widget build(BuildContext context) {
    return QuestionListView(
      questions: [
        Question(
          question: 'What is your favorite color?',
        ),
        Question(
          question: 'Which of the following sports do you enjoy?',
        ),
        Question(
          question: 'What is your favorite food?',
        ),
        Question(
          question: 'What is your favorite movie?',
        ),
      ],
    );
  }
}

class Question {
  final String question;

  Question({required this.question});
}

class QuestionListView extends StatelessWidget {
  final List<Question> questions;
  final TextEditingController controller = TextEditingController();

  QuestionListView({super.key, required this.questions});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          for (var question in questions)
            Container(
              padding: const EdgeInsets.all(17.0),
              margin: const EdgeInsets.only(bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.question,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: controller,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: 'Type your answer here',
                      border: OutlineInputBorder(),
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
