import 'package:kgk/kgk.dart';

part 'user_master_listing_event.dart';

part 'user_master_listing_state.dart';

class UserMasterListingBloc extends Bloc<UserMasterListingEvent, UserMasterListingState> {
  // Controller for search
  final TextEditingController userMasterSearchController = TextEditingController();

  // List of Users
  List<B2BCustomListingDataModel> userMasterList = [];

  // Pagination controller
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  UserLocationModel? selectedUserLocationType;

  // User Location types
  final List<UserLocationModel> userLocationTypeList = [
    UserLocationModel(name: "Location"),
    UserLocationModel(name: "Ahmedabad"),
    UserLocationModel(name: "Delhi"),
    UserLocationModel(name: "Mumbai"),
  ];

  UserMasterListingBloc() : super(UserMasterListingInitial()) {
    on<InitialUserMasterListingEvent>(_onInitialUserMasterListEvent);
    on<UserMasterListLoadMoreEvent>(_onUserMasterListLoadMoreEvent);
    on<UserMasterChangeLocationTypeEvent>(_onUserMasterChangeLocationTypeEvent);
  }

  void _onInitialUserMasterListEvent(InitialUserMasterListingEvent event, Emitter<UserMasterListingState> emit) {
    emit(UserMasterListReloadState());
    clearData();
    userMasterList = _generateUserMasterList();
    selectedUserLocationType = userLocationTypeList.first;
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(UserMasterListLoadMoreEvent(currentPage));
      },
    );
    emit(UserMasterListingLoadedState());
  }

  Future<void> _onUserMasterListLoadMoreEvent(UserMasterListLoadMoreEvent event, Emitter<UserMasterListingState> emit) async {
    emit(const UserMasterListLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    userMasterList.addAll(_generateUserMasterList());
    paginationScrollController.isPageLoaded.complete(event.currentPage == 5);
    emit(UserMasterListLoadedMoreState(event.currentPage + 1));
  }

  void _onUserMasterChangeLocationTypeEvent(UserMasterChangeLocationTypeEvent event, Emitter<UserMasterListingState> emit) {
    emit(UserMasterListReloadState());
    selectedUserLocationType = event.selectedUserLocationType;
    if (selectedUserLocationType != null) {
      emit(UserMasterChangeLocationTypeState(selectedUserLocationType!));
    }
  }

  void clearData() {
    userMasterSearchController.clear();
    userMasterList.clear();
  }

  static List<B2BCustomListingDataModel> _generateUserMasterList() {
    return List.generate(8, (index) {
      return B2BCustomListingDataModel(
        id: index.toString(),
        strName: 'Andrew Lewis',
        strNameImageUrl: "https://i.ibb.co/XtWkv3v/Frame-3977.png",
        strBusinessType: "Diamond",
        strBusinessTypeImageUrl: AppImages.icDiamond,
        strCompanyRepresentative: "Pristine Gems Co.",
        strMarket: "New York, USA",
        strMarketFlagImageUrl: AppImages.icFlagUSA,
        strEmail: "sales@domain.com",
      );
    });
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }
}
