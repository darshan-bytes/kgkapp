part of 'message_detail_bloc.dart';

sealed class MessageDetailEvent extends Equatable {
  const MessageDetailEvent();
}

class MessageDetailInitialEvent extends MessageDetailEvent {
  final BuildContext context;

  const MessageDetailInitialEvent({required this.context});

  @override
  List<Object> get props => [context];
}

class MessageShowFullMessageEvent extends MessageDetailEvent {
  final int index;

  final bool isExpanded;

  const MessageShowFullMessageEvent({required this.index, required this.isExpanded});

  @override
  List<Object> get props => [index, isExpanded];
}
