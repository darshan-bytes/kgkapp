part of 'splash_bloc.dart';

sealed class SplashEvent extends Equatable {
  const SplashEvent();
}

class LoadSplashEvent extends SplashEvent {
  final BuildContext context;

  const LoadSplashEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
