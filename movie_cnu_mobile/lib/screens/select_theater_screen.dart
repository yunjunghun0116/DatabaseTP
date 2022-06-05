import 'package:flutter/material.dart';
import 'package:movie_cnu_mobile/models/movie.dart';

import '../constants.dart';
import '../widgets/schedule_result.dart';
import '../widgets/tab_button.dart';

class SelectTheaterScreen extends StatefulWidget {
  final Movie movie;
  const SelectTheaterScreen({Key? key, required this.movie}) : super(key: key);

  @override
  State<SelectTheaterScreen> createState() => _SelectTheaterScreenState();
}

class _SelectTheaterScreenState extends State<SelectTheaterScreen> with TickerProviderStateMixin{

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
      ),
      body: Column(
        children: [
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
                  movie: widget.movie,
                  theaterName: e['name'],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
