import 'package:kgk/kgk.dart';

part 'write_review_event.dart';
part 'write_review_state.dart';

class WriteReviewBloc extends Bloc<WriteReviewEvent, WriteReviewState> {
  TextEditingController titleController = TextEditingController();
  TextEditingController reviewController = TextEditingController();

  FocusNode titleFocusNode = FocusNode();
  FocusNode reviewFocusNode = FocusNode();

  WriteReviewBloc() : super(WriteReviewInitial()) {
    on<WriteReviewEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
