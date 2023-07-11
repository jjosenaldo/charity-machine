class User {
  User({required this.id});

  factory User.empty() => User(id: '');

  final String id;
}
