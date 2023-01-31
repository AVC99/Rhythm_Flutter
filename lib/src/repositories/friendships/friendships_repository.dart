import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:rhythm/src/core/resources/constants.dart';
import 'package:rhythm/src/models/rhythm_friendship.dart';

class FriendshipsRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection(kFriendshipsCollection);

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> createFriendship(RhythmFriendship friendship) {
    return collection.add(friendship.toJson());
  }

  Future<RhythmFriendship?> getFriendship(String userA, String userB) async {
    return collection
        .where('sender', isEqualTo: userA)
        .where('receiver', isEqualTo: userB)
        .get()
        .then((query) {
      List<RhythmFriendship> friendships = [];

      for (var element in query.docs) {
        friendships.add(
          RhythmFriendship.fromJson(element.data() as Map<String, dynamic>),
        );
      }

      return friendships.isEmpty ? null : friendships.first;
    });
  }

  Future<void> acceptFriendRequest(String userA, String userB) async {
    await collection
        .where('sender', isEqualTo: userA)
        .where('receiver', isEqualTo: userB)
        .get()
        .then((query) {
      for (var element in query.docs) {
        element.reference.update({
          'isAccepted': true,
        });
      }
    });
  }

  Future<void> deleteFriendRequest(String userA, String userB) async {
    await collection
        .where('sender', isEqualTo: userA)
        .where('receiver', isEqualTo: userB)
        .get()
        .then(
      (query) {
        for (var element in query.docs) {
          element.reference.delete();
        }
      },
    );
  }
}
