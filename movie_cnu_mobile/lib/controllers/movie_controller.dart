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
    try{
      return (await _firebaseService.getMovieSchedule(movieId, theaterName))
          .map((e) {
        return Schedule.fromJson(e.data());
      }).toList();
    }catch(e){
      print(e);
      return [];
    }

  }

  Future<List<Movie>> getRunningMovieList(int statusIndex) async {
    if (statusIndex == 0) {
      return (await _firebaseService.getRunningMovie()).map((e) {
        return Movie.fromJson(e.data());
      }).toList();
    }
    return (await _firebaseService.getExpectedMovie()).map((e) {
      return Movie.fromJson(e.data());
    }).toList();
  }

  Future<Movie> getMovieInfo(String movieId) async {
    return await _firebaseService.getMovieInfo(movieId);
  }

  Future<bool> reserveMovie({
    required Movie movie,
    required Schedule schedule,
    required int userCount,
  }) async {
    return await _firebaseService.reserveMovie(
        movie: movie, schedule: schedule, userCount: userCount);
  }

  Future<int> reservedScheduleCount(String scheduleId) async {
    return await _firebaseService.reservedScheduleCount(scheduleId);
  }

  Future<int> reservedMovieCount(String movieId) async {
    return await _firebaseService.reservedMovieCount(movieId);
  }

  Future<int> reservedAlreadySeenAboutMovieCount(
    String movieId,
    DateTime movieOpenDate,
  ) async {
    return await _firebaseService.reservedAlreadySeenAboutMovieCount(
      movieId,
      movieOpenDate,
    );
  }

  Future<List<Reserve>> getUserReservedHistory(String userId) async {
    return (await _firebaseService.getUserReservedHistory(userId)).map((e) {
      return Reserve.fromJson(e.data());
    }).toList();
  }

  Future<List<Reserve>> getUserCanceledHistory(String userId) async {
    return (await _firebaseService.getUserCanceledHistory(userId)).map((e) {
      return Reserve.fromJson(e.data());
    }).toList();
  }

  Future<List<Reserve>> getUserAlreadySeenHistory(String userId) async {
    return (await _firebaseService.getUserAlreadySeenHistory(userId)).map((e) {
      return Reserve.fromJson(e.data());
    }).toList();
  }

  Future<void> cancelReservedHistory(String reserveId) async {
    await _firebaseService.cancelReservedHistory(reserveId);
  }

  Future<List<Movie>> searchWithTitle(String title)async{
    return await _firebaseService.searchWithTitle(title);
  }

  Future<List<Movie>> searchWithDate(DateTime date)async{
    return await _firebaseService.searchWithDate( date);
  }
  Future<List<Movie>> searchWithTitleAndDate(String title, DateTime date)async{
    return await _firebaseService.searchWithTitleAndDate(title,date);
  }
}
