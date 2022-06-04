import 'package:cloud_firestore/cloud_firestore.dart';


class FirebaseService {

  FirebaseService._initialize() {
    print('FirebaseService Initialized');
  }
  static final FirebaseService _service = FirebaseService._initialize();

  factory FirebaseService() => _service;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<bool> registerUser(String id, Map<String, dynamic> userInfo) async {
    try {
      await _firebaseFirestore.collection('movie').doc(id).set(userInfo);
      return true;
    } catch (e) {
      return false;
    }
  }

}
