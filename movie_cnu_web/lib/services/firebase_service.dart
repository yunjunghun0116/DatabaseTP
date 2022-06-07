import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:movie_cnu_web/models/reserve.dart';
import 'package:movie_cnu_web/models/user.dart';
import 'package:uuid/uuid.dart';

import '../models/movie.dart';

class FirebaseService {
  FirebaseService._initialize() {
    print('FirebaseService Initialized');
  }
  static final FirebaseService _service = FirebaseService._initialize();

  factory FirebaseService() => _service;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<List> getMovieSchedule(String movieId, String theaterName) async {
    QuerySnapshot scheduleList = await _firebaseFirestore
        .collection('schedule')
        .where('movieId', isEqualTo: movieId)
        .where('theaterName', isEqualTo: theaterName)
        .get();
    return scheduleList.docs;
  }

  Future<List> getRunningMovie() async {
    DateTime nowTime = DateTime.now();
    DateTime subtractedTime = nowTime.subtract(const Duration(days: 10));
    QuerySnapshot movieList = await _firebaseFirestore
        .collection('movie')
        .where('openDate', isGreaterThanOrEqualTo: subtractedTime.toString())
        .get();
    return movieList.docs;
  }

  Future<bool> uploadMovie(String id, Map<String, dynamic> movie) async {
    try {
      await _firebaseFirestore.collection('movie').doc(id).set(movie);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addSchedule(
      String movieId, String movieTitle,String theaterName, DateTime movieRunningTime) async {
    try {
      String id = const Uuid().v4();
      await _firebaseFirestore.collection('schedule').doc(id).set({
        'id':id,
        'movieId': movieId,
        'movieTitle':movieTitle,
        'movieRunningTime': movieRunningTime.toString(),
        'theaterName': theaterName,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<User>> getUserList()async{
    try{
      QuerySnapshot<Map<String,dynamic>> userList =  await _firebaseFirestore.collection('user').get();
      return userList.docs.map((e){
        return User.fromJson(e.data());
      }).toList();
    }catch(e){
      return [];
    }
  }

  Future<List<Reserve>> getReserveList()async{
    try{
      QuerySnapshot<Map<String,dynamic>> reserveList =  await _firebaseFirestore.collection('reserve').get();
      return reserveList.docs.map((e){
        return Reserve.fromJson(e.data());
      }).toList();
    }catch(e){
      return [];
    }
  }

  Future<Movie> getMovieInfo(String movieId)async{
    DocumentSnapshot movieInfo =  await _firebaseFirestore.collection('movie').doc(movieId).get();
    return Movie.fromJson(movieInfo.data());
  }

  Future<void> cancelReserve(String reserveId)async{
    await _firebaseFirestore.collection('reserve').doc(reserveId).update({
      'isCanceled':true
    });
  }

}
