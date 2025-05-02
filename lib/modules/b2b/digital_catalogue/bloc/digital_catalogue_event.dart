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
  final BuildContext context;

  const DigitalCataloguePullToRefreshEvent({required this.context});

  @override
  List<Object> get props => [context];
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

final class DigitalCatalogueFilterEvent extends DigitalCatalogueEvent {
  final BuildContext context;
  final List<FilterData> filterData;

  const DigitalCatalogueFilterEvent({required this.context, required this.filterData});

  @override
  List<Object> get props => [context, filterData];
}

final class DigitalCatalogueShareEvent extends DigitalCatalogueEvent {
  final BuildContext context;
  final int index;

  const DigitalCatalogueShareEvent({required this.context, required this.index});

  @override
  List<Object> get props => [context, index];
}

final class DeleteDigitalCatalogueEvent extends DigitalCatalogueEvent {
  final BuildContext context;
  final String catalogueId;

  const DeleteDigitalCatalogueEvent({required this.context, required this.catalogueId});

  @override
  List<Object> get props => [context, catalogueId];
}
