part of 'get_ready_bloc.dart';

sealed class GetReadyEvent extends Equatable {
  const GetReadyEvent();
}

class LoadGetReadyEvent extends GetReadyEvent {
  final BuildContext context;

  const LoadGetReadyEvent({required this.context});

  @override
  List<Object?> get props => [];
}
