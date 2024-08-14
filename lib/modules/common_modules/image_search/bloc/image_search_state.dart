part of 'image_search_bloc.dart';

sealed class ImageSearchState extends Equatable {
  const ImageSearchState();
}

final class ImageSearchInitial extends ImageSearchState {
  const ImageSearchInitial();

  @override
  List<Object> get props => [];
}

final class ImageSearchReloadState extends ImageSearchState {
  const ImageSearchReloadState();

  @override
  List<Object> get props => [];
}

final class ImageSelectionToggleState extends ImageSearchState {
  const ImageSelectionToggleState();

  @override
  List<Object> get props => [];
}
