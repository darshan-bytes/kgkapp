part of 'ring_detail_bloc.dart';

sealed class RingDetailEvent extends Equatable {
  const RingDetailEvent();
}

class RingSettingEvent extends RingDetailEvent {
  final bool isSettingOpen;

  const RingSettingEvent({required this.isSettingOpen});

  @override
  List<Object> get props => [isSettingOpen];
}

class RingImagePageChangeEvent extends RingDetailEvent {
  final int index;

  const RingImagePageChangeEvent({required this.index});

  @override
  List<Object> get props => [index];
}
