import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FileStorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadFile(File filePath) async {
    Reference ref =
        _firebaseStorage.ref().child('videos/${DateTime.now()}.mp4');

    SettableMetadata metadata = SettableMetadata(contentType: 'video/mp4');

    await ref.putFile(filePath, metadata);
    String url = await ref.getDownloadURL();
    return url;
  }

  Future<void> saveVideoData(String videoUrl) async {
    await _firestore.collection('videos').add({
      'url': videoUrl,
      'createdAt': FieldValue.serverTimestamp(),
      'name': 'Reader Video',
    });
  }

  Future<void> deleteFile(String filePath) async {
    Reference ref = _firebaseStorage.refFromURL(filePath);
    await ref.delete();
  }

  Future<String> uploadImage(File filePath) async {
    Reference ref =
        _firebaseStorage.ref().child('images/${DateTime.now()}.png');

    SettableMetadata metadata = SettableMetadata(contentType: 'image/png');

    await ref.putFile(filePath, metadata);
    String url = await ref.getDownloadURL();
    return url;
  }

  Future<void> saveImageData(String imageUrl) async {
    await _firestore.collection('images').add({
      'url': imageUrl,
      'createdAt': FieldValue.serverTimestamp(),
      'name': 'Reader Image',
    });
  }
}