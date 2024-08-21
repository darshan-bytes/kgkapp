part of 'image_search_bloc.dart';

sealed class ImageSearchEvent extends Equatable {
  const ImageSearchEvent();
}

final class ImageSearchInitialEvent extends ImageSearchEvent {
  @override
  List<Object> get props => [];
}

final class ImageSelectionToggleEvent extends ImageSearchEvent {
  final bool isCameraSelected;

  const ImageSelectionToggleEvent({required this.isCameraSelected});

  @override
  List<Object> get props => [isCameraSelected];
}
