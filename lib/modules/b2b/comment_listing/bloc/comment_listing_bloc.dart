import 'package:kgk/kgk.dart';

part 'comment_listing_event.dart';

part 'comment_listing_state.dart';

enum CommentListingPopupMenuOption { edit, remove }

class CommentListingBloc extends Bloc<CommentListingEvent, CommentListingState> {
  /// Response model for comments added.
  CommentsAddedResponseModel? commentsAddedResponseModel;
  List<Comments> commentsList = [];

  /// Catalogue and Product IDs for fetching comments.
  String catalogueId = '';
  String productId = '';

  String? _currentEditingCommentId;

  /// Controller for comment input field.
  final TextEditingController commentController = TextEditingController();

  /// Focus node for the comment input field to manage focus.
  final FocusNode commentFocusNode = FocusNode();

  CommentListingBloc() : super(CommentListingInitial()) {
    on<InitialCommentListingEvent>(_onInitialCommentListingEvent);
    on<CommentAddedApiCallEvent>(_onCommentAddedApiCallEvent);
    on<CommentDeletedApiCallEvent>(_onCommentDeletedApiCallEvent);
  }

  /// Handles the initial event to fetch comments for a product.
  Future<void> _onInitialCommentListingEvent(InitialCommentListingEvent event, Emitter<CommentListingState> emit) async {
    emit(CommentLoadingState());
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
    final Map<String, dynamic> params = {ApiKey.productId_: productId, ApiKey.catalogueId: catalogueId};

    /// API request to fetch comments.
    Either<ErrorResponse, CommentsAddedResponseModel?>? response = await AppRepository(context).getPreviewCatalogueCommentList(params);

    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message);
        }
      },
      (commentsAddedResponse) {
        if (commentsAddedResponse != null) {
          commentsAddedResponseModel = commentsAddedResponse;
          commentsList = commentsAddedResponse.comments ?? [];
          commentsList.sort((a, b) => DateTime.parse(b.createdAt ?? '').compareTo(DateTime.parse(a.createdAt ?? '')));
        }
      },
    );
  }

  /// Call this method before showing the input field
  void setEditingComment(String? commentId, String message) {
    _currentEditingCommentId = commentId;
    commentController.text = message;
    commentFocusNode.requestFocus();
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
    Either<ErrorResponse, CommonResponse<CommentsAddedResponseModel>>? response;

    if (_currentEditingCommentId != null) {
      response = await AppRepository(event.context).editDigitalCatalogueComments(commentId: _currentEditingCommentId!, body: params);
    } else {
      response = await AppRepository(event.context).digitalCatalogueAddComment(params);
    }

    await response?.fold(
      (error) async {
        if (error.message.isNotNullNorEmpty) {
          await Utils.showMessage(error.message);
        }

        emit(CommentListingLoadedState());
      },
      (success) async {
        await _callPreviewCatalogueCommentApi(context: event.context);
        if (success.message.isNotNullNorEmpty) {
          await Utils.showMessage(success.message);
          emit(CommentListingLoadedState());
        }
      },
    );
    event.context.pop();
    reset();
  }

  Future<void> _onCommentDeletedApiCallEvent(CommentDeletedApiCallEvent event, Emitter<CommentListingState> emit) async {
    emit(CommentLoadingState());
    Either<ErrorResponse, CommonResponse>? response = await AppRepository(
      event.context,
    ).deleteDigitalCatalogueComments(commentId: event.commentId);

    await response?.fold(
      (error) async {
        if (error.message.isNotNullNorEmpty) {
          await Utils.showMessage(error.message);
        }
      },
      (success) async {
        if (success.message.isNotNullNorEmpty) {
          await Utils.showMessage(success.message);
        }
        await _callPreviewCatalogueCommentApi(context: event.context);
      },
    );
    emit(CommentListingLoadedState());
  }

  /// Resets the bloc state for a new session.
  void reset() {
    commentController.clear();
    commentFocusNode.unfocus();
    _currentEditingCommentId = null;
  }
}
