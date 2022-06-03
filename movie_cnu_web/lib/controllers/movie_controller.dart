import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:movie_cnu_web/models/movie.dart';
import 'package:movie_cnu_web/services/firebase_service.dart';

class MovieController extends GetxController {
  static MovieController get to => Get.find();

  final FirebaseService _firebaseService = FirebaseService();

  Future<List<Movie>> getRunningMovieList() async {
    return (await _firebaseService.getRunningMovie()).map((e) {
      return Movie.fromJson(e);
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
}
