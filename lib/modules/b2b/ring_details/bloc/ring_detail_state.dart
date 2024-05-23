part of 'ring_detail_bloc.dart';

sealed class RingDetailState extends Equatable {
  const RingDetailState();
}

final class RingDetailInitial extends RingDetailState {
  @override
  List<Object> get props => [];
}

final class RingSettingState extends RingDetailState {
  @override
  List<Object> get props => [];
}

final class RingImagePageChangeState extends RingDetailState {
  @override
  List<Object> get props => [];
}
