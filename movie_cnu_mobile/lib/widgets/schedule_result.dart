import 'package:flutter/material.dart';
import 'package:movie_cnu_mobile/models/movie.dart';
import 'package:movie_cnu_mobile/screens/reserve_screen.dart';
import 'package:movie_cnu_mobile/widgets/schedule_card.dart';
import '../controllers/movie_controller.dart';
import '../models/schedule.dart';

class ScheduleResult extends StatelessWidget {
  final Movie movie;
  final String theaterName;
  const ScheduleResult(
      {Key? key, required this.movie, required this.theaterName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MovieController.to.getMovieSchedule(movie.id, theaterName),
      builder: (context, snapshot) {
        if (snapshot.hasData && (snapshot.data as List<Schedule>).isNotEmpty) {
          List<Schedule> scheduleList = snapshot.data as List<Schedule>;
          return Column(
            children: scheduleList.map((Schedule schedule) {
              return ScheduleCard(
                schedule: schedule,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return ReserveScreen(movie: movie, schedule: schedule);
                  }));
                },
              );
            }).toList(),
          );
        }
        return Center(
          child: Text(
            '해당 영화의 $theaterName에서의 \n상영 예정 스케쥴이 존재하지 않습니다',
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
