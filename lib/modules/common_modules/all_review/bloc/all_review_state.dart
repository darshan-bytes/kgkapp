part of 'all_review_bloc.dart';

sealed class AllReviewState extends Equatable {
  const AllReviewState();
}

final class AllReviewInitial extends AllReviewState {
  @override
  List<Object> get props => [];
}

final class ReloadAllReviewState extends AllReviewState {
  const ReloadAllReviewState();

  @override
  List<Object> get props => [];
}

final class AllReviewLoadingState extends AllReviewState {
  const AllReviewLoadingState();

  @override
  List<Object> get props => [];
}

final class AllReviewLoadedState extends AllReviewState {
  const AllReviewLoadedState();

  @override
  List<Object> get props => [];
}

final class AllReviewLoadingMoreState extends AllReviewState {
  const AllReviewLoadingMoreState();

  @override
  List<Object> get props => [];
}

final class AllReviewLoadedMoreState extends AllReviewState {
  const AllReviewLoadedMoreState();

  @override
  List<Object> get props => [];
}
