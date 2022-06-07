import 'package:flutter/material.dart';
import 'package:movie_cnu_web/controllers/movie_controller.dart';
import 'package:movie_cnu_web/controllers/reserve_controller.dart';
import 'package:movie_cnu_web/models/movie.dart';
import 'package:movie_cnu_web/models/reserve.dart';

import '../constants.dart';

class ReserveScreen extends StatelessWidget {
  const ReserveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ReserveController.to.getReserveList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Reserve> reserveList = snapshot.data as List<Reserve>;
            return ListView(
              children: reserveList.map((Reserve reserve) {
                return Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: kLightGreyColor,
                  ))),
                  child: ListTile(
                    onTap: () {},
                    title: FutureBuilder(
                      future: MovieController.to.getMovieInfo(reserve.movieId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          Movie movie = snapshot.data as Movie;
                          return Text(movie.title);
                        }
                        return const Text('');
                      },
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('상영관 : ${reserve.theaterName}'),
                        Text(
                            '상영시간 : ${reserve.movieRunningTime.toString().substring(0, 16)}'),
                        Text(
                            '예매시간 : ${reserve.reservedTime.toString().substring(0, 16)}'),
                        Text(
                            '예매한 유저 : ${reserve.userName} (${reserve.userId})'),
                        Text('예매한 좌석수 : ${reserve.userCount}'),
                      ],
                    ),
                    trailing: reserve.isCanceled
                        ? const Text(
                            '이미 취소된 예매입니다',
                            style: TextStyle(
                              color: kGreyColor,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : TextButton(
                            onPressed: () {
                              ReserveController.to.cancelReserve(reserve.id);
                            },
                            child: const Text(
                              '취소',
                              style: TextStyle(color: kRedColor),
                            ),
                          ),
                  ),
                );
              }).toList(),
            );
          }
          return const Center(
            child: const CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
