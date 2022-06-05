import 'package:flutter/material.dart';
import 'package:movie_cnu_mobile/constants.dart';
import 'package:movie_cnu_mobile/controllers/movie_controller.dart';
import 'package:movie_cnu_mobile/screens/movie_detail_screen.dart';

import '../models/movie.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: MovieController.to.getRunningMovieList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Movie> movieList = snapshot.data as List<Movie>;
            return ListView(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: const Text(
                    '현재 상영중인 영화',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: kDarkGreyColor,
                    ),
                  ),
                ),
                ...movieList.map((Movie movie) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return MovieDetailScreen(movie: movie);
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
                        Text(
                            '개봉일자 : ${movie.openDate.toString().substring(0, 10)}'),
                      ],
                    ),
                  );
                }).toList()
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
