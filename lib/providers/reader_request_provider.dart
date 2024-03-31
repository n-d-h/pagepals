import 'package:flutter/material.dart';
import 'package:pagepals/models/reader_request_model.dart';

class ReaderRequestProvider extends ChangeNotifier {
  final ReaderRequestModel _readerRequestModel = ReaderRequestModel();

  ReaderRequestModel get readerRequestModel => _readerRequestModel;

  void updateReaderRequestModelAtStep1({
    String? description,
    String? genre,
    String? nickname,
    String? countryAccent,
    String? languages,
  }) {
    _readerRequestModel.information = Information(
      description: description,
      genres: genre,
      nickname: nickname,
      countryAccent: countryAccent,
      languages: languages,
    );

    notifyListeners();
  }

  void updateReaderRequestModelAtStep2(List<Answer> answers) {
    _readerRequestModel.answers = answers;
    notifyListeners();
  }

  void updateReaderRequestModelAtStep3({
    String? audioDescriptionUrl,
    String? avatarUrl,
    String? introVideoUrl,
  }) {
    _readerRequestModel.information?.audioDescriptionUrl = audioDescriptionUrl;
    _readerRequestModel.information?.avatarUrl = avatarUrl;
    _readerRequestModel.information?.introductionVideoUrl = introVideoUrl;
    notifyListeners();
  }

  void clearReaderRequestModel() {
    _readerRequestModel.information = null;
    _readerRequestModel.answers = null;
    notifyListeners();
  }

  void setAnswer(String questionId, String content) {
    final List<Answer?> answers = _readerRequestModel.answers ?? [];

    if (answers.isNotEmpty) {
      final Answer? answer = answers.firstWhere(
        (element) => element?.questionId == questionId,
        orElse: () => null,
      );

      if (answer != null) {
        answer.content = content;
      } else {
        final Answer answer = Answer(questionId: questionId, content: content);
        answers.add(answer);
        _readerRequestModel.answers = answers;
      }
    } else {
      final Answer answer = Answer(questionId: questionId, content: content);
      answers.add(answer);
      _readerRequestModel.answers = answers;
    }
    notifyListeners();
  }
}
