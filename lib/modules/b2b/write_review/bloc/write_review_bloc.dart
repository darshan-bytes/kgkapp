import 'package:kgk/kgk.dart';

part 'write_review_event.dart';

part 'write_review_state.dart';

class WriteReviewBloc extends Bloc<WriteReviewEvent, WriteReviewState> {
  String productId = '';
  Commodity? commodity;
  int selectedRating = 0;
  final ImagePicker _picker = ImagePicker();
  List<XFile> imageFileList = [];

  int get maxImagesCount => AppConst.maxImagesCount;

  int get availablePickImageLength => maxImagesCount - (imageFileList.length);

  TextEditingController titleController = TextEditingController();
  TextEditingController reviewController = TextEditingController();

  FocusNode titleFocusNode = FocusNode();
  FocusNode reviewFocusNode = FocusNode();

  WriteReviewBloc() : super(const WriteReviewInitial()) {
    on<WriteReviewInitialEvent>(_onInitEvent);
    on<PickImageEvent>(_onMultiImagePicked);
    on<RemoveSelectedImageEvent>(_onRemoveSelectedImage);
    on<WriteReviewResetEvent>(_onWriteReviewReset);
    on<WriteReviewSubmitEvent>(_onWriteReviewSubmitEvent);
  }

  void _onInitEvent(WriteReviewInitialEvent event, Emitter<WriteReviewState> emit) {
    productId = (event.context.routesData?[RoutesData.productId] as String?) ?? '';
    commodity = event.context.routesData?[RoutesData.commodity] as Commodity?;
    add(const WriteReviewResetEvent());
  }

  Future<void> _onMultiImagePicked(PickImageEvent event, Emitter<WriteReviewState> emit) async {
    if (availablePickImageLength <= 0) {
      Utils.showMessage(APPStrings.errorMaximumFiveImages.tr);
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

  void _onWriteReviewReset(WriteReviewResetEvent event, Emitter<WriteReviewState> emit) {
    resetData();
    emit(const WriteReviewInitial());
  }

  void _onRemoveSelectedImage(RemoveSelectedImageEvent event, Emitter<WriteReviewState> emit) {
    emit(const WriteReviewReloadState());
    if (imageFileList.isNotNullNorEmpty) {
      imageFileList.removeAt(event.selectedImage);
      emit(const RemoveSelectedImageState());
    }
  }

  Future<void> _pickSingleImage(ImageSource source, Emitter<WriteReviewState> emit) async {
    emit(const WriteReviewReloadState());
    XFile? pickedImage = await _picker.pickImage(source: source);
    if (pickedImage != null) {
      imageFileList.add(pickedImage);
      emit(const PickImageState());
    }
  }

  Future<void> _pickMultipleImages(ImageSource source, Emitter<WriteReviewState> emit) async {
    emit(const WriteReviewReloadState());
    List<XFile>? pickedImages = await _picker.pickMultiImage(limit: availablePickImageLength);
    if (pickedImages.length > maxImagesCount || availablePickImageLength < pickedImages.length) {
      Utils.showMessage(APPStrings.errorSelectUpToFiveImages.tr);
    } else {
      imageFileList.addAll(pickedImages);
      emit(const PickImageState());
    }
  }

  Future<void> _handlePlatformException(PlatformException e) async {
    switch (e.code) {
      case 'camera_access_denied':
      case 'photo_access_denied':
        Utils.showDoubleActionDialog(
          title: e.message,
          okButtonText: APPStrings.ok.tr,
          cancelButtonText: APPStrings.cancel.tr,
          content: APPStrings.errorAllowCameraSettings.tr,
          onOkPressed: () {
            openAppSettings();
          },
        );
        break;
      default:
        Utils.showMessage("An error occurred: ${e.message}");
        break;
    }
  }

  void resetData() {
    reviewController.clear();
    titleController.clear();
    titleFocusNode.unfocus();
    reviewFocusNode.unfocus();
    imageFileList.clear();
  }

  Future<void> _onWriteReviewSubmitEvent(WriteReviewSubmitEvent event, Emitter<WriteReviewState> emit) async {
    if (titleController.text.isEmpty) {
      Utils.showMessage(APPStrings.errorTitleRequired.tr);
      return;
    }

    if (reviewController.text.isEmpty) {
      Utils.showMessage(APPStrings.errorReviewRequired.tr);
      return;
    }
    Map<String, String> body = {
      ApiKey.productId_: productId,
      ApiKey.title: titleController.text,
      ApiKey.description: reviewController.text,
      ApiKey.businessType: commodity?.value ?? '',
      ApiKey.rating: selectedRating.toString(),
    };
    Either<ErrorResponse, CommonResponse<ProductReviewModel>>? response =
        await AppRepository(event.context).addProductReview(body, images: imageFileList.map((e) => e.path).toList());
    await response?.fold((error) {
      Utils.showMessage(error.message ?? '');
    }, (data) async {
      event.context.pop();
      await Future.delayed(const Duration(milliseconds: 500));
      Utils.showMessage(data.message ?? '');
    });
  }
}
