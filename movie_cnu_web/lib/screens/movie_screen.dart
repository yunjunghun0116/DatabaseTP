import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_cnu_web/constants.dart';
import 'package:movie_cnu_web/controllers/movie_controller.dart';
import 'package:movie_cnu_web/screens/upload_movie_screen.dart';

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
            return Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: ()  {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return const UploadMovieScreen();
                        }));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
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
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
