part of 'design_library_bloc.dart';

sealed class DesignLibraryState extends Equatable {
  const DesignLibraryState();
}

final class DesignLibraryInitial extends DesignLibraryState {
  const DesignLibraryInitial();

  @override
  List<Object> get props => [];
}

final class DesignLibraryReloadState extends DesignLibraryState {
  const DesignLibraryReloadState();

  @override
  List<Object> get props => [];
}

final class DesignLibraryLoadedState extends DesignLibraryState {
  const DesignLibraryLoadedState();

  @override
  List<Object> get props => [];
}

final class DesignLibraryChangeListingTypeState extends DesignLibraryState {
  const DesignLibraryChangeListingTypeState();

  @override
  List<Object> get props => [];
}

final class DesignLibraryLoadingMoreState extends DesignLibraryState {
  const DesignLibraryLoadingMoreState();

  @override
  List<Object> get props => [];
}

final class DesignLibraryLoadedMoreState extends DesignLibraryState {
  final int currentPage;

  const DesignLibraryLoadedMoreState({required this.currentPage});

  @override
  List<Object> get props => [currentPage];
}

final class DesignLibraryLoadingState extends DesignLibraryState {
  const DesignLibraryLoadingState();

  @override
  List<Object> get props => [];
}
