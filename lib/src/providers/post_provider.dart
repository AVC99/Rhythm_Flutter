import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/src/repositories/posts/posts_repository.dart';

final postRepositoryProvider = Provider<PostsRepository>(
  (ref) => PostsRepository(),
);

