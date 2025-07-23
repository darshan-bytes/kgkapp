import 'package:kgk/kgk.dart';

part 'inquiry_detail_event.dart';

part 'inquiry_detail_state.dart';

class InquiryDetailBloc extends Bloc<InquiryDetailEvent, InquiryDetailState> {
  MyInquiriesModel? inquiryData;
  bool isListError = false;
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  InquiryDetailBloc() : super(InquiryDetailInitial()) {
    on<InitialInquiryDetailEvent>(_onInitialInquiryDetailEvent);
    on<AddCommentInquiryDetailEvent>(_onAddCommentInquiryDetailEvent);
  }

  /// Event Handlers
  Future<void> _onInitialInquiryDetailEvent(InitialInquiryDetailEvent event, Emitter<InquiryDetailState> emit) async {
    emit(const InquiryDetailLoading());
    inquiryData = event.context.routesData?[RoutesData.inquiryData] as MyInquiriesModel?;

    await _fetchCommentsList(event.context, emit);
    emit(InquiryDetailLoaded(inquiryData: inquiryData!));
  }

  Future<void> _onAddCommentInquiryDetailEvent(AddCommentInquiryDetailEvent event, Emitter<InquiryDetailState> emit) async {
    await _submitInquiryComment(event, emit);
  }

  /// Helper Methods
  Future<void> _fetchCommentsList(BuildContext context, Emitter<InquiryDetailState> emit) async {
    if (inquiryData == null) return;
    // Implement the logic to fetch comments list
    // This is a placeholder for the actual implementation
    //inquiryCommentsList
    final response = await AppRepository(context).inquiryCommentsList(inquiryData!.id ?? '');

    response?.fold(
      (error) {
        Utils.showMessage(error.message);
        isListError = true;
      },
      (inquiry) {
        isListError = false;
        inquiryData = inquiry;

        emit(InquiryDetailLoaded(inquiryData: inquiryData!));
      },
    );
  }

  Future<void> _submitInquiryComment(AddCommentInquiryDetailEvent event, Emitter<InquiryDetailState> emit) async {
    if (messageController.text.trim().isEmpty) return;
    final Map<String, dynamic> body = {ApiKey.inquiryId_: inquiryData?.id, ApiKey.comment: messageController.text.trim()};
    final response = await AppRepository(event.context).submitInquiryComment(body: body);
    await response?.fold(
      (error) {
        Utils.showMessage(error.message);
      },
      (r) async {
        messageController.clear();
        await _fetchCommentsList(event.context, emit);
        Utils.showMessage(r.message);
        emit(InquiryDetailLoaded(inquiryData: inquiryData!));
        await Future.delayed(Duration(milliseconds: 100));
        await scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      },
    );
  }
}
