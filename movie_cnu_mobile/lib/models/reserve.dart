class Reserve {
  final String id;
  final String theaterName;
  final String userName;
  final String userId;
  final String scheduleId;
  final String movieId;
  final int userCount;
  final bool isCanceled;
  final DateTime reservedTime;

  Reserve({
    required this.id,
    required this.theaterName,
    required this.userName,
    required this.userId,
    required this.scheduleId,
    required this.movieId,
    required this.userCount,
    required this.isCanceled,
    required this.reservedTime,
  });

  factory Reserve.fromJson(json) => Reserve(
        id: json['id'],
        theaterName: json['theaterName'],
        userName: json['userName'],
        userId: json['userId'],
        scheduleId: json['scheduleId'],
        movieId: json['movieId'],
        userCount: json['userCount'],
        isCanceled: json['isCanceled'],
        reservedTime: DateTime.parse(json['reservedTime']),
      );
}
