import 'package:flutter/material.dart';

import '../models/schedule.dart';

class ScheduleCard extends StatelessWidget {
  final Schedule schedule;
  const ScheduleCard({Key? key, required this.schedule}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('상영관 : ${schedule.theaterName}'),
          Text(
              '상영시간 : ${schedule.movieRunningTime.toString().substring(0, 16)}'),
        ],
      ),
    );
  }
}
