import 'package:flutter/material.dart';
import 'package:movie_cnu_mobile/constants.dart';
import 'package:movie_cnu_mobile/controllers/movie_controller.dart';
import 'package:movie_cnu_mobile/controllers/user_controller.dart';
import 'package:movie_cnu_mobile/screens/main_screen.dart';
import 'package:movie_cnu_mobile/services/email_services.dart';
import '../models/movie.dart';
import '../models/schedule.dart';

class ReserveScreen extends StatefulWidget {
  final Movie movie;
  final Schedule schedule;
  const ReserveScreen({
    Key? key,
    required this.movie,
    required this.schedule,
  }) : super(key: key);

  @override
  State<ReserveScreen> createState() => _ReserveScreenState();
}

class _ReserveScreenState extends State<ReserveScreen> {
  int _userCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kWhiteColor,
          foregroundColor: kBlackColor,
          elevation: 1,
          title: Text('${widget.movie.title} 예매'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '영화정보',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('제목 : ${widget.movie.title}'),
                    Text(
                        '개봉일자 : ${widget.movie.openDate.toString().substring(0, 10)}'),
                    Text('감독 : ${widget.movie.director}'),
                    Wrap(
                      children: [
                        const Text('출연배우 : '),
                        ...widget.movie.actors.map((e) {
                          return Text('$e ');
                        }).toList()
                      ],
                    ),
                    Text('영화길이 : ${widget.movie.length}분'),
                    Text('등급 : ${widget.movie.grade}'),
                    Text(
                        '상영시간 : ${widget.schedule.movieRunningTime.toString().substring(0, 16)}'),
                    FutureBuilder(
                        future: MovieController.to
                            .reservedScheduleCount(widget.schedule.id),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            int count = snapshot.data as int;
                            return Text('예매가능좌석수 : ${180 - count} / 180 (석)');
                          }
                          return const Text('예매가능좌석수 : 0 (석)');
                        }),
                    Text('예매할 좌석수(최대 10석) : $_userCount (석)'),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                var navigator = Navigator.of(context);
                bool reserveSuccess = await MovieController.to.reserveMovie(
                  movie: widget.movie,
                  schedule: widget.schedule,
                  userCount: _userCount,
                );
                if (reserveSuccess) {
                  await EmailService().sendEmail(
                    email: UserController.to.user!.email,
                    movieTitle: widget.movie.title,
                    reservedTime: DateTime.now(),
                    reservedCount: _userCount,
                    movieRunningTime: widget.schedule.movieRunningTime,
                    theaterName: widget.schedule.theaterName,
                  );
                  navigator.pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) {
                    return const MainScreen();
                  }), (route) => false);
                }
              },
              child: Container(
                padding: EdgeInsets.only(
                    top: 10,
                    bottom: MediaQuery.of(context).padding.bottom + 10),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: kBlueColor,
                ),
                child: const Text(
                  '예매하기',
                  style: TextStyle(
                    fontSize: 20,
                    color: kWhiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: null,
              child: const Icon(Icons.add),
              onPressed: () {
                if (_userCount < 10) {
                  setState(() {
                    _userCount++;
                  });
                }
              },
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              heroTag: null,
              child: const Icon(Icons.remove),
              onPressed: () {
                if (_userCount > 1) {
                  setState(() {
                    _userCount--;
                  });
                }
              },
            ),
            const SizedBox(height: 50),
          ],
        ));
  }
}
