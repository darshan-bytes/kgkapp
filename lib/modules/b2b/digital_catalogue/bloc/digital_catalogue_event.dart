part of 'digital_catalogue_bloc.dart';

sealed class DigitalCatalogueEvent extends Equatable {
  const DigitalCatalogueEvent();
}

final class DigitalCatalogueInitialEvent extends DigitalCatalogueEvent {
  const DigitalCatalogueInitialEvent();

  @override
  List<Object> get props => [];
}
