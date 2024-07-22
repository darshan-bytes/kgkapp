part of 'splash_bloc.dart';

sealed class SplashState extends Equatable {
  const SplashState();
}

final class SplashInitial extends SplashState {
  @override
  List<Object> get props => [];
}

final class SplashVideoInitialized extends SplashState {
  const SplashVideoInitialized();

  @override
  List<Object?> get props => [];
}

final class SplashVideoCompleteState extends SplashState {
  const SplashVideoCompleteState();

  @override
  List<Object?> get props => [];
}
