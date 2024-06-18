import 'package:kgk/kgk.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode contactNumberFocusNode = FocusNode();
  FocusNode currentPasswordFocusNode = FocusNode();
  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

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
          onTap: () {
            Utils.showSmartModalBottomSheet(
              context: event.context,
              isScrollControlled: true,
              useSafeArea: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12.r), topRight: Radius.circular(12.r)),
              ),
              builder: (context) => const ChangePasswordBottomSheet(),
            );
          }),
      ProfileListModel(
          image: AppImages.icPreferences,
          title: APPStrings.preferences.tr,
          subTitle: APPStrings.defaultCountryLanguageAndCurrency.tr,
          trailingIcon: AppImages.icArrowRight,
          onTap: () {}),
      ProfileListModel(
          image: AppImages.icPreferences,
          title: APPStrings.preferences.tr,
          subTitle: APPStrings.defaultCountryLanguageAndCurrency.tr,
          trailingIcon: AppImages.icArrowRight,
          onTap: () {
            event.context.pushNamed(AppRoutes.notificationSettingsPage);
          }),
    ];
    profileChildrenList = [
      ProfileListModel(
          image: AppImages.icAboutUs,
          title: APPStrings.aboutUs.tr,
          onTap: () {
            event.context.pushNamed(AppRoutes.cmsWebViewPage, arguments: {
              RoutesData.cmsPageData: CmsWebViewDataModel(
                url: 'https://www.kgkgroup.com/story-of-kgk/',
                title: APPStrings.aboutUs.tr,
              )
            });
          }),
      ProfileListModel(
          image: AppImages.icEducation,
          title: APPStrings.education.tr,
          isSubListExpanded: false,
          profileChildrenList: [
            ProfileListModel(
              title: APPStrings.diamond.tr,
              onTap: () {
                event.context.pushNamed(AppRoutes.cmsWebViewPage, arguments: {
                  RoutesData.cmsPageData: CmsWebViewDataModel(
                    url: 'https://www.kgkgroup.com/diamond-operations/',
                    title: APPStrings.diamond.tr,
                  )
                });
              },
            ),
            ProfileListModel(
              title: APPStrings.labCreatedDiamonds.tr,
              onTap: () {
                event.context.pushNamed(AppRoutes.cmsWebViewPage, arguments: {
                  RoutesData.cmsPageData: CmsWebViewDataModel(
                    url: 'https://kgkgroup.com/',
                    title: APPStrings.labCreatedDiamonds.tr,
                  )
                });
              },
            ),
            ProfileListModel(
              title: APPStrings.gemstone.tr,
              onTap: () {
                event.context.pushNamed(AppRoutes.cmsWebViewPage, arguments: {
                  RoutesData.cmsPageData: CmsWebViewDataModel(
                    url: 'https://www.kgkgroup.com/gemstones/',
                    title: APPStrings.gemstone.tr,
                  )
                });
              },
            ),
            ProfileListModel(
              title: APPStrings.metals.tr,
              onTap: () {
                event.context.pushNamed(AppRoutes.cmsWebViewPage, arguments: {
                  RoutesData.cmsPageData: CmsWebViewDataModel(
                    url: 'https://www.kgkgroup.com/metals/',
                    title: APPStrings.metals.tr,
                  )
                });
              },
            ),
            ProfileListModel(
              title: APPStrings.ringSizer.tr,
              onTap: () {
                event.context.pushNamed(AppRoutes.cmsWebViewPage, arguments: {
                  RoutesData.cmsPageData: CmsWebViewDataModel(
                    url: 'https://www.kgkgroup.com/ring-sizer/',
                    title: APPStrings.ringSizer.tr,
                  )
                });
              },
            ),
          ],
          onTap: () {}),
      ProfileListModel(
          image: AppImages.icPolicies,
          title: APPStrings.policies.tr,
          onTap: () {
            event.context.pushNamed(AppRoutes.cmsWebViewPage, arguments: {
              RoutesData.cmsPageData: CmsWebViewDataModel(
                url: 'https://www.kgkgroup.com/privacy-policy/',
                title: APPStrings.policies.tr,
              )
            });
          }),
    ];
  }

  void _onToggleProfileListEvent(ToggleProfileListEvent event, Emitter<ProfileState> emit) {
    emit(ProfileReloadState());
    if (profileChildrenList[event.index].profileChildrenList.isNotNullNorEmpty) {
      profileChildrenList[event.index].isSubListExpanded = !profileChildrenList[event.index].isSubListExpanded;
      emit(const ToggleProfileState());
    } else {
      profileChildrenList[event.index].onTap?.call();
    }
  }
}
