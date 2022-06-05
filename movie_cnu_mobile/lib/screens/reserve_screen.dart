import 'package:flutter/material.dart';
import 'package:movie_cnu_mobile/constants.dart';
import 'package:movie_cnu_mobile/controllers/movie_controller.dart';
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
                  Text('예매가능좌석수 : '),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async{
              bool reserveSuccess = await MovieController.to.reserveMovie(
                movie: widget.movie,
                schedule: widget.schedule,
                userCount: _userCount,
              );
              print(reserveSuccess);
              if(reserveSuccess){
                print('성공!');
              }
            },
            child: Container(
              padding: EdgeInsets.only(
                  top: 10, bottom: MediaQuery.of(context).padding.bottom + 10),
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
    );
  }
}
