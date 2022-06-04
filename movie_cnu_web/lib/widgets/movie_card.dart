import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:movie_cnu_web/constants.dart';
import 'package:movie_cnu_web/screens/movie_detail_screen.dart';
import '../models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context){
        return MovieDetailScreen(movie: movie);
      })),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: kGreyColor),
          borderRadius: BorderRadius.circular(5),
        ),
        child: ListView(
          children: [
            Text('제목 : ${movie.title}'),
            Text('개봉일자 : ${movie.openDate.toString().substring(0, 10)}'),
            Text('감독 : ${movie.director}'),
            Text('영화길이 : ${movie.length}분'),
            Text('등급 : ${movie.grade}'),
          ],
        ),
      ),
    );
  }
}
