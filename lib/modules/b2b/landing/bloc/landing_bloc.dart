import 'package:kgk/kgk.dart';

part 'landing_event.dart';

part 'landing_state.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  UserType userType = UserType.b2cUser;
  static const int homeIndex = 0;
  static const int categoriesIndex = 1;
  static const int myBagIndex = 2;
  static const int supportIndex = 3;
  static const int companyIndex = 3;
  static const int profileIndex = 4;

  ///[currentIndex] is used to keep track of the current index of the bottom navigation bar
  int currentIndex = 0;

  ///[pages] is a list of widgets that will be displayed on the screen based on the current index
  List<Widget> pages = [];

  ///[bottomNavigationBarDataModel] is a list of data models that are used to build the bottom navigation bar
  List<BottomNavigationBarDataModel> bottomNavigationBarDataModel = [];

  ///[blocList] is a list of blocs that are used in the bottom navigation bar and used for performing
  /// actions on the screen based on the current index
  List<Bloc> blocList = [];

  bool _isInitialized = false;

  StreamSubscription<BranchLinkDataModel>? _deepLinkSubscription;

  LandingBloc() : super(LandingInitialState()) {
    on<LandingInitialEvent>(_onLandingInitialEvent);
    on<LandingChangeTabEvent>(_onLandingChangeTabEvent);
    on<LandingLogoutEvent>(_onLandingLogoutEvent);
    on<LandingChangeMyBagCountEvent>(_onLandingChangeMyBagCount);
  }

  @override
  Future<void> close() async {
    _deepLinkSubscription?.cancel();
    return super.close();
  }

  Future<void> _onLandingInitialEvent(LandingInitialEvent event, Emitter<LandingState> emit) async {
    if (_isInitialized) {
      return;
    }
    userType = BlocProvider.of<AppBloc>(event.context).userType;

    switch (userType) {
      case UserType.b2cUser:
        _initializeB2CUser(event.context);
        break;
      case UserType.b2bUser:
      case UserType.internal:
        _initializeB2BUser(event.context);
        break;
    }
    blocList[0].add(HomeInitialEvent(context: event.context));
    if (userType == UserType.internal && (StorageManager().getSelectedCsc() == null)) {
      currentIndex = companyIndex;
      blocList[companyIndex].add(InitialCompanyListEvent(context: event.context));
    }
    emit(LandingLoadedState(userType: userType, pages: pages, blocList: blocList));
    _isInitialized = true;
    await initBranchAndNavigation(event.context);
  }

  void _initializeB2CUser(BuildContext context) {
    currentIndex = homeIndex;
    pages = [
      const HomeScreen(),
      const CategoriesScreen(),
      const MyBagScreen(),
      const SupportScreen(),
      const ProfileScreen(),
    ];

    blocList = [
      BlocProvider.of<HomeBloc>(context),
      BlocProvider.of<CategoriesBloc>(context),
      BlocProvider.of<MyBagBloc>(context),
      BlocProvider.of<SupportBloc>(context),
      BlocProvider.of<ProfileBloc>(context),
    ];

    bottomNavigationBarDataModel = [
      BottomNavigationBarDataModel(
        icon: AppImages.icHome,
        activeIcon: AppImages.icHomeActive,
        label: APPStrings.home,
      ),
      BottomNavigationBarDataModel(
        icon: AppImages.icCategories,
        activeIcon: AppImages.icCategoriesActive,
        label: APPStrings.categories,
      ),
      BottomNavigationBarDataModel(
        icon: AppImages.icShoppingBag,
        activeIcon: AppImages.icShoppingBagActive,
        label: APPStrings.myBag,
        notificationCount: 0,
      ),
      BottomNavigationBarDataModel(
        icon: AppImages.icSupport,
        activeIcon: AppImages.icSupportActive,
        label: APPStrings.support,
      ),
      BottomNavigationBarDataModel(
        icon: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
        activeIcon: "",
        label: APPStrings.profile,
        isProfile: true,
      ),
    ];
  }

  void _initializeB2BUser(BuildContext context) {
    currentIndex = homeIndex;
    pages = [
      const HomeScreen(),
      const CategoriesScreen(),
      const MyBagScreen(),
      const CompanyScreen(),
      const ProfileScreen(),
    ];

    blocList = [
      BlocProvider.of<HomeBloc>(context),
      BlocProvider.of<CategoriesBloc>(context),
      BlocProvider.of<MyBagBloc>(context),
      BlocProvider.of<CompanyBloc>(context),
      BlocProvider.of<ProfileBloc>(context),
    ];

    bottomNavigationBarDataModel = [
      BottomNavigationBarDataModel(
        icon: AppImages.icHome,
        activeIcon: AppImages.icHomeActive,
        label: APPStrings.home,
      ),
      BottomNavigationBarDataModel(
        icon: AppImages.icCategories,
        activeIcon: AppImages.icCategoriesActive,
        label: APPStrings.categories,
      ),
      BottomNavigationBarDataModel(
        icon: AppImages.icShoppingBag,
        activeIcon: AppImages.icShoppingBagActive,
        label: APPStrings.myBag,
        notificationCount: 0,
      ),
      BottomNavigationBarDataModel(
        icon: AppImages.icCompanyBottomNavbar,
        activeIcon: AppImages.icCompanyActive,
        label: APPStrings.company,
      ),
      BottomNavigationBarDataModel(
        icon: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
        activeIcon: "",
        label: APPStrings.profile,
        isProfile: true,
      ),
    ];
  }

  ///[_onLandingChangeTabEvent] is a method that is called when the [LandingChangeTabEvent] is dispatched
  /// to the bloc and it changes  the current index of the bottom navigation bar and emits the
  /// [LandingChangeTabState] with the new index to the UI.
  void _onLandingChangeTabEvent(
    LandingChangeTabEvent event,
    Emitter<LandingState> emit,
  ) {
    if (currentIndex != event.index) {
      currentIndex = event.index;
      if (userType == UserType.b2cUser) {
        switch (event.index) {
          case homeIndex:
            blocList[currentIndex].add(HomeInitialEvent(context: event.context));
            break;
          case categoriesIndex:
            blocList[currentIndex].add(CategoriesInitialEvent(context: event.context));
            break;
          case myBagIndex:
            blocList[currentIndex].add(InitialMyBagEvent(context: event.context));
            break;
          case supportIndex:
            blocList[currentIndex].add(SupportInitialEvent(context: event.context));
            break;
          case profileIndex:
            blocList[currentIndex].add(InitialProfileListEvent(context: event.context));
            break;
        }
      } else if (userType == UserType.b2bUser || userType == UserType.internal) {
        switch (event.index) {
          case homeIndex:
            blocList[currentIndex].add(HomeInitialEvent(context: event.context));
            break;
          case categoriesIndex:
            blocList[currentIndex].add(CategoriesInitialEvent(context: event.context));
            break;
          case myBagIndex:
            blocList[currentIndex].add(InitialMyBagEvent(context: event.context));
            break;

          case companyIndex:
            blocList[currentIndex].add(InitialCompanyListEvent(context: event.context));
            break;

          case profileIndex:
            blocList[currentIndex].add(InitialProfileListEvent(context: event.context));
            break;
        }
      }
      emit(LandingChangeTabState(event.index));
    }
  }

  void _onLandingChangeMyBagCount(LandingChangeMyBagCountEvent event, Emitter<LandingState> emit) {
    if (bottomNavigationBarDataModel[myBagIndex].notificationCount == null) return;
    bottomNavigationBarDataModel[myBagIndex].notificationCount = event.count;
    emit(LandingChangeMyBagCountState(event.count));
  }

  void _onLandingLogoutEvent(LandingLogoutEvent event, Emitter<LandingState> emit) {
    _isInitialized = false;
  }

  /// Initializes the Branch service and sets up deep link navigation.
  ///
  /// This method performs the following steps:
  /// 1. Initializes the Branch service.
  /// 2. Subscribes to the deep link stream from the Branch service.
  /// 3. Listens for deep link events and navigates to the appropriate screen based on the link type.
  Future<void> initBranchAndNavigation(BuildContext context) async {
    await BranchService().initialize();
    _deepLinkSubscription = BranchService().deepLinkStream.listen((BranchLinkDataModel branchLinkData) {
      switch (branchLinkData.branchLinkType) {
        case BranchLinkTypeType.productShare:
          context.pushNamed(AppRoutes.productDetailsPage, arguments: {
            RoutesData.productId: branchLinkData.id,
            RoutesData.isPageFor: getScreenIdentifierFromCommodity(branchLinkData.commodityEnum)
          });
          break;
        //TODO: Add more cases for different link types
        default:
          break;
      }
    });
  }

  /// Returns the appropriate [ScreenIdentifier] based on the given [Commodity].
  /// This method maps each [Commodity] to a specific [ScreenIdentifier] used for navigation.
  ScreenIdentifier getScreenIdentifierFromCommodity(Commodity commodity) {
    switch (commodity) {
      case Commodity.jewellery:
        return ScreenIdentifier.productForRing;
      case Commodity.diamond:
        return ScreenIdentifier.productForDiamonds;
      case Commodity.gemstone:
        return ScreenIdentifier.productForGemstones;
      default:
        return ScreenIdentifier.productForRing;
    }
  }
}
