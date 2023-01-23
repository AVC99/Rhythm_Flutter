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

  void updateUser(RhythmUser user) async {
    await collection.doc(user.email).update(user.toJson());
  }

  void deleteUser(RhythmUser user) async {
    await collection.doc(user.email).delete();
  }
}
