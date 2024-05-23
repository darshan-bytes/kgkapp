part of 'diamond_detail_bloc.dart';

sealed class DiamondDetailEvent extends Equatable {
  const DiamondDetailEvent();
}

class DiamondImagePageChangeEvent extends DiamondDetailEvent {
  final int index;

  const DiamondImagePageChangeEvent({required this.index});

  @override
  List<Object> get props => [index];
}
