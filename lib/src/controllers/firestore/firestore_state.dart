import 'package:equatable/equatable.dart';

import 'package:rhythm/src/repositories/firestore_error.dart';
import 'package:rhythm/src/repositories/friendships/friendships_error.dart';
import 'package:rhythm/src/repositories/users/user_error.dart';

abstract class FirestoreQueryState extends Equatable {
  const FirestoreQueryState();

  @override
  List<Object> get props => [];
}

class FirestoreQueryInitialState extends FirestoreQueryState {
  const FirestoreQueryInitialState();

  @override
  List<Object> get props => [];
}

class FirestoreQueryLoadingState extends FirestoreQueryState {
  const FirestoreQueryLoadingState();

  @override
  List<Object> get props => [];
}

class FirestoreQuerySuccessState extends FirestoreQueryState {
  const FirestoreQuerySuccessState();

  @override
  List<Object> get props => [];
}

class FirestoreQueryErrorState extends FirestoreQueryState {
  final FirestoreQueryError error;

  const FirestoreQueryErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class FirestoreUsersDataErrorState extends FirestoreQueryState {
  final UserDataError error;

  const FirestoreUsersDataErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class FirestoreFriendshipsDataErrorState extends FirestoreQueryState {
  final FriendshipDataError error;

  const FirestoreFriendshipsDataErrorState(this.error);

  @override
  List<Object> get props => [error];
}
