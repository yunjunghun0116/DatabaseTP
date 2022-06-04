class User {
  final String id;
  final String email;
  final String password;
  final String name;
  final DateTime birthDate;
  final String gender;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.birthDate,
    required this.gender,
  });

  factory User.fromJson(json) => User(
        id: json['id'],
        email: json['email'],
        password: json['password'],
        name: json['name'],
        birthDate: DateTime.parse(json['birthDate']),
        gender: json['gender'],
      );
}
