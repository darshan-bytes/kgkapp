part of 'splash_bloc.dart';

sealed class SplashState extends Equatable {
  const SplashState();
}

final class SplashInitialState extends SplashState {
  @override
  List<Object?> get props => [];
}

class SplashLoadedState extends SplashState {
  @override
  List<Object?> get props => [];
}
