import 'package:kgk/kgk.dart';

part 'design_library_feedback_event.dart';

part 'design_library_feedback_state.dart';

class DesignLibraryFeedbackBloc extends Bloc<DesignLibraryFeedbackEvent, DesignLibraryFeedbackState> {
  List<DesignLibraryFeedbackModel> feedbackList = [];
  TextEditingController feedbackController = TextEditingController();
  FocusNode feedbackFocusNode = FocusNode();
  bool showAddComment = false;
  String appBarTitle = "DERS28MOVR";

  DesignLibraryFeedbackBloc() : super(DesignLibraryFeedbackInitial()) {
    on<InitialDesignLibraryFeedbackEvent>(_onInitialDesignLibraryFeedbackEvent);
    on<DesignLibraryShowAddCommentEvent>(_onDesignLibraryShowAddCommentEvent);
  }

  void _onInitialDesignLibraryFeedbackEvent(InitialDesignLibraryFeedbackEvent event, Emitter<DesignLibraryFeedbackState> emit) {
    emit(DesignLibraryFeedbackReloadedState());
    feedbackList = _generateFeedbackList();
    emit(DesignLibraryFeedbackLoadedState());
  }

  void _onDesignLibraryShowAddCommentEvent(DesignLibraryShowAddCommentEvent event, Emitter<DesignLibraryFeedbackState> emit) {
    emit(DesignLibraryFeedbackReloadedState());
    showAddComment = !showAddComment;
    emit(DesignLibraryShowAddCommentState());
  }

  List<DesignLibraryFeedbackModel> _generateFeedbackList() {
    List<DesignLibraryFeedbackModel> feedbackList = [];
    feedbackList.add(
      DesignLibraryFeedbackModel(
        id: "1",
        designerImageUrl: "https://i.ibb.co/729SGNK/Ellipse-10.png",
        designerName: "Brooklyn Simmons",
        daysAgo: "2 days ago",
        feedbackMessage: "Can we add information about the carat and clarity of the particular product?",
      ),
    );
    feedbackList.add(
      DesignLibraryFeedbackModel(
        id: "2",
        designerImageUrl: "https://i.ibb.co/729SGNK/Ellipse-10.png",
        designerName: "Brooklyn Simmons",
        daysAgo: "2 days ago",
        feedbackMessage: "Please reduce the size from 5.5mm to 5.0mm.",
      ),
    );
    feedbackList.add(
      DesignLibraryFeedbackModel(
        id: "2",
        designerImageUrl: "https://i.ibb.co/729SGNK/Ellipse-10.png",
        designerName: "Brooklyn Simmons",
        daysAgo: "2 days ago",
        feedbackMessage: "Make it in princess cut.",
      ),
    );
    feedbackList.add(
      DesignLibraryFeedbackModel(
        id: "2",
        designerImageUrl: "https://i.ibb.co/729SGNK/Ellipse-10.png",
        designerName: "Brooklyn Simmons",
        daysAgo: "2 days ago",
        feedbackMessage: "Make it in princess cut.",
      ),
    );
    return feedbackList;
  }
}
