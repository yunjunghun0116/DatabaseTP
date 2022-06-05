import 'package:flutter/material.dart';
import 'package:movie_cnu_mobile/controllers/movie_controller.dart';
import 'package:movie_cnu_mobile/screens/select_theater_screen.dart';
import '../constants.dart';
import '../models/movie.dart';

class MovieListTile extends StatelessWidget {
  final Movie movie;
  const MovieListTile({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SelectTheaterScreen(movie: movie);
        }));
      },
      title: Text(
        movie.title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              style: const TextStyle(color: kDarkGreyColor),
              children: [
                const TextSpan(text: '출연진 : '),
                ...movie.actors.map((e) {
                  return TextSpan(text: '$e ');
                }).toList()
              ],
            ),
          ),
          Text('개봉일자 : ${movie.openDate.toString().substring(0, 10)}'),
          Row(
            children: [
              FutureBuilder(
                future: MovieController.to.reservedMovieCount(movie.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    int count = snapshot.data as int;
                    return Text('예매자수 : $count명');
                  }
                  return const Text('예매자수 : 0명 ');
                },
              ),
              FutureBuilder(
                future: MovieController.to.reservedMovieCount(movie.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    int count = snapshot.data as int;
                    if (count > 0) {
                      return Text(', 누적 관객수 : $count명');
                    }
                  }
                  return const Text('');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
