class Movie {
  final String id;
  final String title;
  final DateTime openDate;
  final String director;
  final List actors;
  final int length;
  final String grade;

  Movie({
    required this.id,
    required this.title,
    required this.openDate,
    required this.director,
    required this.actors,
    required this.length,
    required this.grade,
  });

  factory Movie.fromJson(json) => Movie(
        id: json['id'],
        title: json['title'],
        openDate: DateTime.parse(json['openDate']),
        director: json['director'],
        actors: json['actors'],
        length: json['length'],
        grade: json['grade'],
      );
}
