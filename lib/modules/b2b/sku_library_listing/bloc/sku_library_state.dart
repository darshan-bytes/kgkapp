
part of 'sku_library_bloc.dart';

sealed class SkuLibraryState extends Equatable {
  const SkuLibraryState();
}

final class SkuLibraryInitial extends SkuLibraryState {
  const SkuLibraryInitial();

  @override
  List<Object> get props => [];
}

final class SkuLibraryReloadState extends SkuLibraryState {
  const SkuLibraryReloadState();

  @override
  List<Object> get props => [];
}

final class SkuLibraryLoadedState extends SkuLibraryState {
  const SkuLibraryLoadedState();

  @override
  List<Object> get props => [];
}

final class SkuLibraryChangeListingTypeState extends SkuLibraryState {
  const SkuLibraryChangeListingTypeState();

  @override
  List<Object> get props => [];
}

final class SkuLibraryLoadingMoreState extends SkuLibraryState {
  const SkuLibraryLoadingMoreState();

  @override
  List<Object> get props => [];
}

final class SkuLibraryLoadedMoreState extends SkuLibraryState {
  final int currentPage;

  const SkuLibraryLoadedMoreState({required this.currentPage});

  @override
  List<Object> get props => [currentPage];
}

final class SkuLibraryLoadingState extends SkuLibraryState {
  const SkuLibraryLoadingState();

  @override
  List<Object> get props => [];
}
