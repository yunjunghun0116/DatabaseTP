import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_cnu_mobile/models/user.dart';
import 'package:uuid/uuid.dart';

import '../controllers/user_controller.dart';
import '../models/movie.dart';
import '../models/schedule.dart';

class FirebaseService {
  FirebaseService._initialize() {
    print('FirebaseService Initialized');
  }
  static final FirebaseService _service = FirebaseService._initialize();

  factory FirebaseService() => _service;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<bool> registerUser(String id, Map<String, dynamic> userInfo) async {
    try {
      await _firebaseFirestore.collection('user').doc(id).set(userInfo);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<User?> loginUser(String email, String password) async {
    try {
      QuerySnapshot<Map<String, dynamic>> userSnapshot =
          await _firebaseFirestore
              .collection('user')
              .where('email', isEqualTo: email)
              .get();
      DocumentSnapshot userData = userSnapshot.docs.first;
      Map<String, dynamic> user = userData.data() as Map<String, dynamic>;
      if (user['password'] == password) return User.fromJson(user);
      return null;
    } catch (e) {
      return null;
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

  Future<List> getExpectedMovie() async {
    DateTime nowTime = DateTime.now();
    QuerySnapshot movieList = await _firebaseFirestore
        .collection('movie')
        .where('openDate', isGreaterThanOrEqualTo: nowTime.toString())
        .get();
    return movieList.docs;
  }

  Future<List> getMovieSchedule(String movieId, String theaterName) async {
    try {
      DateTime nowDateTime = DateTime.now();
      QuerySnapshot scheduleList = await _firebaseFirestore
          .collection('schedule')
          .where('movieId', isEqualTo: movieId)
          .where('theaterName', isEqualTo: theaterName)
          .where('movieRunningTime',
              isGreaterThanOrEqualTo: nowDateTime.toString())
          .get();
      return scheduleList.docs;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<Movie> getMovieInfo(String movieId) async {
    DocumentSnapshot movieDocument =
        await _firebaseFirestore.collection('movie').doc(movieId).get();
    return Movie.fromJson(movieDocument.data());
  }

  Future<bool> reserveMovie({
    required Movie movie,
    required Schedule schedule,
    required int userCount,
  }) async {
    try {
      String reserveId = const Uuid().v4();
      DateTime nowDateTime = DateTime.now();
      Map<String, dynamic> reserveData = {
        'id': reserveId,
        'theaterName': schedule.theaterName,
        'userName': UserController.to.user!.name,
        'userId': UserController.to.user!.id,
        'scheduleId': schedule.id,
        'movieId': movie.id,
        'userCount': userCount,
        'isCanceled': false,
        'reservedTime': nowDateTime.toString(),
        'movieRunningTime': schedule.movieRunningTime.toString(),
      };
      await _firebaseFirestore
          .collection('reserve')
          .doc(reserveId)
          .set(reserveData);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<int> reservedScheduleCount(String scheduleId) async {
    try {
      int count = 0;
      QuerySnapshot reservedDocs = await _firebaseFirestore
          .collection('reserve')
          .where('scheduleId', isEqualTo: scheduleId)
          .where('isCanceled', isEqualTo: false)
          .get();
      for (var e in reservedDocs.docs) {
        count += (e.data() as Map<String, dynamic>)['userCount'] as int;
      }
      return count;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  //???????????? : ?????? ????????????
  Future<int> reservedMovieCount(String movieId) async {
    try {
      int count = 0;
      DateTime nowDateTime = DateTime.now();
      QuerySnapshot reservedDocs = await _firebaseFirestore
          .collection('reserve')
          .where('movieId', isEqualTo: movieId)
          .where('isCanceled', isEqualTo: false)
          .where('movieRunningTime',
              isGreaterThanOrEqualTo: nowDateTime.toString())
          .get();
      for (var e in reservedDocs.docs) {
        count += (e.data() as Map<String, dynamic>)['userCount'] as int;
      }
      return count;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  //?????? ????????? : ??????????????? ???????????? ??????????????? ?????? ?????? ??????????????? Count
  Future<int> reservedAlreadySeenAboutMovieCount(
    String movieId,
    DateTime movieOpenDate,
  ) async {
    try {
      int count = 0;
      DateTime nowDateTime = DateTime.now();
      QuerySnapshot reservedDocs = await _firebaseFirestore
          .collection('reserve')
          .where('movieRunningTime',
              isLessThanOrEqualTo: nowDateTime.toString())
          .orderBy('movieRunningTime', descending: true)
          .where('movieId', isEqualTo: movieId)
          .get();
      for (var e in reservedDocs.docs) {
        count += (e.data() as Map<String, dynamic>)['userCount'] as int;
      }
      return count;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<List> getUserReservedHistory(String userId) async {
    try {
      QuerySnapshot reservedDocs = await _firebaseFirestore
          .collection('reserve')
          .where('userId', isEqualTo: userId)
          .where('isCanceled', isEqualTo: false)
          .orderBy('reservedTime', descending: true)
          .get();
      return reservedDocs.docs;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List> getUserCanceledHistory(String userId) async {
    try {
      QuerySnapshot reservedDocs = await _firebaseFirestore
          .collection('reserve')
          .orderBy('reservedTime', descending: true)
          .where('userId', isEqualTo: userId)
          .where('isCanceled', isEqualTo: true)
          .get();
      return reservedDocs.docs;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List> getUserAlreadySeenHistory(String userId) async {
    try {
      QuerySnapshot reservedDocs = await _firebaseFirestore
          .collection('reserve')
          .where('userId', isEqualTo: userId)
          .where('isCanceled', isEqualTo: false)
          .where('movieRunningTime',
              isLessThanOrEqualTo: DateTime.now().toString())
          .orderBy('movieRunningTime', descending: true)
          .get();
      return reservedDocs.docs;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> cancelReservedHistory(String reserveId) async {
    await _firebaseFirestore.collection('reserve').doc(reserveId).update({
      'isCanceled': true,
      'reservedTime': DateTime.now().toString(),
    });
  }

  Future<List<Movie>> searchWithTitle(String title) async {
    try {
      List<String> movieIdList = [];
      QuerySnapshot scheduleDocs = await _firebaseFirestore
          .collection('schedule')
          .where('movieTitle', isEqualTo: title)
          .get();
      for (var element in scheduleDocs.docs) {
        Map<String, dynamic> scheduleData =
            element.data() as Map<String, dynamic>;
        if (!movieIdList.contains(scheduleData['movieId'])) {
          movieIdList.add(scheduleData['movieId']);
        }
      }
      List<Movie> movieList = [];

      for (String movieId in movieIdList) {
        movieList.add(await getMovieInfo(movieId));
      }
      return movieList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Movie>> searchWithDate(DateTime date) async {
    try {
      List<String> movieIdList = [];
      QuerySnapshot scheduleDocs = await _firebaseFirestore
          .collection('schedule')
          .where('movieRunningTime', isGreaterThanOrEqualTo: date.toString())
          .where('movieRunningTime',
              isLessThanOrEqualTo: date.add(const Duration(days: 1)).toString())
          .get();
      for (var element in scheduleDocs.docs) {
        Map<String, dynamic> scheduleData =
            element.data() as Map<String, dynamic>;
        if (!movieIdList.contains(scheduleData['movieId'])) {
          movieIdList.add(scheduleData['movieId']);
        }
      }
      List<Movie> movieList = [];

      for (String movieId in movieIdList) {
        movieList.add(await getMovieInfo(movieId));
      }
      return movieList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Movie>> searchWithTitleAndDate(String title, DateTime date) async {
    try {
      List<String> movieIdList = [];
      QuerySnapshot scheduleDocs = await _firebaseFirestore
          .collection('schedule')
          .where('movieTitle', isEqualTo: title)
          .where('movieRunningTime', isGreaterThanOrEqualTo: date.toString())
          .where('movieRunningTime',
          isLessThanOrEqualTo: date.add(const Duration(days: 1)).toString())
          .get();
      for (var element in scheduleDocs.docs) {
        Map<String, dynamic> scheduleData =
        element.data() as Map<String, dynamic>;
        if (!movieIdList.contains(scheduleData['movieId'])) {
          movieIdList.add(scheduleData['movieId']);
        }
      }
      List<Movie> movieList = [];

      for (String movieId in movieIdList) {
        movieList.add(await getMovieInfo(movieId));
      }
      return movieList;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
