import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../models/movie.dart';

class FirebaseService {
  FirebaseService._initialize() {
    print('FirebaseService Initialized');
  }
  static final FirebaseService _service = FirebaseService._initialize();

  factory FirebaseService() => _service;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<List> getRunningMovie() async {
    DateTime nowTime = DateTime.now();
    DateTime subtractedTime = nowTime.subtract(const Duration(days: 10));
    QuerySnapshot movieList = await _firebaseFirestore
        .collection('movie')
        .where('openDate', isGreaterThanOrEqualTo: subtractedTime)
        .where('openDate', isLessThan: nowTime)
        .get();
    return movieList.docs;
  }
  //TODO 이미지업로드 고민할것
  Future<String?> getImageUrl(String movieId, XFile file) async {
    try {
      File image = File(file.path);
      String destination = 'movies/$movieId';
      final ref = _firebaseStorage.ref(destination);
      TaskSnapshot uploadedFile = await ref.putFile(image);
      String? downloadUrl = await uploadedFile.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('errorMsg : $e');
      return null;
    }
  }
}
