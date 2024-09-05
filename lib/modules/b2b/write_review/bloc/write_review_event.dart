part of 'write_review_bloc.dart';

sealed class WriteReviewEvent extends Equatable {
  const WriteReviewEvent();

  @override
  List<Object> get props => [];
}

final class WriteReviewInitialEvent extends WriteReviewEvent {
  final BuildContext context;

  const WriteReviewInitialEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class PickImageEvent extends WriteReviewEvent {
  final ImageSource imageSource;

  const PickImageEvent({required this.imageSource});

  @override
  List<Object> get props => [imageSource];
}

final class RemoveSelectedImageEvent extends WriteReviewEvent {
  final int selectedImage;

  const RemoveSelectedImageEvent({required this.selectedImage});

  @override
  List<Object> get props => [selectedImage];
}

final class WriteReviewResetEvent extends WriteReviewEvent {
  const WriteReviewResetEvent();

  @override
  List<Object> get props => [];
}

final class WriteReviewSubmitEvent extends WriteReviewEvent {
  final BuildContext context;

  const WriteReviewSubmitEvent(this.context);

  @override
  List<Object> get props => [context];
}
