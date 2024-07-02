part of 'exhibition_details_orders_bloc.dart';

sealed class ExhibitionDetailsOrdersEvent extends Equatable {
  const ExhibitionDetailsOrdersEvent();
}

final class ExhibitionDetailsOrdersInitialEvent extends ExhibitionDetailsOrdersEvent {
  const ExhibitionDetailsOrdersInitialEvent();

  @override
  List<Object> get props => [];
}
