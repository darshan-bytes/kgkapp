import 'package:kgk/kgk.dart';

part 'exhibition_details_orders_event.dart';

part 'exhibition_details_orders_state.dart';

class ExhibitionDetailsOrdersBloc extends Bloc<ExhibitionDetailsOrdersEvent, ExhibitionDetailsOrdersState> {
  List<ExhibitionDetailsOrdersModel> exhibitionOrders = [];

  ExhibitionDetailsOrdersBloc() : super(ExhibitionDetailsOrdersIntial()) {
    on<ExhibitionDetailsOrdersInitialEvent>(_onInitialEvent);
  }

  void _onInitialEvent(ExhibitionDetailsOrdersEvent event, Emitter<ExhibitionDetailsOrdersState> emit) {
    emit(const ExhibitionDetailsOrdersReloadState());
    exhibitionOrders = List.generate(20, (index) {
      return ExhibitionDetailsOrdersModel(
          approvedBy: "John Samanta",
          approvedByImageUrl: "https://i.ibb.co/BLyLVHS/Frame-3978.png",
          items: '5',
          totalAmount: '\$35,700',
          market: "New York, USA",
          marketImageUrl: AppImages.icFlagUSA,
          orderName: "Dianne Russell",
          id: index + 1);
    });

    emit(const ExhibitionDetailsOrdersLoadedState());
  }
}
