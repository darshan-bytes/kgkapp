part of 'design_library_feedback_bloc.dart';

sealed class DesignLibraryFeedbackEvent extends Equatable {
  const DesignLibraryFeedbackEvent();
}

class InitialDesignLibraryFeedbackEvent extends DesignLibraryFeedbackEvent {
  @override
  List<Object?> get props => [];
}

class DesignLibraryShowAddCommentEvent extends DesignLibraryFeedbackEvent {
  const DesignLibraryShowAddCommentEvent();

  @override
  List<Object?> get props => [];
}
