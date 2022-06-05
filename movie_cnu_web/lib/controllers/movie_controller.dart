import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:movie_cnu_web/models/movie.dart';
import 'package:movie_cnu_web/services/firebase_service.dart';

import '../models/schedule.dart';

class MovieController extends GetxController {
  static MovieController get to => Get.find();

  final FirebaseService _firebaseService = FirebaseService();

  Future<List<Schedule>> getMovieSchedule(String movieId,String theaterName)async{
    List docs = await _firebaseService.getMovieSchedule(movieId, theaterName);
    try{
      return docs.map((e) {
        return Schedule.fromJson(e.data());
      }).toList();
    }catch(e){
      print(e);
      return [];
    }

  }

  Future<List<Movie>> getRunningMovieList() async {
    return (await _firebaseService.getRunningMovie()).map((e) {
      return Movie.fromJson(e.data());
    }).toList();
  }

  Future<bool> uploadImage(String movieId, Uint8List file) async {
    try {
      return await FirebaseService().uploadImage(movieId, file);
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Uint8List?> getImage(String movieId) async {
    try {
      return await FirebaseService().getImage(movieId);
    } catch (e) {
      print('error is $e');
      return null;
    }
  }

  Future<bool> uploadMovie(String id, Map<String, dynamic> movie) async {
    try {
      return await FirebaseService().uploadMovie(id, movie);
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addSchedule(String movieId,String theaterName,DateTime movieRunningTime)async{
    try{
      return await FirebaseService().addSchedule(movieId, theaterName, movieRunningTime);
    }catch(e){
      print(e);
      return false;
    }
  }
}
