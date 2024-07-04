part of 'preview_catalogue_bloc.dart';

sealed class PreviewCatalogueState extends Equatable {
  const PreviewCatalogueState();
}

final class PreviewCatalogueInitial extends PreviewCatalogueState {
  const PreviewCatalogueInitial();

  @override
  List<Object> get props => [];
}

final class PreviewCatalogueReloadState extends PreviewCatalogueState {
  const PreviewCatalogueReloadState();

  @override
  List<Object> get props => [];
}

final class PreviewCatalogueLoadingState extends PreviewCatalogueState {
  const PreviewCatalogueLoadingState();

  @override
  List<Object> get props => [];
}

final class PreviewCatalogueErrorState extends PreviewCatalogueState {
  const PreviewCatalogueErrorState();

  @override
  List<Object> get props => [];
}

final class PreviewCatalogueLoadedState extends PreviewCatalogueState {
  const PreviewCatalogueLoadedState();

  @override
  List<Object> get props => [];
}

final class PreviewCataloguePreviousNextPageState extends PreviewCatalogueState {
  final bool isNext;

  const PreviewCataloguePreviousNextPageState(this.isNext);

  @override
  List<Object> get props => [isNext];
}

final class PreviewCatalogueCommentState extends PreviewCatalogueState {
  const PreviewCatalogueCommentState();

  @override
  List<Object> get props => [];
}

final class PreviewCatalogueCommentProductSelectState extends PreviewCatalogueState {
  const PreviewCatalogueCommentProductSelectState();

  @override
  List<Object> get props => [];
}
