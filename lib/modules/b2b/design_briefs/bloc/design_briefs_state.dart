part of 'design_briefs_bloc.dart';

sealed class DesignBriefsState extends Equatable {
  const DesignBriefsState();
}

final class DesignBriefsInitial extends DesignBriefsState {
  @override
  List<Object> get props => [];
}

final class DesignBriefsReloadState extends DesignBriefsState {
  @override
  List<Object> get props => [];
}

final class DesignBriefsLoadedState extends DesignBriefsState {
  @override
  List<Object> get props => [];
}

final class FilterDesignBriefsState extends DesignBriefsState {
  @override
  List<Object> get props => [];
}
