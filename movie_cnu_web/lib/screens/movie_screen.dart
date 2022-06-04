import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_cnu_web/constants.dart';
import 'package:movie_cnu_web/controllers/movie_controller.dart';
import 'package:movie_cnu_web/screens/upload_movie_screen.dart';
import 'package:movie_cnu_web/widgets/movie_card.dart';

import '../models/movie.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const UploadMovieScreen();
                  }));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: kBlackColor),
                  ),
                  child: const Text('영화추가'),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: FutureBuilder(
                future: MovieController.to.getRunningMovieList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Movie> movieList = snapshot.data as List<Movie>;
                    return GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: movieList.map((Movie movie) {
                        return MovieCard(movie: movie);
                      }).toList(),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
