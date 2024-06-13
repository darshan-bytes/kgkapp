import 'package:kgk/kgk.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  List<ProfileListModel> profileActionList = [];

  List<ProfileListModel> profileChildrenList = [];

  bool isExpandedList = false;

  ProfileBloc() : super(ProfileInitialState()) {
    on<InitialProfileListEvent>(_onInitialProfileListEvent);
    on<ToggleProfileListEvent>(_onToggleProfileListEvent);
  }

  Future<void> _onInitialProfileListEvent(InitialProfileListEvent event, Emitter<ProfileState> emit) async {
    profileActionList = [
      ProfileListModel(
          image: AppImages.icMyOrders,
          title: APPStrings.myOrder.tr,
          subTitle: APPStrings.listOfAllTheOrdersYouPlaced.tr,
          trailingIcon: AppImages.icArrowRight,
          onTap: () {
            event.context.pushNamed(AppRoutes.orderPage);
          }),
      ProfileListModel(
          image: AppImages.icActions,
          title: APPStrings.auctions.tr,
          subTitle: APPStrings.listOfAuctionsYouAppliedTo.tr,
          trailingIcon: AppImages.icArrowRight,
          onTap: () {
            event.context.pushNamed(AppRoutes.auctionListingPage);
          }),
      ProfileListModel(
          image: AppImages.icInquiries,
          title: APPStrings.myInquiries.tr,
          subTitle: APPStrings.yourSubmittedInquiries.tr,
          trailingIcon: AppImages.icArrowRight,
          onTap: () {}),
      ProfileListModel(
          image: AppImages.icNewsFeed,
          title: APPStrings.newsFeed.tr,
          subTitle: APPStrings.createAndSeeNewsFeeds.tr,
          trailingIcon: AppImages.icArrowRight,
          onTap: () {}),
      ProfileListModel(
          image: AppImages.icStore,
          title: APPStrings.findAStore.tr,
          subTitle: APPStrings.searchYourNearbyStores.tr,
          trailingIcon: AppImages.icArrowRight,
          onTap: () {}),
      ProfileListModel(
          image: AppImages.icMapPin,
          title: APPStrings.saveAddress.tr,
          subTitle: APPStrings.listOfAllYourSavedAddresses.tr,
          trailingIcon: AppImages.icArrowRight,
          onTap: () {}),
      ProfileListModel(
          image: AppImages.icLock,
          title: APPStrings.changePassword.tr,
          subTitle: APPStrings.changeYourExistingPassword.tr,
          trailingIcon: AppImages.icArrowRight,
          onTap: () {}),
      ProfileListModel(
          image: AppImages.icPreferences,
          title: APPStrings.preferences.tr,
          subTitle: APPStrings.defaultCountryLanguageAndCurrency.tr,
          trailingIcon: AppImages.icArrowRight,
          onTap: () {}),
    ];
    profileChildrenList = [
      ProfileListModel(image: AppImages.icAboutUs, title: APPStrings.aboutUs.tr, onTap: () {}),
      ProfileListModel(
          image: AppImages.icEducation,
          title: APPStrings.education.tr,
          isSubListExpanded: false,
          profileChildrenList: [
            ProfileListModel(
              title: APPStrings.diamond.tr,
              onTap: () {},
            ),
            ProfileListModel(
              title: APPStrings.labCreatedDiamonds.tr,
              onTap: () {},
            ),
            ProfileListModel(
              title: APPStrings.gemstone.tr,
              onTap: () {},
            ),
            ProfileListModel(
              title: APPStrings.metals.tr,
              onTap: () {},
            ),
            ProfileListModel(
              title: APPStrings.ringSizer.tr,
              onTap: () {},
            ),
          ],
          onTap: () {}),
      ProfileListModel(image: AppImages.icPolicies, title: APPStrings.policies.tr, onTap: () {}),
    ];
  }

  void _onToggleProfileListEvent(ToggleProfileListEvent event, Emitter<ProfileState> emit) {
    emit(ProfileReloadState());
    profileChildrenList[event.index].isSubListExpanded = !profileChildrenList[event.index].isSubListExpanded;
    emit(const ToggleProfileState());
  }
}
