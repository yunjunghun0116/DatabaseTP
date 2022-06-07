import 'package:flutter/material.dart';
import 'package:movie_cnu_mobile/constants.dart';
import 'package:movie_cnu_mobile/widgets/movie_list_tile.dart';

import '../models/movie.dart';

class SearchResultScreen extends StatelessWidget {
  final List<Movie> searchResult;
  const SearchResultScreen({Key? key, required this.searchResult})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        foregroundColor: kBlackColor,
        elevation: 1,
        title: const Text('검색결과'),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
            child: const Text(
              '영화목록',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kDarkGreyColor,
              ),
            ),
          ),
          const Divider(),
          ...searchResult.map((movie) {
            return MovieListTile(movie: movie);
          }).toList()
        ],
      ),
    );
  }
}
