part of 'message_detail_bloc.dart';

sealed class MessageDetailState extends Equatable {
  const MessageDetailState();
}

final class MessageDetailInitial extends MessageDetailState {
  @override
  List<Object> get props => [];
}

final class MessageReloadState extends MessageDetailState {
  const MessageReloadState();

  @override
  List<Object> get props => [];
}

final class MessageDetailLoadedState extends MessageDetailState {
  const MessageDetailLoadedState();

  @override
  List<Object> get props => [];
}

final class MessageShowFullMessageState extends MessageDetailState {
  final int index;
  final int oldIndex;
  final bool isExpanded;

  const MessageShowFullMessageState(this.index, this.oldIndex, this.isExpanded);

  @override
  List<Object> get props => [index, oldIndex, isExpanded];
}
