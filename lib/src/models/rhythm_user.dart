import 'package:cloud_firestore/cloud_firestore.dart';

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
  String? spotifyId;

  RhythmUser({
    required this.email,
    this.password,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.dateOfBirth,
    required this.imageUrl,
    this.isVerified = false,
    required this.creationDate,
    this.spotifyId = '',
  });

  factory RhythmUser.empty() => RhythmUser(
    email: '',
    password: '',
    firstName: '',
    lastName: '',
    username: '',
    dateOfBirth: null,
    imageUrl: '',
    isVerified: false,
    creationDate: null,
    spotifyId: '',
  );

  factory RhythmUser.fromJson(Map<String, dynamic> json) => RhythmUser(
    email: json['email'] ?? '',
    firstName: json['firstName'] ?? '',
    lastName: json['lastName'] ?? '',
    username: json['username'] ?? '',
    dateOfBirth: (json['dateOfBirth'] as Timestamp).toDate(),
    imageUrl: json['imageUrl'] ?? '',
    isVerified: json['isVerified'] ?? false,
    creationDate: (json['creationDate'] as Timestamp).toDate(),
    spotifyId: json['spotifyId'] ?? '',
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
      'spotifyId': spotifyId,
    };
  }
}
