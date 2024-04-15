import 'package:flutter/material.dart';
import 'package:pagepals/models/reader_models/reader_update_model.dart';

class ReaderUpdateProvider extends ChangeNotifier {
  final ReaderUpdate _readerUpdate = ReaderUpdate();

  ReaderUpdate get readerUpdate => _readerUpdate;

  void updateReaderUpdateModel({
    String? avatarUrl,
    String? nickname,
    String? genres,
    String? languages,
    String? introductionVideoUrl,
    String? audioDescriptionUrl,
    String? countryAccent,
    String? description,
  }) {
    _readerUpdate.avatarUrl = avatarUrl ?? _readerUpdate.avatarUrl;
    _readerUpdate.nickname = nickname ?? _readerUpdate.nickname;
    _readerUpdate.genres = genres ?? _readerUpdate.genres;
    _readerUpdate.languages = languages ?? _readerUpdate.languages;
    _readerUpdate.countryAccent = countryAccent ?? _readerUpdate.countryAccent;
    _readerUpdate.description = description ?? _readerUpdate.description;
    _readerUpdate.videoUrl = introductionVideoUrl ?? _readerUpdate.videoUrl;

    _readerUpdate.audioUrl = audioDescriptionUrl ?? _readerUpdate.audioUrl;

    notifyListeners();
  }

  void clear() {
    _readerUpdate.avatarUrl = null;
    _readerUpdate.nickname = null;
    _readerUpdate.genres = null;
    _readerUpdate.languages = null;
    _readerUpdate.countryAccent = null;
    _readerUpdate.description = null;
    _readerUpdate.videoUrl = null;
    _readerUpdate.audioUrl = null;

    notifyListeners();
  }

  void clearField(String fieldName) {
    switch (fieldName) {
      case 'avatarUrl':
        _readerUpdate.avatarUrl = null;
        break;
      case 'nickname':
        _readerUpdate.nickname = null;
        break;
      case 'genres':
        _readerUpdate.genres = null;
        break;
      case 'languages':
        _readerUpdate.languages = null;
        break;
      case 'countryAccent':
        _readerUpdate.countryAccent = null;
        break;
      case 'description':
        _readerUpdate.description = null;
        break;
      case 'introductionVideoUrl':
        _readerUpdate.videoUrl = null;
        break;
      case 'audioDescriptionUrl':
        _readerUpdate.audioUrl = null;
        break;
      default:
        // If the field name doesn't match any of the cases, do nothing.
        break;
    }
    notifyListeners();
  }
}
