part of 'exhibition_details_orders_bloc.dart';

sealed class ExhibitionDetailsOrdersState extends Equatable {
  const ExhibitionDetailsOrdersState();
}

final class ExhibitionDetailsOrdersIntial extends ExhibitionDetailsOrdersState {
  @override
  List<Object?> get props => [];
}

final class ExhibitionDetailsOrdersReloadState extends ExhibitionDetailsOrdersState {
  const ExhibitionDetailsOrdersReloadState();

  @override
  List<Object?> get props => [];
}

final class ExhibitionDetailsOrdersLoadedState extends ExhibitionDetailsOrdersState {
  const ExhibitionDetailsOrdersLoadedState();

  @override
  List<Object> get props => [];
}
