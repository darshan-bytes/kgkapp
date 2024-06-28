part of 'find_store_bloc.dart';

sealed class FindStoreEvent extends Equatable {
  const FindStoreEvent();
}

class FindStoreInitialEvent extends FindStoreEvent {
  @override
  List<Object> get props => [];
}

class FindStoreShowFullAddressEvent extends FindStoreEvent {
  final int index;

  final bool isExpanded;

  const FindStoreShowFullAddressEvent({required this.index, required this.isExpanded});

  @override
  List<Object> get props => [index, isExpanded];
}
