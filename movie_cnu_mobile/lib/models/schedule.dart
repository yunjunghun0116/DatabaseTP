class Schedule {
  final String id;
  final String movieId;
  final String movieTitle;
  final String theaterName;
  final DateTime movieRunningTime;

  Schedule({
    required this.id,
    required this.movieId,
    required this.movieTitle,
    required this.theaterName,
    required this.movieRunningTime,
  });

  factory Schedule.fromJson(json) => Schedule(
    id:json['id'],
    movieId: json['movieId'],
    movieTitle:json['movieTitle'],
    theaterName: json['theaterName'],
    movieRunningTime: DateTime.parse(json['movieRunningTime']),
  );
}
