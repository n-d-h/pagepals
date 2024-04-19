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

  // IMAGE
  static Future<String> uploadImage(File filePath) async {
    Reference ref =
        _firebaseStorage.ref().child('images/${DateTime.now()}.png');

    SettableMetadata metadata = SettableMetadata(contentType: 'image/png');

    await ref.putFile(filePath, metadata);
    String url = await ref.getDownloadURL();
    return url;
  }

  static Future<void> deleteImage(String imageUrl) async {
    Reference ref = _firebaseStorage.refFromURL(imageUrl);
    await ref.delete();
  }

  static Future<List<String>> uploadMultiImage(List<File> files) async {
    List<String> urls = [];
    for (var file in files) {
      String url = await uploadImage(file);
      urls.add(url);
    }
    return urls;
  }

  static Future<void> deleteMultiImage(List<String> imageUrls) async {
    for (var url in imageUrls) {
      Reference ref = _firebaseStorage.refFromURL(url);
      await ref.delete();
    }
  }
}
