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
          answers: ['Red', 'Blue', 'Green', 'Yellow'],
        ),
        Question(
          question: 'Which of the following sports do you enjoy?',
          answers: ['Football', 'Basketball'],
        ),
        Question(
          question: 'What is your favorite food?',
          answers: ['Pizza', 'Burger', 'Pasta'],
        ),
      ],
    );
  }
}

class Question {
  final String question;
  final List<String> answers;

  Question({required this.question, required this.answers});
}

class QuestionListView extends StatelessWidget {
  final List<Question> questions;

  const QuestionListView({super.key, required this.questions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          for (var question in questions)
            Container(
              padding: const EdgeInsets.all(17.0),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
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
                  for (var answer in question.answers)
                    RadioListTile(
                      title: Text(
                        answer,
                        style: const TextStyle(fontSize: 12),
                      ),
                      value: answer,
                      groupValue: null,
                      onChanged: (value) {},
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
