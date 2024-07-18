import 'package:kgk/kgk.dart';

part 'monitoring_event.dart';

part 'monitoring_state.dart';

enum MonitoringTab {
  presentations,
  dbf,
  designs,
  styles,
}

class MonitoringBloc extends Bloc<MonitoringEvent, MonitoringState> {
  late TabController tabController;
  final TextEditingController presentationsSearchController = TextEditingController();
  final TextEditingController dbfSearchController = TextEditingController();
  final TextEditingController designSearchController = TextEditingController();
  final TextEditingController stylesSearchController = TextEditingController();
  final TextEditingController searchDesignersController = TextEditingController();

  final FocusNode searchDesignersFocusNode = FocusNode();

  List<B2BCustomListingDataModel> presentationList = [];
  List<B2BCustomListingDataModel> dbfList = [];
  List<B2BCustomListingDataModel> designsList = [];
  List<B2BCustomListingDataModel> stylesList = [];

  List<DesignerListModel> designerList = [];

  SmartPaginationScrollController presentationsScrollController = SmartPaginationScrollController();
  SmartPaginationScrollController dbfScrollController = SmartPaginationScrollController();
  SmartPaginationScrollController designsScrollController = SmartPaginationScrollController();
  SmartPaginationScrollController stylesScrollController = SmartPaginationScrollController();
  SmartPaginationScrollController designerScrollController = SmartPaginationScrollController();

  @override
  Future<void> close() {
    presentationsScrollController.dispose();
    dbfScrollController.dispose();
    designsScrollController.dispose();
    stylesScrollController.dispose();
    designerScrollController.dispose();
    return super.close();
  }

  // Tabs
  final List<Widget> tabs = <Widget>[
    Tab(text: APPStrings.presentations.tr),
    Tab(text: APPStrings.dbf.tr),
    Tab(text: APPStrings.designs.tr),
    Tab(text: APPStrings.styles.tr),
  ];

  Completer<bool> refreshCompleter = Completer<bool>();

  MonitoringBloc() : super(const MonitoringInitialState()) {
    on<MonitoringInitialEvent>(_onInitialEvent);
    on<MonitoringOnTabChangedEvent>(_onTabChangedEvent);
    on<MonitoringListingLoadMoreEvent>(_onListingLoadMoreEvent);
    on<MonitoringSelectedDesignerEvent>(_onSelectedDesignerEvent);
    on<MonitoringDesignerLoadMoreEvent>(_onDesignerLoadMoreEvent);
    on<MonitoringListPullToRefreshEvent>(_onMonitoringListPullToRefreshEvent);
  }

  void _onInitialEvent(MonitoringInitialEvent event, Emitter<MonitoringState> emit) {
    emit(const MonitoringReloadState());
    if (refreshCompleter.isCompleted) {
      refreshCompleter = Completer<bool>();
    }
    // Initialize scroll controllers with their respective load actions
    if (presentationsScrollController.isInitialised) {
      presentationsScrollController.dispose();
      presentationsScrollController = SmartPaginationScrollController();
    }

    presentationsScrollController.init(
      tag: "presentationsScrollController",
      loadAction: (int currentPage) {
        add(MonitoringListingLoadMoreEvent(currentPage: currentPage, listType: MonitoringTab.presentations));
      },
    );

    if (dbfScrollController.isInitialised) {
      dbfScrollController.dispose();
      dbfScrollController = SmartPaginationScrollController();
    }

    dbfScrollController.init(
      tag: "dbfScrollController",
      loadAction: (int currentPage) {
        add(MonitoringListingLoadMoreEvent(currentPage: currentPage, listType: MonitoringTab.dbf));
      },
    );

    if (designsScrollController.isInitialised) {
      designsScrollController.dispose();
      designsScrollController = SmartPaginationScrollController();
    }

    designsScrollController.init(
      tag: "designsScrollController",
      loadAction: (int currentPage) {
        add(MonitoringListingLoadMoreEvent(currentPage: currentPage, listType: MonitoringTab.designs));
      },
    );

    if (stylesScrollController.isInitialised) {
      stylesScrollController.dispose();
      stylesScrollController = SmartPaginationScrollController();
    }

    stylesScrollController.init(
      tag: "stylesScrollController",
      loadAction: (int currentPage) {
        add(MonitoringListingLoadMoreEvent(currentPage: currentPage, listType: MonitoringTab.styles));
      },
    );

    // Initialize data lists
    presentationList = List.generate(
      6,
      (index) => B2BCustomListingDataModel(
        id: index.toString(),
        strPresentationNumber: '1254875',
        status: ProjectStatus.approved,
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

    dbfList = List.generate(
      6,
      (index) => B2BCustomListingDataModel(
        id: index.toString(),
        strDbfNumber: "1234543",
        designCreationStatus: ProjectStatus.approved,
        strCustomer: "Alex Williams",
        strCustomerImageUrl: "https://i.ibb.co/BLyLVHS/Frame-3978.png",
        designApprovalStatus: ProjectStatus.approved,
        strSalesman: "John Samanta",
        strSalesmanImageUrl: "https://i.ibb.co/hy6pH4g/Frame-3977.png",
        dbfApprovalStatus: ProjectStatus.approved,
        strRevisedDate: "24/03/2023",
        holdStatus: ProjectStatus.released,
      ),
    );

    designsList = List.generate(
      6,
      (index) => B2BCustomListingDataModel(
        id: index.toString(),
        status: ProjectStatus.approved,
        strDesignListingImageUrl: "https://i.ibb.co/PMTr7Jp/Image.png",
        strDesignNumber: "DERS28MOVR",
        strDbfNumber: "1234574",
        strCustomer: "Alex Williams",
        strCustomerImageUrl: "https://i.ibb.co/BLyLVHS/Frame-3978.png",
        strSalesman: "John Samanta",
        strSalesmanImageUrl: "https://i.ibb.co/hy6pH4g/Frame-3977.png",
        strApprovedBy: "John Samanta",
        strApprovedByImageUrl: "https://i.ibb.co/BLyLVHS/Frame-3978.png",
        strApprovedOn: "24/03/2023",
      ),
    );

    stylesList = List.generate(
      6,
      (index) => B2BCustomListingDataModel(
        id: index.toString(),
        status: ProjectStatus.blueInProgress,
        strDesignListingImageUrl: "https://i.ibb.co/zZ6y0w4/image-7-4.png",
        strStyleNumber: "DWBFM4Q-108636",
        strDesignNumber: "DERS28MOVR",
        strCustomer: "Alex Williams",
        strCustomerImageUrl: "https://i.ibb.co/BLyLVHS/Frame-3978.png",
        strSalesman: "John Samanta",
        strSalesmanImageUrl: "https://i.ibb.co/hy6pH4g/Frame-3977.png",
        strApprovedBy: "John Samanta",
        strApprovedByImageUrl: "https://i.ibb.co/BLyLVHS/Frame-3978.png",
        strApprovedOn: "24/03/2023",
      ),
    );

    designerList.add(DesignerListModel(name: "Albert Flores", image: "https://i.ibb.co/729SGNK/Ellipse-10.png", isSelected: true));
    designerList.add(DesignerListModel(name: "Brooklyn Simmons", image: "https://i.ibb.co/fxCNcfr/Ellipse-9.png"));
    designerList.add(DesignerListModel(name: "Ralph Edwards", image: "https://i.ibb.co/SRqFmPK/Ellipse-91.png"));
    designerList.add(DesignerListModel(name: "Albert Flores", image: "https://i.ibb.co/Cm7hxkk/Ellipse-92.png"));
    designerList.add(DesignerListModel(name: "Brooklyn Simmons", image: "https://i.ibb.co/fxCNcfr/Ellipse-9.png"));
    designerList.add(DesignerListModel(name: "Ralph Edwards", image: "https://i.ibb.co/SRqFmPK/Ellipse-91.png"));
    designerList.add(DesignerListModel(name: "Albert Flores", image: "https://i.ibb.co/Cm7hxkk/Ellipse-92.png"));
    refreshCompleter.complete(true);
    emit(const MonitoringListLoadedState());
  }

  void _onDesignerLoadMoreEvent(MonitoringDesignerLoadMoreEvent event, Emitter<MonitoringState> emit) async {
    emit(const MonitoringDesignerLoadMoreState());
    await Future.delayed(const Duration(seconds: 2));

    List<DesignerListModel> dummyList = [];

    dummyList.add(DesignerListModel(name: "Albert Flores", image: "https://i.ibb.co/729SGNK/Ellipse-10.png"));
    dummyList.add(DesignerListModel(name: "Brooklyn Simmons", image: "https://i.ibb.co/fxCNcfr/Ellipse-9.png"));
    dummyList.add(DesignerListModel(name: "Ralph Edwards", image: "https://i.ibb.co/SRqFmPK/Ellipse-91.png"));
    dummyList.add(DesignerListModel(name: "Albert Flores", image: "https://i.ibb.co/Cm7hxkk/Ellipse-92.png"));
    dummyList.add(DesignerListModel(name: "Brooklyn Simmons", image: "https://i.ibb.co/fxCNcfr/Ellipse-9.png"));
    dummyList.add(DesignerListModel(name: "Ralph Edwards", image: "https://i.ibb.co/SRqFmPK/Ellipse-91.png"));
    dummyList.add(DesignerListModel(name: "Albert Flores", image: "https://i.ibb.co/Cm7hxkk/Ellipse-92.png"));

    designerList.addAll(dummyList);

    designerScrollController.isPageLoaded.complete(event.currentPage == 3);
    emit(MonitoringDesignerListLoadedState(event.currentPage + 1));
  }

  Future<void> _onMonitoringListPullToRefreshEvent(MonitoringListPullToRefreshEvent event, Emitter<MonitoringState> emit) async {
    emit(const MonitoringReloadState());
    await Future.delayed(const Duration(seconds: 2));
    currentController.pullToRefresh();
    switch (event.listType) {
      case MonitoringTab.presentations:
        presentationList = generatePresentationData(0);
        break;
      case MonitoringTab.dbf:
        dbfList = generateDbfData(0);
        break;
      case MonitoringTab.designs:
        designsList = generateDesignsData(0);
        break;
      case MonitoringTab.styles:
        stylesList = generateStylesData(0);
        break;
    }
    refreshCompleter.complete(true);
    emit(const MonitoringListLoadedState());
  }

  void _onSelectedDesignerEvent(MonitoringSelectedDesignerEvent event, Emitter<MonitoringState> emit) {
    emit(const MonitoringReloadState());
    final int index = designerList.indexWhere((element) => element == event.designer);
    if (index != -1) {
      designerList[index].isSelected = !designerList[index].isSelected;
      emit(MonitoringSelectedDesignerState(designerList[index]));
    }
  }

  void _onTabChangedEvent(MonitoringOnTabChangedEvent event, Emitter<MonitoringState> emit) {
    emit(const MonitoringReloadState());
    final MonitoringTab currentTab = MonitoringTab.values[tabController.index];
    switch (currentTab) {
      case MonitoringTab.presentations:
        // Presentations logic
        break;
      case MonitoringTab.dbf:
        // DBF logic
        break;
      case MonitoringTab.designs:
        // Designs logic
        break;
      case MonitoringTab.styles:
        // Styles logic
        break;
    }
    emit(const MonitoringOnTabChangedState());
  }

  Future<void> _onListingLoadMoreEvent(MonitoringListingLoadMoreEvent event, Emitter<MonitoringState> emit) async {
    emit(MonitoringLoadingMoreState(event.listType));
    await Future.delayed(const Duration(seconds: 2));

    List<B2BCustomListingDataModel> newDataList = [];

    switch (event.listType) {
      case MonitoringTab.presentations:
        newDataList = generatePresentationData(event.currentPage);
        presentationList.addAll(newDataList);
        presentationsScrollController.isPageLoaded.complete(event.currentPage == 3);
        break;
      case MonitoringTab.dbf:
        newDataList = generateDbfData(event.currentPage);
        dbfList.addAll(newDataList);
        dbfScrollController.isPageLoaded.complete(event.currentPage == 3);
        break;
      case MonitoringTab.designs:
        newDataList = generateDesignsData(event.currentPage);
        designsList.addAll(newDataList);
        designsScrollController.isPageLoaded.complete(event.currentPage == 3);
        break;
      case MonitoringTab.styles:
        newDataList = generateStylesData(event.currentPage);
        stylesList.addAll(newDataList);
        stylesScrollController.isPageLoaded.complete(event.currentPage == 3);
        break;
    }

    emit(MonitoringListLoadedMoreState(event.currentPage + 1, event.listType));
  }

  // Method to generate presentation data
  List<B2BCustomListingDataModel> generatePresentationData(int currentPage) {
    return List.generate(
      4,
      (index) => B2BCustomListingDataModel(
        id: index.toString(),
        strPresentationNumber: ((currentPage * 10) + index + 1).toString(),
        status: ProjectStatus.approved,
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
  }

// Method to generate dbf data
  List<B2BCustomListingDataModel> generateDbfData(int currentPage) {
    return List.generate(
      4,
      (index) => B2BCustomListingDataModel(
        id: index.toString(),
        strDbfNumber: "1234543",
        designCreationStatus: ProjectStatus.approved,
        strCustomer: "Alex Williams",
        strCustomerImageUrl: "https://i.ibb.co/BLyLVHS/Frame-3978.png",
        designApprovalStatus: ProjectStatus.approved,
        strSalesman: "John Samanta",
        strSalesmanImageUrl: "https://i.ibb.co/hy6pH4g/Frame-3977.png",
        dbfApprovalStatus: ProjectStatus.approved,
        strRevisedDate: "24/03/2023",
        holdStatus: ProjectStatus.released,
      ),
    );
  }

// Method to generate designs data
  List<B2BCustomListingDataModel> generateDesignsData(int currentPage) {
    return List.generate(
      4,
      (index) => B2BCustomListingDataModel(
          id: index.toString(),
          status: ProjectStatus.approved,
          strDesignListingImageUrl: "https://i.ibb.co/PMTr7Jp/Image.png",
          strDesignNumber: "DERS28MOVR",
          strDbfNumber: "1234574",
          strCustomer: "Alex Williams",
          strCustomerImageUrl: "https://i.ibb.co/BLyLVHS/Frame-3978.png",
          strSalesman: "John Samanta",
          strSalesmanImageUrl: "https://i.ibb.co/hy6pH4g/Frame-3977.png",
          strApprovedBy: "John Samanta",
          strApprovedByImageUrl: "https://i.ibb.co/BLyLVHS/Frame-3978.png",
          strApprovedOn: "24/03/2023"),
    );
  }

  // Method to generate styles data
  List<B2BCustomListingDataModel> generateStylesData(int currentPage) {
    return List.generate(
      4,
      (index) => B2BCustomListingDataModel(
        id: index.toString(),
        status: ProjectStatus.blueInProgress,
        strDesignListingImageUrl: "https://i.ibb.co/PMTr7Jp/Image.png",
        strStyleNumber: "DWBFM4Q-108636",
        strDesignNumber: "DERS28MOVR",
        strCustomer: "Alex Williams",
        strCustomerImageUrl: "https://i.ibb.co/BLyLVHS/Frame-3978.png",
        strSalesman: "John Samanta",
        strSalesmanImageUrl: "https://i.ibb.co/hy6pH4g/Frame-3977.png",
        strApprovedBy: "John Samanta",
        strApprovedByImageUrl: "https://i.ibb.co/BLyLVHS/Frame-3978.png",
        strApprovedOn: "24/03/2023",
      ),
    );
  }

  SmartPaginationScrollController get currentController {
    final MonitoringTab currentTab = MonitoringTab.values[tabController.index];
    switch (currentTab) {
      case MonitoringTab.presentations:
        return presentationsScrollController;
      case MonitoringTab.dbf:
        return dbfScrollController;
      case MonitoringTab.designs:
        return designsScrollController;
      case MonitoringTab.styles:
        return stylesScrollController;
    }
  }

  // Getter for the current list based on the selected tab
  List<B2BCustomListingDataModel> get currentList {
    final MonitoringTab currentTab = MonitoringTab.values[tabController.index];
    switch (currentTab) {
      case MonitoringTab.presentations:
        return presentationList;
      case MonitoringTab.dbf:
        return dbfList;
      case MonitoringTab.designs:
        return designsList;
      case MonitoringTab.styles:
        return stylesList;
      default:
        return presentationList; // Default case
    }
  }

  // Getter for the listing type based on the selected tab
  B2BListingType get currentListingType {
    final MonitoringTab currentTab = MonitoringTab.values[tabController.index];
    switch (currentTab) {
      case MonitoringTab.presentations:
        return B2BListingType.monitoringPresentationGridType;
      case MonitoringTab.dbf:
        return B2BListingType.monitoringDbfType;
      case MonitoringTab.designs:
        return B2BListingType.monitoringDesignsType;
      case MonitoringTab.styles:
        return B2BListingType.monitoringStylesType;
      default:
        return B2BListingType.monitoringPresentationGridType; // Default case
    }
  }

  Future<bool> pullToRefresh() async {
    if (!refreshCompleter.isCompleted) {
      return false;
    }
    refreshCompleter = Completer<bool>();
    final MonitoringTab currentTab = MonitoringTab.values[tabController.index];
    add(MonitoringListPullToRefreshEvent(listType: currentTab));
    bool result = await refreshCompleter.future;
    return result;
  }

  // Method to build the list view widget based on the selected tab
  Widget buildListView(BuildContext context, MonitoringTab currentTab) {
    return Expanded(
      child: BlocBuilder<MonitoringBloc, MonitoringState>(
        buildWhen: (previous, current) =>
            current is MonitoringListLoadedState || current is MonitoringOnTabChangedState || current is MonitoringListLoadedMoreState,
        builder: (context, state) {
          if (currentList.isEmpty) {
            return NoDataFoundWidget(text: APPStrings.noPresentationFound.tr); // Adjust text based on the selected tab if necessary
          }

          return SmartRefreshIndicator(
            onRefresh: () async {
              await pullToRefresh();
            },
            child: ListView.separated(
              itemCount: currentList.length,
              controller: currentController.scrollController,
              itemBuilder: (context, index) {
                return BlocBuilder<MonitoringBloc, MonitoringState>(
                  buildWhen: (previous, current) => current is MonitoringLoadingMoreState || current is MonitoringListLoadedMoreState,
                  builder: (context, state) {
                    return Column(
                      children: [
                        B2BListingItem(
                          onTap: () {},
                          onTapMenuButton: () {
                            if (currentTab == MonitoringTab.presentations) {
                              // Handle presentations menu button tap
                            } else if (currentTab == MonitoringTab.dbf) {
                              if (designerScrollController.isInitialised) {
                                designerScrollController.dispose();
                                designerScrollController = SmartPaginationScrollController();
                              }
                              designerScrollController.init(
                                tag: "designerScrollController",
                                loadAction: (int currentPage) async {
                                  add(MonitoringDesignerLoadMoreEvent(currentPage: currentPage));
                                },
                              );
                              _showDesignerPopupMenu(context);
                            } else if (currentTab == MonitoringTab.designs) {
                              // Handle designs menu button tap
                            } else if (currentTab == MonitoringTab.styles) {
                              // Handle styles menu button tap
                            }
                          },
                          type: currentListingType,
                          listingItemModel: currentList[index],
                          margin: index == currentList.length - 1 ? EdgeInsets.only(bottom: 20.h) : EdgeInsets.zero,
                        ),
                        if (state is MonitoringLoadingMoreState && index == currentList.length - 1) const SmartCircularProgressIndicator(),
                      ],
                    );
                  },
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
            ),
          );
        },
      ),
    );
  }

  void _showDesignerPopupMenu(BuildContext context) {
    Utils.showSmartModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12.r), topRight: Radius.circular(12.r)),
      ),
      builder: (context) => MonitoringDesignerBottomSheet(monitoringBloc: this),
    );
  }
}
