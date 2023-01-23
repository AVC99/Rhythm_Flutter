import 'package:equatable/equatable.dart';
import 'package:rhythm/src/repositories/firestore_error.dart';

abstract class StorageState extends Equatable {
  const StorageState();

  @override
  List<Object> get props => [];
}

class StorageInitialState extends StorageState {
  const StorageInitialState();

  @override
  List<Object> get props => [];
}

class StorageLoadingState extends StorageState {
  const StorageLoadingState();

  @override
  List<Object> get props => [];
}

class StorageSuccessState extends StorageState {
  const StorageSuccessState();

  @override
  List<Object> get props => [];
}

class StorageErrorState extends StorageState {
  final FirestoreQueryError error;

  const StorageErrorState(this.error);

  @override
  List<Object> get props => [error];
}
