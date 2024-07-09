part of 'messages_bloc.dart';

sealed class MessagesState extends Equatable {
  const MessagesState();
}

final class MessagesInitial extends MessagesState {
  @override
  List<Object> get props => [];
}

final class MessagesReloadState extends MessagesState {
  const MessagesReloadState();

  @override
  List<Object> get props => [];
}

final class MessagesLoadedState extends MessagesState {
  const MessagesLoadedState();

  @override
  List<Object> get props => [];
}

final class MessagesLoadedMoreState extends MessagesState {
  final int currentPage;
  final MessagesTab listType;

  const MessagesLoadedMoreState({required this.currentPage, required this.listType});

  @override
  List<Object> get props => [currentPage, listType];
}

final class MessagesLoadingMoreState extends MessagesState {
  final MessagesTab listType;

  const MessagesLoadingMoreState({required this.listType});

  @override
  List<Object> get props => [listType];
}

final class MessagesLoadMoreState extends MessagesState {
  final int currentPage;
  final MessagesTab listType;

  const MessagesLoadMoreState({required this.currentPage, required this.listType});

  @override
  List<Object> get props => [currentPage, listType];
}

final class MessagesOnTabChangedState extends MessagesState {
  const MessagesOnTabChangedState();

  @override
  List<Object> get props => [];
}
