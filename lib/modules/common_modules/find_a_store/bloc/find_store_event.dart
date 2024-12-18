part of 'find_store_bloc.dart';

sealed class FindStoreEvent extends Equatable {
  const FindStoreEvent();
}

class FindStoreInitialEvent extends FindStoreEvent {
  final BuildContext context;

  const FindStoreInitialEvent({required this.context});
  @override
  List<Object> get props => [context];
}

class FindStoreShowFullAddressEvent extends FindStoreEvent {
  final int index;
  final BuildContext context;

  final bool isExpanded;

  const FindStoreShowFullAddressEvent({required this.context, required this.index, required this.isExpanded});

  @override
  List<Object> get props => [index, isExpanded];
}

class FindRetailStoreEvent extends FindStoreEvent {
  final bool useCurrentLocation;
  final BuildContext context;

  const FindRetailStoreEvent({required this.context, this.useCurrentLocation = false});

  @override
  List<Object> get props => [context, useCurrentLocation];
}

class GetDirectionEvent extends FindStoreEvent {
  final double latitude;
  final double longitude;

  const GetDirectionEvent({required this.latitude, required this.longitude});

  @override
  List<Object> get props => [latitude, longitude];
}
