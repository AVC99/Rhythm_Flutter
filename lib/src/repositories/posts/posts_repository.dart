import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rhythm/src/models/post.dart';
import 'package:rhythm/src/models/rhythm_user.dart';

import '../../core/resources/constants.dart';

class PostsRepository {
  final CollectionReference collection =
  FirebaseFirestore.instance.collection(kPostsCollection);

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<void> createPost(Post post) async {
    collection.add(post.toJson());
  }

  Future<List<Post>> getPostsFromUser(String username) async {
    return collection
        .where('username', isEqualTo: username)
        .get()
        .then((query) {
      List<Post> posts = [];
      for (var element in query.docs) {
        posts.add(
          Post.fromJson(element.data() as Map<String, dynamic>),
        );
      }
      return posts;
    });
  }

  Future<List<Post>> getUserFeed(String email) async {
    List<Post> posts = [];
    final CollectionReference usersCollection =
    FirebaseFirestore.instance.collection(kUsersCollection);
    final user = await usersCollection.where('email', isEqualTo: email).get().then((
        value,) {
      return RhythmUser.fromJson(value.docs.first.data() as Map<String, dynamic>);
    });
    for (var element in user.friends) {
      posts.addAll(await getPostsFromUser(element));
    }
    return posts;
  }


}
