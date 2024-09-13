part of 'diamond_info_popup_bloc.dart';

sealed class DiamondInfoPopupEvent extends Equatable {
  const DiamondInfoPopupEvent();

  @override
  List<Object> get props => [];
}

final class DiamondInfoPopupInitialEvent extends DiamondInfoPopupEvent {
  final BuildContext context;

  const DiamondInfoPopupInitialEvent(this.context);

  @override
  List<Object> get props => [context];
}
