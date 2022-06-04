import 'package:flutter/material.dart';
import 'package:movie_cnu_web/controllers/movie_controller.dart';
import 'package:movie_cnu_web/models/schedule.dart';
import 'package:movie_cnu_web/widgets/schedule_card.dart';

class ScheduleResult extends StatelessWidget {
  final String movieId;
  final String theaterName;
  const ScheduleResult(
      {Key? key, required this.movieId, required this.theaterName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MovieController.to.getMovieSchedule(movieId, theaterName),
      builder: (context, snapshot) {
        if (snapshot.hasData && (snapshot.data as List<Schedule>).isNotEmpty)  {
          List<Schedule> scheduleList = snapshot.data as List<Schedule>;
          return Column(
            children: scheduleList.map((Schedule e){
              return ScheduleCard(schedule: e);
            }).toList(),
          );
        }
        return Center(
          child: Text('해당 영화의 $theaterName에서의 상영 예정 스케쥴이 존재하지 않습니다'),
        );
      },
    );
  }
}
