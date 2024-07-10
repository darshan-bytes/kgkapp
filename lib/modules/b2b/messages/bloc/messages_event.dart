part of 'messages_bloc.dart';

sealed class MessagesEvent extends Equatable {
  const MessagesEvent();
}

class MessagesInitialEvent extends MessagesEvent {
  final BuildContext context;

  const MessagesInitialEvent({required this.context});

  @override
  List<Object> get props => [context];
}

class MessagesLoadMoreEvent extends MessagesEvent {
  final int currentPage;
  final MessagesTab listType;

  const MessagesLoadMoreEvent({required this.currentPage, required this.listType});

  @override
  List<Object> get props => [currentPage, listType];
}

class MessagesTabChangeEvent extends MessagesEvent {
  final int index;

  const MessagesTabChangeEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class MessagesFavouriteToggleEvent extends MessagesEvent {
  final String id;
  final int index;

  const MessagesFavouriteToggleEvent({required this.id, required this.index});

  @override
  List<Object> get props => [id, index];
}
