part of 'diamond_info_popup_bloc.dart';

sealed class DiamondInfoPopupState extends Equatable {
  const DiamondInfoPopupState();
}

final class DiamondInfoPopupInitial extends DiamondInfoPopupState {
  const DiamondInfoPopupInitial();

  @override
  List<Object> get props => [];
}

final class DiamondInfoPopupLoading extends DiamondInfoPopupState {
  const DiamondInfoPopupLoading();

  @override
  List<Object> get props => [];
}

final class DiamondInfoPopupLoaded extends DiamondInfoPopupState {
  const DiamondInfoPopupLoaded();

  @override
  List<Object> get props => [];
}
