class ReaderUpdate {
  String? avatarUrl;
  String? nickname;
  String? genres;
  String? languages;
  String? countryAccent;
  String? description;
  String? videoUrl;
  String? audioUrl;

  ReaderUpdate({
    this.avatarUrl,
    this.nickname,
    this.genres,
    this.languages,
    this.countryAccent,
    this.description,
    this.videoUrl,
    this.audioUrl,
  });

  ReaderUpdate.fromJson(Map<String, dynamic> json) {
    avatarUrl = json['avatarUrl'];
    nickname = json['nickname'];
    genres = json['genres'];
    languages = json['languages'];
    countryAccent = json['countryAccent'];
    description = json['description'];
    videoUrl = json['videoUrl'];
    audioUrl = json['audioUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatarUrl'] = avatarUrl;
    data['nickname'] = nickname;
    data['genres'] = genres;
    data['languages'] = languages;
    data['countryAccent'] = countryAccent;
    data['description'] = description;
    data['videoUrl'] = videoUrl;
    data['audioUrl'] = audioUrl;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'avatarUrl: $avatarUrl, nickname: $nickname, genres: $genres, languages: $languages, countryAccent: $countryAccent, description: $description, videoUrl: $videoUrl, audioUrl: $audioUrl';
  }
}
