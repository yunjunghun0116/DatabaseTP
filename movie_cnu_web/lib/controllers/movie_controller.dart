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

  Future<String?> getImageUrl(String movieId,XFile file) async {
    try {
      return await FirebaseService().getImageUrl(movieId,file);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
