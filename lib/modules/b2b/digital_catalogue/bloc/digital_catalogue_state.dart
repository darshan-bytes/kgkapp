part of 'digital_catalogue_bloc.dart';

sealed class DigitalCatalogueState extends Equatable {
  const DigitalCatalogueState();
}

final class DigitalCatalogueIntial extends DigitalCatalogueState {
  @override
  List<Object?> get props => [];
}

final class DigitalCatalogueReloadState extends DigitalCatalogueState {
  const DigitalCatalogueReloadState();

  @override
  List<Object?> get props => [];
}

final class DigitalCatalogueLoadedState extends DigitalCatalogueState {
  const DigitalCatalogueLoadedState();

  @override
  List<Object> get props => [];
}
