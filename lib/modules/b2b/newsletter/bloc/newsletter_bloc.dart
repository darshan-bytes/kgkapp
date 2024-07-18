import 'package:kgk/kgk.dart';

part 'newsletter_event.dart';

part 'newsletter_state.dart';

enum NewsletterTab {
  template,
  categories,
  subscribers,
}

class NewsletterBloc extends Bloc<NewsletterEvent, NewsletterState> {
  UserType userType = UserType.b2cUser;

  late TabController tabController;
  final TextEditingController templateSearchController = TextEditingController();
  final TextEditingController categorySearchController = TextEditingController();
  final TextEditingController subscribersSearchController = TextEditingController();

  SmartPaginationScrollController templateScrollController = SmartPaginationScrollController();
  SmartPaginationScrollController categoryScrollController = SmartPaginationScrollController();
  SmartPaginationScrollController subscribersScrollController = SmartPaginationScrollController();

  // Tabs
  final List<Widget> tabs = <Widget>[
    Tab(text: APPStrings.template.tr),
    Tab(text: APPStrings.categories.tr),
    Tab(text: APPStrings.subscribers.tr),
  ];

  // newsletter lists
  List<TemplateListModel> templateList = _generateTemplateNewsletterList();
  List<B2BCustomListingDataModel> categoryList = [];
  List<B2BCustomListingDataModel> subscribersList = [];

  Completer<bool> refreshCompleter = Completer<bool>();

  //Newsletter tab bar view
  List<Widget> buildTabBarView(NewsletterBloc bloc) {
    return [
      NewsletterTemplateTabView(bloc: bloc),
      NewsletterCategoriesTabView(bloc: bloc),
      NewsletterSubscriberTabView(bloc: bloc),
    ];
  }

  NewsletterBloc() : super(const NewsletterInitialState()) {
    on<NewsletterInitialEvent>(_onInitNewsletterEvent);
    on<NewsletterListingLoadMoreEvent>(_onListingLoadMoreEvent);
    on<ChangeNewsletterTabsEvent>(_onChangeTabEvent);
    on<NewsletterListPullToRefreshEvent>(_onListPullToRefreshEvent);
  }

  void _onInitNewsletterEvent(NewsletterInitialEvent event, Emitter<NewsletterState> emit) {
    emit(const NewsletterReloadState());
    userType = BlocProvider.of<AppBloc>(event.context).userType;
    if (refreshCompleter.isCompleted) {
      refreshCompleter = Completer<bool>();
    }
    clearData();
    templateList = _generateTemplateNewsletterList();
    categoryList = _generateCategoryNewsletterList();
    subscribersList = _generateSubscribersNewsletterList();

    if (templateScrollController.isInitialised) {
      templateScrollController.dispose();
      templateScrollController = SmartPaginationScrollController();
    }

    templateScrollController.init(
      loadAction: (int currentPage) async {
        add(NewsletterListingLoadMoreEvent(currentPage: currentPage, listType: NewsletterTab.template));
      },
    );

    if (categoryScrollController.isInitialised) {
      categoryScrollController.dispose();
      categoryScrollController = SmartPaginationScrollController();
    }

    categoryScrollController.init(
      loadAction: (int currentPage) async {
        add(NewsletterListingLoadMoreEvent(currentPage: currentPage, listType: NewsletterTab.categories));
      },
    );

    if (subscribersScrollController.isInitialised) {
      subscribersScrollController.dispose();
      subscribersScrollController = SmartPaginationScrollController();
    }

    subscribersScrollController.init(
      loadAction: (int currentPage) async {
        add(NewsletterListingLoadMoreEvent(currentPage: currentPage, listType: NewsletterTab.subscribers));
      },
    );

    refreshCompleter.complete(true);
    emit(const NewsletterListLoadedState());
  }

  void _onChangeTabEvent(ChangeNewsletterTabsEvent event, Emitter<NewsletterState> emit) {
    emit(const NewsletterReloadState());
    final NewsletterTab currentTab = NewsletterTab.values[tabController.index];
    switch (currentTab) {
      case NewsletterTab.template:
        categorySearchController.clear();
        subscribersSearchController.clear();
        break;
      case NewsletterTab.categories:
        subscribersSearchController.clear();
        templateSearchController.clear();
        break;
      case NewsletterTab.subscribers:
        templateSearchController.clear();
        categorySearchController.clear();
        break;
    }
    emit(const ChangeNewsletterTabsState());
  }

  Future<void> _onListingLoadMoreEvent(NewsletterListingLoadMoreEvent event, Emitter<NewsletterState> emit) async {
    emit(NewsletterLoadingMoreState(event.listType));
    await Future.delayed(const Duration(seconds: 2));

    List<B2BCustomListingDataModel> newDataList = [];
    List<TemplateListModel> newTemplateDataList = [];

    switch (event.listType) {
      case NewsletterTab.template:
        newTemplateDataList = _generateTemplateNewsletterList();
        templateList.addAll(newTemplateDataList);
        templateScrollController.isPageLoaded.complete(event.currentPage == 3);
        break;
      case NewsletterTab.categories:
        newDataList = _generateCategoryNewsletterList();
        categoryList.addAll(newDataList);
        categoryScrollController.isPageLoaded.complete(event.currentPage == 3);
        break;
      case NewsletterTab.subscribers:
        newDataList = _generateSubscribersNewsletterList();
        subscribersList.addAll(newDataList);
        subscribersScrollController.isPageLoaded.complete(event.currentPage == 3);
        break;
    }

    emit(NewsletterListLoadedMoreState(event.currentPage + 1, event.listType));
  }

  Future<void> _onListPullToRefreshEvent(NewsletterListPullToRefreshEvent event, Emitter<NewsletterState> emit) async {
    emit(const NewsletterReloadState());
    await Future.delayed(const Duration(seconds: 2));
    switch (event.listType) {
      case NewsletterTab.template:
        templateScrollController.pullToRefresh();
        templateList = _generateTemplateNewsletterList();
        break;
      case NewsletterTab.categories:
        categoryScrollController.pullToRefresh();
        categoryList = _generateCategoryNewsletterList();
        break;
      case NewsletterTab.subscribers:
        subscribersScrollController.pullToRefresh();
        subscribersList = _generateSubscribersNewsletterList();
        break;
    }
    refreshCompleter.complete(true);
    emit(const NewsletterListLoadedState());
  }

  Future<bool> pullToRefresh() async {
    if (!refreshCompleter.isCompleted) {
      return false;
    }
    refreshCompleter = Completer<bool>();
    final NewsletterTab currentTab = NewsletterTab.values[tabController.index];
    add(NewsletterListPullToRefreshEvent(listType: currentTab));
    bool result = await refreshCompleter.future;
    return result;
  }

  void clearData() {
    templateSearchController.clear();
    categorySearchController.clear();
    subscribersSearchController.clear();
    tabController.animateTo(0);
    templateList = [];
    categoryList = [];
    subscribersList = [];
  }

  @override
  Future<void> close() {
    templateScrollController.dispose();
    categoryScrollController.dispose();
    subscribersScrollController.dispose();
    return super.close();
  }

  // Helper methods
  static List<TemplateListModel> _generateTemplateNewsletterList() {
    return [
      TemplateListModel(
          title: "Festival Offer Reminder",
          templateSubList: List.generate(
            2,
            (index) => B2BCustomListingDataModel(
              id: "1",
              strName: "Festival offer reminder - New year",
              status: ProjectStatus.inActive,
              strCountry: "USA",
              strCountryImageUrl: AppImages.icFlagUSA,
              strValidity: "Default",
              strCreatedBy: "Jenny Wilson",
              strCreatedByImageUrl: "https://i.ibb.co/vk9xjQw/Frame-3977-1.png",
            ),
          )),
      TemplateListModel(
          title: "New Product Announcement",
          templateSubList: List.generate(
            8,
            (index) => B2BCustomListingDataModel(
              id: "1",
              strName: "Festival offer reminder - New year",
              status: index % 2 == 0 ? ProjectStatus.active : ProjectStatus.inActive,
              strCountry: "USA",
              strCountryImageUrl: AppImages.icFlagUSA,
              strValidity: "Default",
              strCreatedBy: "Jenny Wilson",
              strCreatedByImageUrl: "https://i.ibb.co/vk9xjQw/Frame-3977-1.png",
            ),
          )),
    ];
  }

  static List<B2BCustomListingDataModel> _generateCategoryNewsletterList() {
    return List.generate(
      8,
      (index) => B2BCustomListingDataModel(
        id: index.toString(),
        strName: "Andrew Lewis",
        strCreatedBy: "Jenny Wilson",
        strCreatedByImageUrl: "https://i.ibb.co/vk9xjQw/Frame-3977-1.png",
        strCreatedOn: "17/03/23 06:00 PM",
      ),
    );
  }

  static List<B2BCustomListingDataModel> _generateSubscribersNewsletterList() {
    return List.generate(
      8,
      (index) => B2BCustomListingDataModel(
        id: index.toString(),
        strName: 'Marvin McKinney',
        strNameImageUrl: 'https://i.ibb.co/vk9xjQw/Frame-3977-1.png',
        strEmail: 'user@domain.com',
        strAddedOn: '17/03/23 06:00 PM',
      ),
    );
  }
}
