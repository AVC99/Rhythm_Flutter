import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:rhythm/src/core/resources/constants.dart';
import 'package:rhythm/src/models/rhythm_user.dart';

class UsersRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection(kUsersCollection);

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<List<DocumentSnapshot>> getUserByEmail(String email) async {
    return await collection
        .where('email', isEqualTo: email)
        .get()
        .then((query) {
      List<DocumentSnapshot> results = [];

      for (var doc in query.docs) {
        results.add(doc);
      }

      return results;
    });
  }

  Future<List<DocumentSnapshot>> getUserByUsername(String username) async {
    return await collection
        .where('username', isEqualTo: username)
        .get()
        .then((query) {
      List<DocumentSnapshot> results = [];

      for (var doc in query.docs) {
        results.add(doc);
      }

      return results;
    });
  }

  Future<DocumentReference> addUser(RhythmUser user) {
    return collection.add(user.toJson());
  }

  Future<void> updateUser(RhythmUser user) async {
    await collection.where('email', isEqualTo: user.email).get().then((query) {
      for (var element in query.docs) {
        element.reference.update(user.toJson());
      }
    });
  }

  Future<void> deleteUser(RhythmUser user) async {
    await collection.where('email', isEqualTo: user.email).get().then((query) {
      for (var element in query.docs) {
        element.reference.delete();
      }
    });
  }
}
