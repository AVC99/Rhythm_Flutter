import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/src/repositories/posts/posts_repository.dart';

import '../controllers/firestore/users_controller.dart';
import '../models/post.dart';

final postRepositoryProvider = Provider<PostsRepository>(
  (ref) => PostsRepository(),
);

final userPostProvider = FutureProvider.family<List<Post>, String>((ref, username) async {
  return await ref
      .read(postRepositoryProvider)
      .getPostsFromUser(username);
});

final postFeedProvider = FutureProvider<List<Post>>((ref) async {
  return await ref
      .read(postRepositoryProvider)
      .getUserFeed(FirebaseAuth.instance.currentUser!.email!);
});
