import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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

  Future<bool> uploadImage(String movieId,Uint8List file) async {
    try {
      return await FirebaseService().uploadImage(movieId,file);
    } catch (e) {
      print(e);
      return false;
    }
  }
}
