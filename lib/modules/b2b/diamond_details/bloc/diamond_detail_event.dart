part of 'diamond_detail_bloc.dart';

sealed class DiamondDetailEvent extends Equatable {
  const DiamondDetailEvent();
}

class DiamondDetailInitialEvent extends DiamondDetailEvent {
  final BuildContext context;

  const DiamondDetailInitialEvent({required this.context});

  @override
  List<Object> get props => [context];
}

class DiamondImagePageChangeEvent extends DiamondDetailEvent {
  final int index;

  const DiamondImagePageChangeEvent({required this.index});

  @override
  List<Object> get props => [index];
}
