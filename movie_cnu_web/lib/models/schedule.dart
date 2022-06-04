class Schedule {
  final String movieId;
  final String theaterName;
  final DateTime movieRunningTime;

  Schedule({
    required this.movieId,
    required this.theaterName,
    required this.movieRunningTime,
  });

  factory Schedule.fromJson(json) => Schedule(
        movieId: json['movieId'],
        theaterName: json['theaterName'],
        movieRunningTime: DateTime.parse(json['movieRunningTime']),
      );
}
