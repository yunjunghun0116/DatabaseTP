import 'package:flutter/material.dart';
import 'package:movie_cnu_mobile/constants.dart';
import 'package:movie_cnu_mobile/models/movie.dart';
import 'package:movie_cnu_mobile/screens/select_theater_screen.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;
  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        foregroundColor: kBlackColor,
        elevation: 1,
        title: Text(movie.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('제목 : ${movie.title}'),
            Text('개봉일자 : ${movie.openDate.toString().substring(0, 10)}'),
            Text('감독 : ${movie.director}'),
            Wrap(
              children: [
                const Text('출연배우 : '),
                ...movie.actors.map((e) {
                  return Text('$e ');
                }).toList()
              ],
            ),
            Text('영화길이 : ${movie.length}분'),
            Text('등급 : ${movie.grade}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return SelectTheaterScreen(movie: movie);
          }));
        },
        child: const Text('예매'),
      ),
    );

  }
}
