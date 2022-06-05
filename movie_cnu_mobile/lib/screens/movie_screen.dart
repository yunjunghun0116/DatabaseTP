import 'package:flutter/material.dart';
import 'package:movie_cnu_mobile/constants.dart';
import 'package:movie_cnu_mobile/controllers/movie_controller.dart';
import 'package:movie_cnu_mobile/screens/movie_detail_screen.dart';
import 'package:movie_cnu_mobile/widgets/movie_list_tile.dart';

import '../models/movie.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  int _statusIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      _statusIndex = 0;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child:  Text(
                      '현재 상영중인 영화',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _statusIndex == 0 ? kBlueColor :kDarkGreyColor,
                      ),
                    ),
                  ),
                ),
                
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      _statusIndex = 1;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child:  Text(
                      '상영 예정인 영화',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _statusIndex == 1 ? kBlueColor :kDarkGreyColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder(
              future: MovieController.to.getRunningMovieList(_statusIndex),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Movie> movieList = snapshot.data as List<Movie>;
                  return ListView(
                    children: movieList.map((Movie movie) {
                    return MovieListTile(movie: movie);
                  }).toList(),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
