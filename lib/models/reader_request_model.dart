class Answer {
  String? content;
  String? questionId;

  Answer({this.content, this.questionId});

  Answer.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    questionId = json['questionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['content'] = content;
    data['questionId'] = questionId;
    return data;
  }
}

class Information {
  String? audioDescriptionUrl;
  String? avatarUrl;
  String? countryAccent;
  String? description;
  String? genres;
  String? introductionVideoUrl;
  String? languages;
  String? nickname;

  Information({
    this.audioDescriptionUrl,
    this.avatarUrl,
    this.countryAccent,
    this.description,
    this.genres,
    this.introductionVideoUrl,
    this.languages,
    this.nickname,
  });

  Information.fromJson(Map<String, dynamic> json) {
    audioDescriptionUrl = json['audioDescriptionUrl'];
    avatarUrl = json['avatarUrl'];
    countryAccent = json['countryAccent'];
    description = json['description'];
    genres = json['genres'];
    introductionVideoUrl = json['introductionVideoUrl'];
    languages = json['languages'];
    nickname = json['nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['audioDescriptionUrl'] = audioDescriptionUrl;
    data['avatarUrl'] = avatarUrl;
    data['countryAccent'] = countryAccent;
    data['description'] = description;
    data['genres'] = genres;
    data['introductionVideoUrl'] = introductionVideoUrl;
    data['languages'] = languages;
    data['nickname'] = nickname;
    return data;
  }
}

class ReaderRequestModel {
  Information? information;
  List<Answer?>? answers;

  ReaderRequestModel({this.information, this.answers});

  ReaderRequestModel.fromJson(Map<String, dynamic> json) {
    information = json['information'] != null
        ? Information?.fromJson(json['information'])
        : null;
    if (json['answers'] != null) {
      answers = <Answer>[];
      json['answers'].forEach((v) {
        answers!.add(Answer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['information'] = information!.toJson();
    data['answers'] = answers?.map((v) => v?.toJson()).toList();
    return data;
  }

  @override
  String toString() {
    return 'ReaderRequestModel('
        'information: (${information?.audioDescriptionUrl}, ${information?.avatarUrl}, ${information?.countryAccent}, ${information?.description}, ${information?.genres}, ${information?.introductionVideoUrl}, ${information?.languages}, ${information?.nickname}), '
        'answers: ${answers?.map((v) => v?.content).toList()}'
        ')';
  }
}
