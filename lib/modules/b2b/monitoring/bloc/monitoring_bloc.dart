import 'package:kgk/kgk.dart';

part 'monitoring_event.dart';

part 'monitoring_state.dart';

class MonitoringBloc extends Bloc<MonitoringEvent, MonitoringState> {
  late TabController tabController;
  final TextEditingController searchController = TextEditingController();
  List<B2BCustomListingDataModel> presentationList = [];
  List<B2BCustomListingDataModel> stylesList = [];
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }

  // Tabs
  final List<Widget> tabs = <Widget>[
    Tab(text: APPStrings.presentations.tr),
    Tab(text: APPStrings.dbf.tr),
    Tab(text: APPStrings.designs.tr),
    Tab(text: APPStrings.styles.tr),
  ];

  MonitoringBloc() : super(MonitoringInitialState()) {
    on<MonitoringEvent>((event, emit) {});
    on<MonitoringInitialEvent>(_onInitialEvent);
    on<MonitoringOnTabChangedEvent>(_onTabChangedEvent);
    on<MonitoringListingLoadMoreEvent>(_onListingLoadMoreEvent);
  }

  void _onInitialEvent(MonitoringInitialEvent event, Emitter<MonitoringState> emit) {
    emit(MonitoringReloadState());

    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(MonitoringListingLoadMoreEvent(currentPage: currentPage));
      },
    );

    presentationList = List.generate(
      20,
      (index) => B2BCustomListingDataModel(
        id: index.toString(),
        strPresentationNumber: '1254875',
        status: OrderStatus.active,
        strConceptNumber: "PRJ-171604",
        strSalesman: "John Samanta",
        strSalesmanImageUrl: "https://i.ibb.co/BLyLVHS/Frame-3978.png",
        strDesigner: "Jenny Wilson",
        strDesignerImageUrl: "https://i.ibb.co/hy6pH4g/Frame-3977.png",
        strCreatedOn: '23/03/2023',
        strApprovedBy: "John Samanta",
        strApprovedByImageUrl: "https://i.ibb.co/BLyLVHS/Frame-3978.png",
        strApprovedOn: "23/03/2023",
      ),
    );

    stylesList = List.generate(
      20,
      (index) => B2BCustomListingDataModel(
        id: index.toString(),
        strDesignListingImageUrl: 'https://i.ibb.co/Rhgz539/image-224.png',
        status: OrderStatus.active,
        strStyleNumber: 'DWBFM4Q-108636',
        strDesignNumber: 'DERS28MOVR',
        strCustomer: 'Alex Williams',
        strCustomerImageUrl: 'https://i.ibb.co/hy6pH4g/Frame-3977.png',
        strSalesman: 'John Samanta',
        strSalesmanImageUrl: 'https://i.ibb.co/hy6pH4g/Frame-3977.png',
        strApprovedBy: 'John Samanta',
        strApprovedByImageUrl: 'https://i.ibb.co/hy6pH4g/Frame-3977.png',
        strApprovedOn: '24/03/2023',
      ),
    );

    emit(MonitoringListLoadedState());
  }

  void _onTabChangedEvent(MonitoringOnTabChangedEvent event, Emitter<MonitoringState> emit) {
    emit(MonitoringReloadState());
    printWrapped("tabController.index: ${tabController.index}");
    switch (tabController.index) {
      case 0:

        /// Presentations
        break;
      case 1:

        /// DBF
        break;
      case 2:

        /// Designs
        break;
      case 3:

        /// Styles
        break;
    }
    emit(MonitoringOnTabChangedState());
  }

  Future<void> _onListingLoadMoreEvent(MonitoringListingLoadMoreEvent event, Emitter<MonitoringState> emit) async {
    emit(MonitoringLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    presentationList.addAll(
      List.generate(
        10,
        (index) => B2BCustomListingDataModel(
          id: index.toString(),
          strPresentationNumber: ((paginationScrollController.currentPage * 10) + index + 1).toString(),
          status: OrderStatus.inProgress,
          strConceptNumber: "PRJ-171604",
          strSalesman: "John Samanta",
          strSalesmanImageUrl: "https://i.ibb.co/BLyLVHS/Frame-3978.png",
          strDesigner: "Jenny Wilson",
          strDesignerImageUrl: "https://i.ibb.co/hy6pH4g/Frame-3977.png",
          strCreatedOn: '23/03/2023',
          strApprovedBy: "John Samanta",
          strApprovedByImageUrl: "https://i.ibb.co/BLyLVHS/Frame-3978.png",
          strApprovedOn: "23/03/2023",
        ),
      ),
    );

    stylesList.addAll(
      List.generate(
        10,
        (index) => B2BCustomListingDataModel(
          id: index.toString(),
          strDesignListingImageUrl: 'https://i.ibb.co/Rhgz539/image-224.png',
          status: OrderStatus.active,
          strStyleNumber: 'DWBFM4Q-108636',
          strDesignNumber: 'DERS28MOVR',
          strCustomer: 'Alex Williams',
          strCustomerImageUrl: 'https://i.ibb.co/hy6pH4g/Frame-3977.png',
          strSalesman: 'John Samanta',
          strSalesmanImageUrl: 'https://i.ibb.co/hy6pH4g/Frame-3977.png',
          strApprovedBy: 'John Samanta',
          strApprovedByImageUrl: 'https://i.ibb.co/hy6pH4g/Frame-3977.png',
          strApprovedOn: '24/03/2023',
        ),
      ),
    );
    paginationScrollController.isPageLoaded.complete(event.currentPage == 3);
    emit(MonitoringListLoadedMoreState(event.currentPage + 1));
  }
}
