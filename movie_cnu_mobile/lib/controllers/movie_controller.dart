import 'package:get/get.dart';
import '../models/movie.dart';
import '../models/schedule.dart';
import '../services/firebase_services.dart';

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


}
