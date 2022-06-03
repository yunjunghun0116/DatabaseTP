import 'package:flutter/material.dart';
import 'package:movie_cnu_web/constants.dart';
import 'package:movie_cnu_web/models/movie.dart';
import '../widgets/tab_button.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;
  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        foregroundColor: kBlackColor,
        elevation: 1,
        title: Text(widget.movie.title),
        actions: [
          TextButton(onPressed: () {}, child: Text('상영일정추가')),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('제목 : ${widget.movie.title}'),
            Text('개봉일자 : ${widget.movie.openDate.toString().substring(0, 10)}'),
            Text('감독 : ${widget.movie.director}'),
            Wrap(
              children: [
                const Text('출연배우 : '),
                ...widget.movie.actors.map((e) {
                  return Text('$e ');
                }).toList()
              ],
            ),
            Text('영화길이 : ${widget.movie.length}분'),
            Text('등급 : ${widget.movie.grade}'),
            TabBar(
              controller: _tabController,
              unselectedLabelColor: kGreyColor,
              labelColor: kBlackColor,
              tabs: [
                TabButton(text: '상영관1'),
                TabButton(text: '상영관2'),
                TabButton(text: '상영관3'),
                TabButton(text: '상영관4'),
                TabButton(text: '상영관5'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Container(),
                  Container(),
                  Container(),
                  Container(),
                  Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
