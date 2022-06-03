import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

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
    print('nowTime : $nowTime\nsubtractedTime : $subtractedTime');
    QuerySnapshot movieList = await _firebaseFirestore
        .collection('movie')
        .where('openDate', isGreaterThanOrEqualTo: subtractedTime.toString())
        .where('openDate', isLessThan: nowTime.toString())
        .get();
    return movieList.docs;
  }

  Future<bool> uploadImage(String movieId, Uint8List file) async {
    try {
      String destination = 'movies/$movieId';
      final ref = _firebaseStorage.ref(destination);
      await ref.putData(file);
      return true;
    } catch (e) {
      print('errorMsg : $e');
      return false;
    }
  }

  Future<Uint8List?> getImage(String movieId) async {
    try {
      String destination = 'movies/$movieId';
      final ref = _firebaseStorage.ref(destination);
      return ref.getData();
    } catch (e) {
      print('errorMsg : $e');
      return null;
    }
  }

  Future<bool> uploadMovie(String id, Map<String, dynamic> movie) async {
    try {
      await _firebaseFirestore.collection('movie').doc(id).set(movie);
      return true;
    } catch (e) {
      return false;
    }
  }
}
