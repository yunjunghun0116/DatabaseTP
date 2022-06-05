import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/movie.dart';
import '../screens/movie_detail_screen.dart';

class MovieListTile extends StatelessWidget {
  final Movie movie;
  const MovieListTile({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  }
}
