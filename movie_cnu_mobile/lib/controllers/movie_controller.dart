import 'package:get/get.dart';
import 'package:movie_cnu_mobile/controllers/user_controller.dart';
import 'package:movie_cnu_mobile/models/reserve.dart';
import 'package:uuid/uuid.dart';
import '../models/movie.dart';
import '../models/schedule.dart';
import '../services/firebase_services.dart';

class MovieController extends GetxController {
  static MovieController get to => Get.find();

  final FirebaseService _firebaseService = FirebaseService();

  Future<List<Schedule>> getMovieSchedule(
      String movieId, String theaterName) async {
    return (await _firebaseService.getMovieSchedule(movieId, theaterName))
        .map((e) {
      return Schedule.fromJson(e.data());
    }).toList();
  }

  Future<List<Movie>> getRunningMovieList(int statusIndex) async {
    if(statusIndex == 0){
      return (await _firebaseService.getRunningMovie()).map((e) {
        return Movie.fromJson(e.data());
      }).toList();
    }
    return (await _firebaseService.getExpectedMovie()).map((e) {
      return Movie.fromJson(e.data());
    }).toList();

  }

  Future<bool> reserveMovie({
    required Movie movie,
    required Schedule schedule,
    required int userCount,
  }) async {
    return await _firebaseService.reserveMovie(movie: movie, schedule: schedule, userCount: userCount);
  }

  Future<int> reservedScheduleCount(String scheduleId)async{
    return await _firebaseService.reservedScheduleCount(scheduleId);
  }
}
