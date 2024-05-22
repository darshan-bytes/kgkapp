part of 'collection_bloc.dart';

sealed class CollectionState extends Equatable {
  const CollectionState();
}

final class CollectionInitial extends CollectionState {
  @override
  List<Object> get props => [];
}
