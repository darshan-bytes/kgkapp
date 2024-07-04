import 'package:kgk/kgk.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserType userType = UserType.b2bUser;

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

  List<ProfileListModel> profileCMSList = [];

  List<ProfileListModel> profileAdminList = [];

  bool isExpandedList = false;

  ProfileBloc() : super(ProfileInitialState()) {
    on<InitialProfileListEvent>(_onInitialProfileListEvent);
    on<ToggleProfileListEvent>(_onToggleProfileListEvent);
  }

  Future<void> _onInitialProfileListEvent(InitialProfileListEvent event, Emitter<ProfileState> emit) async {
    userType = BlocProvider.of<AppBloc>(event.context).userType;
    if (userType == UserType.b2bUser) {
      profileActionList = [
        ProfileListModel(
            image: AppImages.icMyOrders,
            title: APPStrings.myOrder.tr,
            subTitle: APPStrings.listOfAllTheOrdersYouPlaced.tr,
            trailingIcon: AppImages.icArrowRight,
            onTap: () {
              event.context.pushNamed(AppRoutes.myOrderTypeSelectionPage);
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
            image: AppImages.icWatchlist,
            title: APPStrings.watchlist.tr,
            subTitle: APPStrings.listOfProductsAddedToWatchlist.tr,
            trailingIcon: AppImages.icArrowRight,
            onTap: () {
              event.context.pushNamed(AppRoutes.watchListPage);
            }),
        ProfileListModel(
            image: AppImages.icExhibition,
            title: APPStrings.exhibition.tr,
            subTitle: APPStrings.listOfExhibitionsOfKGK.tr,
            trailingIcon: AppImages.icArrowRight,
            onTap: () {
              event.context.pushNamed(AppRoutes.exhibitionListingPage);
            }),
        ProfileListModel(
            image: AppImages.icActivityLog,
            title: APPStrings.activityLog.tr,
            subTitle: APPStrings.getLogOnTheAccount.tr,
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
            onTap: () {
              event.context.pushNamed(AppRoutes.findStorePage);
            }),
        ProfileListModel(
            image: AppImages.icMapPin,
            title: APPStrings.savedAddress.tr,
            subTitle: APPStrings.listOfAllYourSavedAddresses.tr,
            trailingIcon: AppImages.icArrowRight,
            onTap: () {
              event.context.pushNamed(AppRoutes.savedAddressPage);
            }),
        ProfileListModel(
            image: AppImages.icLock,
            title: APPStrings.changePassword.tr,
            subTitle: APPStrings.changeYourExistingPassword.tr,
            trailingIcon: AppImages.icArrowRight,
            onTap: () {
              Utils.showSmartModalBottomSheet(
                context: event.context,
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
            onTap: () {
              event.context.pushNamed(AppRoutes.preferencesPage);
            }),
        ProfileListModel(
            image: AppImages.icNotificationSettings,
            title: APPStrings.notificationSettings.tr,
            subTitle: APPStrings.changeNotificationSettings.tr,
            trailingIcon: AppImages.icArrowRight,
            onTap: () {
              event.context.pushNamed(AppRoutes.notificationSettingsPage);
            }),
      ];
      profileAdminList = [
        ProfileListModel(
            image: AppImages.icMyOrders,
            title: APPStrings.orderManagement.tr,
            subTitle: APPStrings.listOfAllTheOrdersYouPlaced.tr,
            trailingIcon: AppImages.icArrowRight,
            onTap: () {
              event.context.pushNamed(AppRoutes.manufacturerOrderListingPage);
            }),
        ProfileListModel(
            image: AppImages.icProfileCalendar,
            title: APPStrings.calendar.tr,
            subTitle: APPStrings.meetingsTasksAllInOnePlace.tr,
            trailingIcon: AppImages.icArrowRight,
            onTap: () {}),
        ProfileListModel(
            image: AppImages.icMessages,
            title: APPStrings.messages.tr,
            subTitle: APPStrings.conversationsYouAreHaving.tr,
            trailingIcon: AppImages.icArrowRight,
            onTap: () {}),
        ProfileListModel(
            image: AppImages.icMasters,
            title: APPStrings.masters.tr,
            subTitle: APPStrings.masterDataOfUserAndNewsLetter.tr,
            trailingIcon: AppImages.icArrowRight,
            onTap: () {}),
        ProfileListModel(
            image: AppImages.icStore,
            title: APPStrings.dashboard.tr,
            subTitle: APPStrings.listOfDashboard.tr,
            trailingIcon: AppImages.icArrowRight,
            onTap: () {
              event.context.pushNamed(AppRoutes.dashboardPage);
            }),
      ];
    } else {
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
            onTap: () {
              event.context.pushNamed(AppRoutes.findStorePage);
            }),
        ProfileListModel(
            image: AppImages.icMapPin,
            title: APPStrings.savedAddress.tr,
            subTitle: APPStrings.listOfAllYourSavedAddresses.tr,
            trailingIcon: AppImages.icArrowRight,
            onTap: () {
              event.context.pushNamed(AppRoutes.savedAddressPage);
            }),
        ProfileListModel(
            image: AppImages.icLock,
            title: APPStrings.changePassword.tr,
            subTitle: APPStrings.changeYourExistingPassword.tr,
            trailingIcon: AppImages.icArrowRight,
            onTap: () {
              Utils.showSmartModalBottomSheet(
                context: event.context,
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
            onTap: () {
              event.context.pushNamed(AppRoutes.preferencesPage);
            }),
        ProfileListModel(
            image: AppImages.icNotificationSettings,
            title: APPStrings.notificationSettings.tr,
            subTitle: APPStrings.changeNotificationSettings.tr,
            trailingIcon: AppImages.icArrowRight,
            onTap: () {
              event.context.pushNamed(AppRoutes.notificationSettingsPage);
            }),
      ];
    }
    profileCMSList = [
      ProfileListModel(
          image: AppImages.icAboutUs,
          title: APPStrings.aboutUs.tr,
          onTap: () {
            event.context.pushNamed(AppRoutes.cmsWebViewPage, arguments: {
              RoutesData.cmsPageData: CmsWebViewDataModel(
                url: AppConst.profileAboutUsWebViewURL,
                title: APPStrings.aboutUs.tr,
              )
            });
          }),
      ProfileListModel(
          image: AppImages.icEducation,
          title: APPStrings.education.tr,
          isSubListExpanded: false,
          profileSubList: [
            ProfileListModel(
              title: APPStrings.diamonds.tr,
              onTap: () {
                event.context.pushNamed(AppRoutes.cmsWebViewPage, arguments: {
                  RoutesData.cmsPageData: CmsWebViewDataModel(
                    url: AppConst.profileDiamondWebViewURL,
                    title: APPStrings.diamonds.tr,
                  )
                });
              },
            ),
            ProfileListModel(
              title: APPStrings.labCreatedDiamonds.tr,
              onTap: () {
                event.context.pushNamed(AppRoutes.cmsWebViewPage, arguments: {
                  RoutesData.cmsPageData: CmsWebViewDataModel(
                    url: AppConst.profileDiamondWebViewURL,
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
                    url: AppConst.profileGemstoneWebViewURL,
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
                    url: AppConst.profileMetalsWebViewURL,
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
                    url: AppConst.profileRingSizerWebViewURL,
                    title: APPStrings.ringSizer.tr,
                  )
                });
              },
            ),
          ],
          onTap: () {
            event.context.pushNamed(AppRoutes.findStorePage);
          }),
      ProfileListModel(
          image: AppImages.icSupport,
          title: APPStrings.faqs.tr,
          isSubListExpanded: false,
          onTap: () {
            event.context.pushNamed(AppRoutes.faqPage);
          }),
      ProfileListModel(
          image: AppImages.icPolicies,
          title: APPStrings.policies.tr,
          onTap: () {
            event.context.pushNamed(AppRoutes.cmsWebViewPage, arguments: {
              RoutesData.cmsPageData: CmsWebViewDataModel(
                url: AppConst.profilePrivacyPolicyWebViewURL,
                title: APPStrings.policies.tr,
              )
            });
          }),
    ];
  }

  void _onToggleProfileListEvent(ToggleProfileListEvent event, Emitter<ProfileState> emit) {
    emit(ProfileReloadState());
    if (profileCMSList[event.index].profileSubList.isNotNullNorEmpty) {
      profileCMSList[event.index].isSubListExpanded = !profileCMSList[event.index].isSubListExpanded;
      emit(const ToggleProfileState());
    } else {
      profileCMSList[event.index].onTap?.call();
    }
  }
}
