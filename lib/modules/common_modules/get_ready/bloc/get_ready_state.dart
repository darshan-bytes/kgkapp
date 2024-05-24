part of 'get_ready_bloc.dart';

sealed class GetReadyState extends Equatable {
  const GetReadyState();
}

final class GetReadyInitialState extends GetReadyState {
  @override
  List<Object?> get props => [];
}

class GetReadyLoadedState extends GetReadyState {
  @override
  List<Object?> get props => [];
}
