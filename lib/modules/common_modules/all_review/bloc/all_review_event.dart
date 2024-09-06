part of 'all_review_bloc.dart';

sealed class AllReviewEvent extends Equatable {
  const AllReviewEvent();
}

final class AllReviewInitialEvent extends AllReviewEvent {
  final BuildContext context;

  const AllReviewInitialEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class AllReviewLoadMoreEvent extends AllReviewEvent {
  final int currentPage;
  final BuildContext context;

  const AllReviewLoadMoreEvent(this.currentPage, this.context);

  @override
  List<Object> get props => [currentPage, context];
}
