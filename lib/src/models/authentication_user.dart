class AuthenticationUser {
  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String dateOfBirth;
  final String imageUrl;

  AuthenticationUser({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dateOfBirth,
    required this.imageUrl,
  });

  factory AuthenticationUser.empty() => AuthenticationUser(
    id: '',
    username: '',
    firstName: '',
    lastName: '',
    email: '',
    dateOfBirth: '',
    imageUrl: '',
  );

  factory AuthenticationUser.fromJson(Map<String, dynamic> json) => AuthenticationUser(
    id: json['id'] ?? '',
    firstName: json['firstName'] ?? '',
    lastName: json['lastName'] ?? '',
    email: json['email'] ?? '',
    username: json['username'] ?? '',
    dateOfBirth: json['dateOfBirth'] ?? '',
    imageUrl: json['imageUrl'] ?? '',
  );
}
