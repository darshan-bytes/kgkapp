part of 'newsletter_bloc.dart';

sealed class NewsletterEvent extends Equatable {
  const NewsletterEvent();
}

final class NewsletterInitialEvent extends NewsletterEvent {
  final BuildContext context;

  const NewsletterInitialEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class ChangeNewsletterTabsEvent extends NewsletterEvent {
  const ChangeNewsletterTabsEvent();

  @override
  List<Object> get props => [];
}

class NewsletterListingLoadMoreEvent extends NewsletterEvent {
  final int currentPage;
  final NewsletterTab listType;

  const NewsletterListingLoadMoreEvent({required this.currentPage, required this.listType});

  @override
  List<Object> get props => [currentPage, listType];
}
