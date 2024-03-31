import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FileStorageService {
  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  static final FirebaseFirestore _firebaseStore = FirebaseFirestore.instance;

  // VIDEO
  static Future<String> uploadFile(File filePath) async {
    Reference ref =
        _firebaseStorage.ref().child('videos/${DateTime.now()}.mp4');

    SettableMetadata metadata = SettableMetadata(contentType: 'video/mp4');

    await ref.putFile(filePath, metadata);
    String url = await ref.getDownloadURL();
    return url;
  }

  static Future<void> saveVideoData(String videoUrl) async {
    await _firebaseStore.collection('videos').add({
      'url': videoUrl,
      'createdAt': FieldValue.serverTimestamp(),
      'name': 'Reader Video',
    });
  }

  static Future<void> deleteFile(String filePath) async {
    Reference ref = _firebaseStorage.refFromURL(filePath);
    await ref.delete();
  }

  // AUDIO
  static Future<String> uploadAudio(File filePath) async {
    Reference ref =
        _firebaseStorage.ref().child('audios/${DateTime.now()}.mp3');

    SettableMetadata metadata = SettableMetadata(contentType: 'audio/mp3');

    await ref.putFile(filePath, metadata);
    String url = await ref.getDownloadURL();
    return url;
  }

  static Future<void> saveAudioData(String audioUrl) async {
    await _firebaseStore.collection('audios').add({
      'url': audioUrl,
      'createdAt': FieldValue.serverTimestamp(),
      'name': 'Reader Audio',
    });
  }

  // IMAGE
  static Future<String> uploadImage(File filePath) async {
    Reference ref =
        _firebaseStorage.ref().child('images/${DateTime.now()}.png');

    SettableMetadata metadata = SettableMetadata(contentType: 'image/png');

    await ref.putFile(filePath, metadata);
    String url = await ref.getDownloadURL();
    return url;
  }

  static Future<void> saveImageData(String imageUrl) async {
    await _firebaseStore.collection('images').add({
      'url': imageUrl,
      'createdAt': FieldValue.serverTimestamp(),
      'name': 'Reader Image',
    });
  }
}
