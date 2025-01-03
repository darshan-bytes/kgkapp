import 'package:kgk/kgk.dart';

part 'apply_promo_code_event.dart';

part 'apply_promo_code_state.dart';

class ApplyPromoCodeBloc extends Bloc<ApplyPromoCodeEvent, ApplyPromoCodeState> {
  /// List of ApplyPromoCodeModel
  List<ApplyPromoCodeModel> applyPromoCodeList = <ApplyPromoCodeModel>[];

  /// Promo code controller
  final TextEditingController promoCodeController = TextEditingController();

  /// Identifies for the selected promo code
  BagOrderCharge? promoCode;

  /// Promo code widget
  ApplyPromoCodeModel? appliedPromoCode;

  ApplyPromoCodeBloc() : super(ApplyPromoCodeInitial()) {
    on<InitialApplyPromoCodeEvent>(_initialApplyPromoCodeEvent);
    on<OnTapApplyPromoCodeEvent>(_onTapApplyPromoCodeEvent);
    on<OnTapRemovePromoCodeEvent>(_onRemovePromoCode);
  }

  /// Initializes the ApplyPromoCodeBloc
  Future<void> _initialApplyPromoCodeEvent(InitialApplyPromoCodeEvent event, Emitter<ApplyPromoCodeState> emit) async {
    await _initializeBloc(event.context, emit);
  }

  /// OnTap the ApplyPromoCodeEvent
  Future<void> _onTapApplyPromoCodeEvent(OnTapApplyPromoCodeEvent event, Emitter<ApplyPromoCodeState> emit) async {
    await _handleApplyPromoCode(event, emit);
  }

  /// Initializes the ApplyPromoCodeBloc
  Future<void> _initializeBloc(BuildContext context, Emitter<ApplyPromoCodeState> emit) async {
    emit(ApplyPromoCodeLoadingState());
    _getRouteData(context);
    await fetchApplyPromoCodeList(context, emit);
    emit(ApplyPromoCodeLoadedState());
  }

  void _getRouteData(BuildContext context) {
    Map<RoutesData, dynamic>? routesData = context.routesData;
    if (routesData != null) {
      promoCode = routesData[RoutesData.promoCode];
    }
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

        /// Identifies for the selected promo code and set it in the state
        appliedPromoCode = applyPromoCodeList.firstWhereOrNull((e) => promoCode != null && e.title == promoCode?.title);
      }
      emit(ApplyPromoCodeLoadedState());
    });
  }

  /// Handles the ApplyPromoCodeEvent
  Future<void> _handleApplyPromoCode(OnTapApplyPromoCodeEvent event, Emitter<ApplyPromoCodeState> emit) async {
    emit(ApplyPromoCodeLoadingState());
    String id = StorageManager().getBagId() ?? "";
    if (id.isEmpty) return;
    final Map<String, dynamic> body = {
      ApiKey.promoCode_: event.promoCode,
      ApiKey.cartId_: id,
    };
    final response = await AppRepository(event.context).applyPromoCode(body);
    await response?.fold(
      (ErrorResponse l) {
        Utils.showMessage(l.message);
        emit(ApplyPromoCodeLoadedState());
      },
      (r) async {
        /// Using this event to fetch latest order summary data
        event.context.pop();
      },
    );
  }

  /// Handles the removal of promo codes
  Future<void> _onRemovePromoCode(OnTapRemovePromoCodeEvent event, Emitter<ApplyPromoCodeState> emit) async {
    emit(ApplyPromoCodeLoadingState());
    String id = StorageManager().getBagId() ?? "";
    if (id.isEmpty) return;
    final response = await AppRepository(event.context).removePromoCode(bagId: id);
    await response?.fold(
      (l) {
        Utils.showMessage(l.message);
      },
      (r) async {
        clearData();

        /// Using this event to fetch latest order summary data
        BlocProvider.of<MyBagBloc>(event.context).add(FetchOrderSummaryDataEvent(event.context));
      },
    );
    emit(ApplyPromoCodeLoadedState());
  }

  void clearData() {
    appliedPromoCode = null;
    promoCode = null;
  }
}
