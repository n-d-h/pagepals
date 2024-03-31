class QuestionModel {
  String? content;
  String? id;

  QuestionModel({this.content, this.id});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['content'] = content;
    data['id'] = id;
    return data;
  }
}