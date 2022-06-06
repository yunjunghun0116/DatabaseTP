import 'package:flutter/material.dart';
import 'package:movie_cnu_mobile/controllers/movie_controller.dart';
import 'package:movie_cnu_mobile/controllers/user_controller.dart';
import 'package:movie_cnu_mobile/models/movie.dart';
import 'package:movie_cnu_mobile/models/reserve.dart';

import '../constants.dart';

class HistoryScreen extends StatefulWidget {
  final int statusIndex;
  const HistoryScreen({Key? key, required this.statusIndex}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // 1: 예매내역 2: 취소내역 3: 지난관람내역
  String getTitle() {
    switch (widget.statusIndex) {
      case 1:
        return '내 예매내역';
      case 2:
        return '내 취소내역';
      case 3:
        return '내 지난 관람내역';
      default:
        return '내 예매내역';
    }
  }

  Future<List<Reserve>> getFutureFunction() {
    switch (widget.statusIndex) {
      case 1:
        return MovieController.to
            .getUserReservedHistory(UserController.to.user!.id);
      case 2:
        return MovieController.to
            .getUserCanceledHistory(UserController.to.user!.id);
      case 3:
        return MovieController.to
            .getUserAlreadySeenHistory(UserController.to.user!.id);
      default:
        return MovieController.to
            .getUserReservedHistory(UserController.to.user!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              getTitle(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kDarkGreyColor,
              ),
            ),
          ),
          FutureBuilder(
            future: getFutureFunction(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Reserve> result = snapshot.data as List<Reserve>;
                DateTime nowDateTime = DateTime.now();
                if (widget.statusIndex == 1) {
                  //runningTime이 미래에 위치한 것들을 모두 제거함
                  result.removeWhere((reserve) =>
                      nowDateTime
                          .difference(reserve.movieRunningTime)
                          .inMinutes >
                      0);
                }
                return Column(
                  children: result.map((Reserve reserve) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: kLightGreyColor),
                      ),
                      child: ListTile(
                        title: FutureBuilder(
                          future:
                              MovieController.to.getMovieInfo(reserve.movieId),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              Movie movieData = snapshot.data as Movie;
                              return Text(movieData.title);
                            }
                            return const Text('');
                          },
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget.statusIndex == 3
                                ? Text(
                                    '관람일자 : ${reserve.movieRunningTime.toString().substring(0, 16)}')
                                : Container(),
                            Text(
                                '${reserve.isCanceled ? '취소일자' : '예매일자'} : ${reserve.reservedTime.toString().substring(0, 16)}'),
                            widget.statusIndex == 3
                                ? Container()
                                : Text(
                                    '상영일자 : ${reserve.movieRunningTime.toString().substring(0, 16)}'),
                            Text(
                                '예매표수 : ${reserve.userCount}, 상영장소 : ${reserve.theaterName}'),
                          ],
                        ),
                        trailing: reserve.isCanceled ||
                                nowDateTime
                                        .difference(reserve.movieRunningTime)
                                        .inMinutes >
                                    0
                            ? null
                            : TextButton(
                                onPressed: () async {
                                  await MovieController.to
                                      .cancelReservedHistory(reserve.id);
                                  setState(() {});
                                },
                                child: const Text(
                                  '취소하기',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: kRedColor,
                                  ),
                                ),
                              ),
                      ),
                    );
                  }).toList(),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
