import 'package:kgk/kgk.dart';

part 'apply_promo_code_event.dart';

part 'apply_promo_code_state.dart';

class ApplyPromoCodeBloc extends Bloc<ApplyPromoCodeEvent, ApplyPromoCodeState> {
  /// List of ApplyPromoCodeModel
  List<ApplyPromoCodeModel> applyPromoCodeList = <ApplyPromoCodeModel>[];

  ApplyPromoCodeBloc() : super(ApplyPromoCodeInitial()) {
    on<InitialApplyPromoCodeEvent>(_initialApplyPromoCodeEvent);
  }

  /// Initializes the ApplyPromoCodeBloc
  Future<void> _initialApplyPromoCodeEvent(InitialApplyPromoCodeEvent event, Emitter<ApplyPromoCodeState> emit) async {
    await _initializeBloc(event.context, emit);
  }

  /// Initializes the ApplyPromoCodeBloc
  Future<void> _initializeBloc(BuildContext context, Emitter<ApplyPromoCodeState> emit) async {
    emit(ApplyPromoCodeLoadingState());
    await fetchApplyPromoCodeList(context, emit);
    emit(ApplyPromoCodeLoadedState());
  }

  /// Fetch apply promo code data
  Future<void> fetchApplyPromoCodeList(BuildContext context, Emitter<ApplyPromoCodeState> emit) async {
    Either<ErrorResponse, CommonResponse<ApplyPromoCodeModel>>? response = await AppRepository(context).fetchPromoCodeList();

    response?.fold((error) {
      Utils.showMessage(error.message);
      emit(ApplyPromoCodeLoadedState());
    }, (CommonResponse<ApplyPromoCodeModel> success) {
      final List<ApplyPromoCodeModel> data = success.responseData as List<ApplyPromoCodeModel>;
      if (data.isNotNullNorEmpty) {
        applyPromoCodeList = data;
      }
      emit(ApplyPromoCodeLoadedState());
    });
  }
}
