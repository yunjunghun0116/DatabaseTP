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

  Future<List> getRunningMovie() async {
    DateTime nowTime = DateTime.now();
    DateTime subtractedTime = nowTime.subtract(const Duration(days: 10));
    QuerySnapshot movieList = await _firebaseFirestore
        .collection('movie')
        .where('openDate', isGreaterThanOrEqualTo: subtractedTime.toString())
        .where('openDate', isLessThan: nowTime.toString())
        .get();
    return movieList.docs;
  }

  Future<List> getMovieSchedule(String movieId, String theaterName) async {
    QuerySnapshot scheduleList = await _firebaseFirestore
        .collection('schedule')
        .where('movieId', isEqualTo: movieId)
        .where('theaterName', isEqualTo: theaterName)
        .get();
    return scheduleList.docs;
  }

}
