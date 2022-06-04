import 'package:flutter/material.dart';
import 'package:movie_cnu_web/constants.dart';
import 'package:movie_cnu_web/models/movie.dart';
import 'package:movie_cnu_web/screens/add_schedule_screen.dart';
import 'package:movie_cnu_web/widgets/schedule_result.dart';
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
          TextButton(
              onPressed: () async {
                bool? result = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return AddScheduleScreen(movie: widget.movie);
                }));
                if (result != null && result) {
                  setState(() {});
                }
              },
              child: const Text('상영일정추가')),
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
              tabs: kTheaterList.map((e) {
                return TabButton(text: e['name']);
              }).toList(),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: kTheaterList.map((e) {
                  return ScheduleResult(
                    movieId: widget.movie.id,
                    theaterName: e['name'],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
