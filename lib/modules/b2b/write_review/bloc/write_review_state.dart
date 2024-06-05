part of 'write_review_bloc.dart';

sealed class WriteReviewState extends Equatable {
  const WriteReviewState();

  @override
  List<Object> get props => [];
}

final class WriteReviewInitial extends WriteReviewState {
  const WriteReviewInitial();
}

final class WriteReviewReloadState extends WriteReviewState {
  const WriteReviewReloadState();
}

final class PickImageState extends WriteReviewState {
  const PickImageState();
}

final class RemoveSelectedImageState extends WriteReviewState {
  const RemoveSelectedImageState();
}
