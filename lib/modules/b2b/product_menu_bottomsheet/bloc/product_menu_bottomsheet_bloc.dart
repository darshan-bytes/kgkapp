import 'package:kgk/kgk.dart';

part 'product_menu_bottomsheet_event.dart';
part 'product_menu_bottomsheet_state.dart';

class ProductMenuBottomSheetBloc extends Bloc<ProductMenuBottomSheetEvent, ProductMenuBottomSheetState> {
  bool showMoreDetails = false;
  String subTotalAmount = "\$18000";

  ProductMenuBottomSheetBloc() : super(ProductMenuBottomsheetInitial()) {
    on<ChangeMoreDetailsEvent>(_onChangeMoreDetailsEvent);
  }

  void _onChangeMoreDetailsEvent(ChangeMoreDetailsEvent event, Emitter<ProductMenuBottomSheetState> emit) {
    emit(ProductMenuBottomSheetReloadState());
    showMoreDetails = !showMoreDetails;
    emit(ChangeMoreDetailsState());
  }
}
