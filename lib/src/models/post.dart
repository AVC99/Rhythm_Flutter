import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String username;
  final String artist;
  final String userImageUrl;
  final String postImageUrl;
  final String previewUrl;
  final String coverUrl;
  final DateTime? creationDate;

  Post({
    required this.username,
    required this.artist,
    required this.userImageUrl,
    required this.postImageUrl,
    required this.previewUrl,
    required this.coverUrl,
    required this.creationDate,
  });

  factory Post.empty() => Post(
        username: '',
        artist: '',
        userImageUrl: '',
        postImageUrl: '',
        previewUrl: '',
        coverUrl: '',
        creationDate: null,
      );

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        username: json['username'] ?? '',
        artist: json['artist'] ?? '',
        userImageUrl: json['userImageUrl'] ?? '',
        postImageUrl: json['postImageUrl'] ?? '',
        previewUrl: json['previewUrl'] ?? '',
        coverUrl: json['coverUrl'] ?? '',
        creationDate: (json['creationDate'] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'artist': artist,
      'userImageUrl': userImageUrl,
      'postImageUrl': postImageUrl,
      'previewUrl': previewUrl,
      'coverUrl': coverUrl,
      'creationDate': creationDate,
    };
  }
}
