class RhythmUser {
  final String? email;
  final String? password;
  final String? firstName;
  final String? lastName;
  final String? username;
  final DateTime? dateOfBirth;
  final String? imageUrl;
  final bool isVerified;
  final DateTime? creationDate;

  const RhythmUser({
    required this.email,
    this.password,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.dateOfBirth,
    required this.imageUrl,
    this.isVerified = false,
    required this.creationDate,
  });

  factory RhythmUser.empty() => const RhythmUser(
        email: '',
        password: '',
        firstName: '',
        lastName: '',
        username: '',
        dateOfBirth: null,
        imageUrl: '',
        isVerified: false,
        creationDate: null,
      );

  factory RhythmUser.fromJson(Map<String, dynamic> json) => RhythmUser(
        email: json['email'] ?? '',
        firstName: json['firstName'] ?? '',
        lastName: json['lastName'] ?? '',
        username: json['username'] ?? '',
        dateOfBirth: json['dateOfBirth'],
        imageUrl: json['imageUrl'] ?? '',
        isVerified: json['isVerified'] ?? false,
        creationDate: json['creationDate'],
      );

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'dateOfBirth': dateOfBirth,
      'imageUrl': imageUrl,
      'isVerified': isVerified,
      'creationDate': creationDate,
    };
  }
}
