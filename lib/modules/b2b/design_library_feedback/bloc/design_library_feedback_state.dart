part of 'design_library_feedback_bloc.dart';

sealed class DesignLibraryFeedbackState extends Equatable {
  const DesignLibraryFeedbackState();
}

final class DesignLibraryFeedbackInitial extends DesignLibraryFeedbackState {
  @override
  List<Object> get props => [];
}

final class DesignLibraryFeedbackReloadedState extends DesignLibraryFeedbackState {
  @override
  List<Object> get props => [];
}

final class DesignLibraryFeedbackLoadedState extends DesignLibraryFeedbackState {
  @override
  List<Object> get props => [];
}

final class DesignLibraryShowAddCommentState extends DesignLibraryFeedbackState {
  @override
  List<Object> get props => [];
}
