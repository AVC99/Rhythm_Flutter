class UserEntity {
  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String dateOfBirth;
  final String imageUrl;

  UserEntity({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dateOfBirth,
    required this.imageUrl,
  });

  factory UserEntity.empty() => UserEntity(
    id: '',
    username: '',
    firstName: '',
    lastName: '',
    email: '',
    dateOfBirth: '',
    imageUrl: '',
  );

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
    id: json['id'] ?? '',
    firstName: json['firstName'] ?? '',
    lastName: json['lastName'] ?? '',
    email: json['email'] ?? '',
    username: json['username'] ?? '',
    dateOfBirth: json['dateOfBirth'] ?? '',
    imageUrl: json['imageUrl'] ?? '',
  );
}
