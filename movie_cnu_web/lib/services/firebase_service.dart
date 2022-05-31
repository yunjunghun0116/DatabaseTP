import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/movie.dart';

class FirebaseService {
  FirebaseService._initialize() {
    print('FirebaseService Initialized');
  }
  static final FirebaseService _service = FirebaseService._initialize();

  factory FirebaseService() => _service;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<Movie>> getRunningMovie() async {
    DateTime nowTime = DateTime.now();
    DateTime subtractedTime = nowTime.subtract(const Duration(days: 10));
    QuerySnapshot movieList = await _firebaseFirestore
        .collection('movie')
        .where('openDate', isGreaterThanOrEqualTo: subtractedTime)
        .where('openDate', isLessThan: nowTime).get();
    List movieDocs = movieList.docs;
    return movieDocs.map((e)=>Movie.fromJson(e)).toList();
  }
}
