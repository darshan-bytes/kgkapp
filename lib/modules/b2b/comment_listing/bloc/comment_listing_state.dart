part of 'comment_listing_bloc.dart';

sealed class CommentListingState extends Equatable {
  const CommentListingState();

  @override
  List<Object> get props => [];
}

final class CommentListingInitial extends CommentListingState {}

final class CommentListingLoadedState extends CommentListingState {}

final class CommentListingReloadState extends CommentListingState {}

final class CatalogueCommentState extends CommentListingState {}

final class CommentAddedSuccessState extends CommentListingState {}

final class CommentLoadingState extends CommentListingState {}
