part of 'digital_catalogue_bloc.dart';

sealed class DigitalCatalogueEvent extends Equatable {
  const DigitalCatalogueEvent();
}

final class DigitalCatalogueInitialEvent extends DigitalCatalogueEvent {
  final BuildContext context;

  const DigitalCatalogueInitialEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class DigitalCataloguePullToRefreshEvent extends DigitalCatalogueEvent {
  const DigitalCataloguePullToRefreshEvent();

  @override
  List<Object> get props => [];
}

final class DigitalCatalogueLoadMoreEvent extends DigitalCatalogueEvent {
  final BuildContext context;
  final int currentPage;

  const DigitalCatalogueLoadMoreEvent({required this.context, required this.currentPage});

  @override
  List<Object> get props => [context, currentPage];
}

final class DigitalCatalogueSearchEvent extends DigitalCatalogueEvent {
  final BuildContext context;

  const DigitalCatalogueSearchEvent({required this.context});

  @override
  List<Object> get props => [context];
}
