import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:movie_cnu_web/models/movie.dart';
import 'package:movie_cnu_web/services/firebase_service.dart';

import '../models/schedule.dart';

class MovieController extends GetxController {
  static MovieController get to => Get.find();

  final FirebaseService _firebaseService = FirebaseService();

  Future<Movie> getMovieInfo(String movieId)async{
    return await _firebaseService.getMovieInfo(movieId);
  }

  Future<List<Schedule>> getMovieSchedule(
      String movieId, String theaterName) async {
    List docs = await _firebaseService.getMovieSchedule(movieId, theaterName);
    try {
      return docs.map((e) {
        return Schedule.fromJson(e.data());
      }).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Movie>> getRunningMovieList() async {
    return (await _firebaseService.getRunningMovie()).map((e) {
      return Movie.fromJson(e.data());
    }).toList();
  }


  Future<bool> uploadMovie(String id, Map<String, dynamic> movie) async {
    try {
      return await FirebaseService().uploadMovie(id, movie);
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addSchedule(
    String movieId,
    String movieTitle,
    String theaterName,
    DateTime movieRunningTime,
  ) async {
    try {
      return await FirebaseService()
          .addSchedule(movieId, movieTitle, theaterName, movieRunningTime);
    } catch (e) {
      print(e);
      return false;
    }
  }
}
