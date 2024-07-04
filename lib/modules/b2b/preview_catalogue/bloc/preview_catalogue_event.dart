part of 'preview_catalogue_bloc.dart';

sealed class PreviewCatalogueEvent extends Equatable {
  const PreviewCatalogueEvent();
}

final class InitialPreviewCatalogueEvent extends PreviewCatalogueEvent {
  final BuildContext context;

  const InitialPreviewCatalogueEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class PreviewCataloguePreviousNextPageEvent extends PreviewCatalogueEvent {
  final bool isNext;

  const PreviewCataloguePreviousNextPageEvent(this.isNext);

  @override
  List<Object> get props => [isNext];
}

final class PreviewCatalogueCommentEvent extends PreviewCatalogueEvent {
  const PreviewCatalogueCommentEvent();

  @override
  List<Object> get props => [];
}

final class PreviewCatalogueCommentProductSelectEvent extends PreviewCatalogueEvent {
  final int index;

  const PreviewCatalogueCommentProductSelectEvent({required this.index});

  @override
  List<Object> get props => [index];
}
