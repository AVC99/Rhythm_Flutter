import 'package:cloud_firestore/cloud_firestore.dart';

class RhythmFriendship {
  final String sender;
  final String receiver;
  final bool isAccepted;
  final DateTime? creationDate;

  RhythmFriendship({
    required this.sender,
    required this.receiver,
    this.isAccepted = false,
    required this.creationDate,
  });

  factory RhythmFriendship.empty() => RhythmFriendship(
        sender: '',
        receiver: '',
        isAccepted: false,
        creationDate: null,
      );

  factory RhythmFriendship.fromJson(Map<String, dynamic> json) =>
      RhythmFriendship(
        sender: json['sender'] ?? '',
        receiver: json['receiver'] ?? '',
        isAccepted: json['isAccepted'] ?? false,
        creationDate: (json['creationDate'] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'receiver': receiver,
      'isAccepted': isAccepted,
      'creationDate': creationDate,
    };
  }
}
