import 'package:kgk/kgk.dart';

part 'write_review_event.dart';

part 'write_review_state.dart';

class WriteReviewBloc extends Bloc<WriteReviewEvent, WriteReviewState> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? imageFileList = [];

  int get maxImagesCount => AppConst.maxImagesCount;

  int get availablePickImageLength => maxImagesCount - (imageFileList?.length ?? 0);

  List<XFile> get selectedImages => imageFileList ?? [];

  TextEditingController titleController = TextEditingController();
  TextEditingController reviewController = TextEditingController();

  FocusNode titleFocusNode = FocusNode();
  FocusNode reviewFocusNode = FocusNode();

  WriteReviewBloc() : super(const WriteReviewInitial()) {
    on<PickImageEvent>(_onMultiImagePicked);
    on<RemoveSelectedImageEvent>(_onRemoveSelectedImage);
  }

  Future<void> _onMultiImagePicked(PickImageEvent event, Emitter<WriteReviewState> emit) async {
    if (availablePickImageLength <= 0) {
      Utils.showMessage(APPStrings.maximumFiveImages.tr);
      return;
    }

    try {
      if (event.imageSource == ImageSource.camera) {
        await _pickSingleImage(event.imageSource, emit);
      } else {
        if (availablePickImageLength == 1) {
          await _pickSingleImage(event.imageSource, emit);
        } else {
          await _pickMultipleImages(event.imageSource, emit);
        }
      }
    } on PlatformException catch (e) {
      _handlePlatformException(e);
    }
  }

  void _onRemoveSelectedImage(RemoveSelectedImageEvent event, Emitter<WriteReviewState> emit) {
    emit(const WriteReviewReloadState());
    if (imageFileList.isNotNullNorEmpty) {
      imageFileList?.removeAt(event.selectedImage);
      emit(const RemoveSelectedImageState());
    }
  }

  Future<void> _pickSingleImage(ImageSource source, Emitter<WriteReviewState> emit) async {
    emit(const WriteReviewReloadState());
    XFile? pickedImage = await _picker.pickImage(source: source);
    if (pickedImage != null) {
      imageFileList?.add(pickedImage);
      emit(const PickImageState());
    }
  }

  Future<void> _pickMultipleImages(ImageSource source, Emitter<WriteReviewState> emit) async {
    emit(const WriteReviewReloadState());
    List<XFile>? pickedImages = await _picker.pickMultiImage(limit: availablePickImageLength);
    if (pickedImages.length > maxImagesCount || availablePickImageLength < pickedImages.length) {
      Utils.showMessage(APPStrings.selectUpToFiveImages.tr);
    } else {
      imageFileList?.addAll(pickedImages);
      emit(const PickImageState());
    }
  }

  void _handlePlatformException(PlatformException e) {
    switch (e.code) {
      case 'camera_access_denied':
      case 'photo_access_denied':
        Utils.showMessage(e.message ?? "");
        //TODO: need to navigate to settings to allow permission
        break;
      default:
        Utils.showMessage("An error occurred: ${e.message}");
        break;
    }
  }
}
