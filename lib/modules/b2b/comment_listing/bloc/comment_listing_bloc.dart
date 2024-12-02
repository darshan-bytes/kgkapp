import 'package:kgk/kgk.dart';

part 'comment_listing_event.dart';

part 'comment_listing_state.dart';

class CommentListingBloc extends Bloc<CommentListingEvent, CommentListingState> {
  /// Response model for comments added.
  CommentsAddedResponseModel? commentsAddedResponseModel;

  /// Catalogue and Product IDs for fetching comments.
  String catalogueId = '';
  String productId = '';

  /// Controller for comment input field.
  final TextEditingController commentController = TextEditingController();

  /// Focus node for the comment input field to manage focus.
  final FocusNode commentFocusNode = FocusNode();

  /// Flag to ensure initialization happens only once.
  bool _isInitialized = false;

  CommentListingBloc() : super(CommentListingInitial()) {
    on<InitialCommentListingEvent>(_onInitialCommentListingEvent);
    on<CommentAddedApiCallEvent>(_onCommentAddedApiCallEvent);
  }

  /// Handles the initial event to fetch comments for a product.
  Future<void> _onInitialCommentListingEvent(InitialCommentListingEvent event, Emitter<CommentListingState> emit) async {
    if (_isInitialized) return;
    _isInitialized = true;
    emit(CommentListingReloadState());
    _getRouteData(context: event.context);
    await _callPreviewCatalogueCommentApi(context: event.context);
    emit(CommentListingLoadedState());
  }

  /// Retrieves route data for the product and catalogue IDs.
  void _getRouteData({required BuildContext context}) {
    if (context.routesData == null) return;
    catalogueId = context.routesData?[RoutesData.catalogueId] ?? '';
    productId = context.routesData?[RoutesData.productId] ?? '';
  }

  /// Calls the API to fetch comments for the selected product and catalogue.
  Future<void> _callPreviewCatalogueCommentApi({required BuildContext context}) async {
    final Map<String, dynamic> params = {
      ApiKey.productId_: productId,
      ApiKey.catalogueId: catalogueId,
    };

    /// API request to fetch comments.
    Either<ErrorResponse, CommentsAddedResponseModel>? response = await AppRepository(context).getPreviewCatalogueCommentList(params);

    response?.fold((error) {
      if (error.message.isNotNullNorEmpty) {
        Utils.showMessage(error.message);
      }
    }, (commentsAddedResponse) {
      commentsAddedResponseModel = commentsAddedResponse;
    });
  }

  /// Handles adding a new comment via API call.
  Future<void> _onCommentAddedApiCallEvent(CommentAddedApiCallEvent event, Emitter<CommentListingState> emit) async {
    emit(CommentListingReloadState());

    final Map<String, dynamic> params = {
      ApiKey.message: commentController.text.trim(),
      ApiKey.productId_: productId,
      ApiKey.catalogueId: catalogueId,
    };

    /// API request to add a new comment.
    Either<ErrorResponse, CommonResponse<CommentsAddedResponseModel>>? response =
        await AppRepository(event.context).digitalCatalogueAddComment(params);

    await response?.fold(
      (error) async {
        if (error.message.isNotNullNorEmpty) {
          await Utils.showMessage(error.message);
        }
      },
      (success) async {
        await _callPreviewCatalogueCommentApi(context: event.context);
        if (success.message.isNotNullNorEmpty) {
          await Utils.showMessage(success.message);
          commentController.clear();
          commentFocusNode.unfocus();
          emit(CommentListingLoadedState());
          event.context.pop();
        }
      },
    );
  }

  /// Resets the bloc state for a new session.
  void reset() {
    commentsAddedResponseModel = null;
    commentController.clear();
    commentFocusNode.unfocus();
    _isInitialized = false;
  }
}
