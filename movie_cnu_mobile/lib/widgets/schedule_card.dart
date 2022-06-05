import 'package:flutter/material.dart';

import '../models/schedule.dart';

class ScheduleCard extends StatelessWidget {
  final Schedule schedule;
  final Function onPressed;
  const ScheduleCard({Key? key, required this.schedule, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ()=>onPressed(),
      title: Text('상영관 : ${schedule.theaterName}'),
      subtitle: Text(
          '상영시간 : ${schedule.movieRunningTime.toString().substring(0, 16)}'),
    );
  }
}
