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
