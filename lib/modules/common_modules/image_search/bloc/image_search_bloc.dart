import 'package:kgk/kgk.dart';

part 'image_search_event.dart';

part 'image_search_state.dart';

class ImageSearchBloc extends Bloc<ImageSearchEvent, ImageSearchState> {
  bool isCameraSelected = true;

  ImageSearchBloc() : super(const ImageSearchInitial()) {
    on<ImageSearchInitialEvent>(_onImageSearchInitialEvent);
    on<ImageSelectionToggleEvent>(_onImageSelectionToggleEvent);
  }

  void _onImageSearchInitialEvent(ImageSearchInitialEvent event, Emitter<ImageSearchState> emit) {
    emit(const ImageSearchInitial());
  }

  void _onImageSelectionToggleEvent(ImageSelectionToggleEvent event, Emitter<ImageSearchState> emit) {
    emit(const ImageSearchReloadState());
    isCameraSelected = event.isCameraSelected;
    emit(const ImageSelectionToggleState());
  }
}
