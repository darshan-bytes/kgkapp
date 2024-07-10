part of 'newsletter_bloc.dart';

sealed class NewsletterState extends Equatable {
  const NewsletterState();
}

final class NewsletterInitialState extends NewsletterState {
  const NewsletterInitialState();

  @override
  List<Object> get props => [];
}

final class NewsletterReloadState extends NewsletterState {
  const NewsletterReloadState();

  @override
  List<Object> get props => [];
}

final class ChangeNewsletterTabsState extends NewsletterState {
  const ChangeNewsletterTabsState();

  @override
  List<Object> get props => [];
}

class NewsletterLoadingMoreState extends NewsletterState {
  final NewsletterTab listType;

  const NewsletterLoadingMoreState(this.listType);

  @override
  List<Object> get props => [listType];
}

class NewsletterListLoadedState extends NewsletterState {
  const NewsletterListLoadedState();

  @override
  List<Object> get props => [];
}

class NewsletterListLoadedMoreState extends NewsletterState {
  final int currentPage;
  final NewsletterTab listType;

  const NewsletterListLoadedMoreState(this.currentPage, this.listType);

  @override
  List<Object> get props => [currentPage, listType];
}
