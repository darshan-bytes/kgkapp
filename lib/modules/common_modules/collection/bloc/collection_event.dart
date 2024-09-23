part of 'collection_bloc.dart';

sealed class CollectionEvent extends Equatable {
  const CollectionEvent();
}

final class CollectionInitialEvent extends CollectionEvent {
  final BuildContext context;

  const CollectionInitialEvent({required this.context});

  @override
  List<Object> get props => [context];
}
