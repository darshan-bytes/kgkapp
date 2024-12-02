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

final class PreviewCatalogueLoadedState extends PreviewCatalogueState {
  const PreviewCatalogueLoadedState();

  @override
  List<Object> get props => [];
}
