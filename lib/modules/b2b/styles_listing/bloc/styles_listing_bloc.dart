import 'package:kgk/kgk.dart';

part 'styles_listing_event.dart';

part 'styles_listing_state.dart';

class StylesListingBloc extends Bloc<StylesListingEvent, StylesListingState> {
  List<B2BCustomListingDataModel> stylesList = [];
  TextEditingController searchController = TextEditingController();
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  StylesListingBloc() : super(StylesListingInitial()) {
    on<StylesListingInitialEvent>(_onStylesListingInitialEvent);
    on<StylesListingSearchEvent>(_onStylesListingSearchEvent);
    on<StylesListingLoadMoreEvent>(_onStylesListingLoadMoreEvent);
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }

  void _onStylesListingInitialEvent(StylesListingInitialEvent event, Emitter<StylesListingState> emit) {
    emit(StylesListingReloadState());
    searchController.clear();
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(StylesListingLoadMoreEvent(currentPage));
      },
    );
    stylesList = List.generate(
      20,
      (index) => B2BCustomListingDataModel(
        id: index.toString(),
        strStyleNumber: 'DWBFM4Q-108636',
        status: OrderStatus.inProgress,
        strDesignNumber: 'DERS28MOVR',
        strCustomer: 'John Samanta',
        strCustomerImageUrl: 'https://i.ibb.co/BLyLVHS/Frame-3978.png',
        strMarket: 'Zone 6',
        strStoneCardLocked: 'Yes',
        isStoneCardLockedImage: true,
        strExclusive: 'Yes',
        strExclusiveCustomer: 'Jenny Wilson',
        strExclusiveCustomerImageUrl: 'https://i.ibb.co/hy6pH4g/Frame-3977.png',
      ),
    );

    emit(const StylesListingLoadedState());
  }

  void _onStylesListingSearchEvent(StylesListingSearchEvent event, Emitter<StylesListingState> emit) {
    //TODO: Implement search logic
  }

  Future<void> _onStylesListingLoadMoreEvent(StylesListingLoadMoreEvent event, Emitter<StylesListingState> emit) async {
    emit(const StylesListingLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    stylesList.addAll(
      List.generate(
        10,
        (index) => B2BCustomListingDataModel(
          id: index.toString(),
          strStyleNumber: 'DWBFM4Q-108636',
          status: OrderStatus.inProgress,
          strDesignNumber: 'DERS28MOVR',
          strCustomer: 'John Samanta',
          strCustomerImageUrl: 'https://i.ibb.co/BLyLVHS/Frame-3978.png',
          strMarket: 'Zone 6',
          strStoneCardLocked: 'Yes',
          isStoneCardLockedImage: true,
          strExclusive: 'Yes',
          strExclusiveCustomer: 'Jenny Wilson',
          strExclusiveCustomerImageUrl: 'https://i.ibb.co/hy6pH4g/Frame-3977.png',
        ),
      ),
    );
    paginationScrollController.isPageLoaded.complete(event.currentPage == 3);
    emit(StylesListingLoadedMoreState(event.currentPage + 1));
  }
}
