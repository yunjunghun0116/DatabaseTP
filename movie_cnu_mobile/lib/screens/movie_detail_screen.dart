import 'package:flutter/material.dart';
import 'package:movie_cnu_mobile/constants.dart';
import 'package:movie_cnu_mobile/models/movie.dart';

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
    );

  }
}
