import 'package:equatable/equatable.dart';

import 'package:rhythm/src/repositories/spotify/spotify_error.dart';

abstract class SpotifyState extends Equatable {
  const SpotifyState();

  @override
  List<Object> get props => [];
}

class SpotifyInitialState extends SpotifyState {
  const SpotifyInitialState();

  @override
  List<Object> get props => [];
}

class SpotifyLoadingState extends SpotifyState {
  const SpotifyLoadingState();

  @override
  List<Object> get props => [];
}

class SpotifySuccessState extends SpotifyState {
  const SpotifySuccessState();

  @override
  List<Object> get props => [];
}

class SpotifyErrorState extends SpotifyState {
  final SpotifyError error;

  const SpotifyErrorState(this.error);

  @override
  List<Object> get props => [error];
}
