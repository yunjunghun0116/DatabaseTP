class Schedule {
  final String id;
  final String movieId;
  final String theaterName;
  final DateTime movieRunningTime;

  Schedule({
    required this.id,
    required this.movieId,
    required this.theaterName,
    required this.movieRunningTime,
  });

  factory Schedule.fromJson(json) => Schedule(
    id:json['id'],
    movieId: json['movieId'],
    theaterName: json['theaterName'],
    movieRunningTime: DateTime.parse(json['movieRunningTime']),
  );
}
