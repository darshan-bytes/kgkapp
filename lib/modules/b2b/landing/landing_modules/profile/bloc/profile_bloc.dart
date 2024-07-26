import 'package:kgk/kgk.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserType userType = UserType.b2bUser;
  late AppBloc appBloc;
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
  GlobalKey<ScaffoldState> saveBtnKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();

  ProfileBloc() : super(ProfileInitialState()) {
    on<InitialProfileListEvent>(_onInitialProfileListEvent);
    on<ToggleProfileListEvent>(_onToggleProfileListEvent);
    on<LogoutEvent>(_onLogoutEvent);
    on<DeleteProfileEvent>(_onDeleteProfileEvent);
  }

  void _onInitialProfileListEvent(InitialProfileListEvent event, Emitter<ProfileState> emit) {
    appBloc = BlocProvider.of<AppBloc>(event.context);
    userType = appBloc.userType;
    profileActionList.clear();
    if (userType == UserType.b2bUser) {
      profileActionList = [
        ProfileListModel(
            image: AppImages.icMyOrders,
            title: APPStrings.myOrder,
            subTitle: APPStrings.listOfAllTheOrdersYouPlaced,
            trailingIcon: AppImages.icArrowRight,
            onTap: (context) {
              context.pushNamed(AppRoutes.myOrderTypeSelectionPage);
            }),
        ProfileListModel(
            image: AppImages.icActions,
            title: APPStrings.auctions,
            subTitle: APPStrings.listOfAuctionsYouAppliedTo,
            trailingIcon: AppImages.icArrowRight,
            onTap: (context) {
              context.pushNamed(AppRoutes.auctionListingPage);
            }),
        ProfileListModel(
            image: AppImages.icInquiries,
            title: APPStrings.myInquiries,
            subTitle: APPStrings.yourSubmittedInquiries,
            trailingIcon: AppImages.icArrowRight,
            onTap: (context) {}),
        ProfileListModel(
            image: AppImages.icWatchlist,
            title: APPStrings.watchlist,
            subTitle: APPStrings.listOfProductsAddedToWatchlist,
            trailingIcon: AppImages.icArrowRight,
            onTap: (context) {
              context.pushNamed(AppRoutes.watchListPage);
            }),
        ProfileListModel(
            image: AppImages.icExhibition,
            title: APPStrings.exhibition,
            subTitle: APPStrings.listOfExhibitionsOfKGK,
            trailingIcon: AppImages.icArrowRight,
            onTap: (context) {
              context.pushNamed(AppRoutes.exhibitionListingPage);
            }),
        ProfileListModel(
            image: AppImages.icActivityLog,
            title: APPStrings.activityLog,
            subTitle: APPStrings.getLogOnTheAccount,
            trailingIcon: AppImages.icArrowRight,
            onTap: (context) {
              context.pushNamed(AppRoutes.activityLogScreenPage);
            }),
        ProfileListModel(
            image: AppImages.icNewsFeed,
            title: APPStrings.newsFeed,
            subTitle: APPStrings.createAndSeeNewsFeeds,
            trailingIcon: AppImages.icArrowRight,
            onTap: (context) {
              context.pushNamed(AppRoutes.newsletterPage);
            }),
        ProfileListModel(
            image: AppImages.icStore,
            title: APPStrings.findAStore,
            subTitle: APPStrings.searchYourNearbyStores,
            trailingIcon: AppImages.icArrowRight,
            onTap: (context) {
              context.pushNamed(AppRoutes.findStorePage);
            }),
        ProfileListModel(
            image: AppImages.icMapPin,
            title: APPStrings.savedAddress,
            subTitle: APPStrings.listOfAllYourSavedAddresses,
            trailingIcon: AppImages.icArrowRight,
            onTap: (context) {
              context.pushNamed(AppRoutes.savedAddressPage);
            }),
        ProfileListModel(
            image: AppImages.icLock,
            title: APPStrings.changePassword,
            subTitle: APPStrings.changeYourExistingPassword,
            trailingIcon: AppImages.icArrowRight,
            onTap: (context) {
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
            title: APPStrings.preferences,
            subTitle: APPStrings.defaultCountryLanguageAndCurrency,
            trailingIcon: AppImages.icArrowRight,
            onTap: (context) {
              context.pushNamed(AppRoutes.preferencesPage);
            }),
        ProfileListModel(
            image: AppImages.icNotificationSettings,
            title: APPStrings.notificationSettings,
            subTitle: APPStrings.changeNotificationSettings,
            trailingIcon: AppImages.icArrowRight,
            onTap: (context) {
              context.pushNamed(AppRoutes.notificationSettingsPage);
            }),
      ];
      profileAdminList = [
        ProfileListModel(
            image: AppImages.icMyOrders,
            title: APPStrings.orderManagement,
            subTitle: APPStrings.listOfAllTheOrdersYouPlaced,
            trailingIcon: AppImages.icArrowRight,
            onTap: (context) {
              context.pushNamed(AppRoutes.manufacturerOrderListingPage);
            }),
        ProfileListModel(
          image: AppImages.icProfileCalendar,
          title: APPStrings.calendar,
          subTitle: APPStrings.meetingsTasksAllInOnePlace,
          trailingIcon: AppImages.icArrowRight,
          onTap: (context) {
            context.pushNamed(AppRoutes.calendarPage);
          },
        ),
        ProfileListModel(
            image: AppImages.icMessages,
            title: APPStrings.messages,
            subTitle: APPStrings.conversationsYouAreHaving,
            trailingIcon: AppImages.icArrowRight,
            onTap: (context) {
              context.pushNamed(AppRoutes.messagesPage);
            }),
        ProfileListModel(
            image: AppImages.icMasters,
            title: APPStrings.masters,
            subTitle: APPStrings.masterDataOfUserAndNewsLetter,
            trailingIcon: AppImages.icArrowRight,
            onTap: (context) {
              context.pushNamed(AppRoutes.userMasterListingPage);
            }),
        ProfileListModel(
            image: AppImages.icStore,
            title: APPStrings.dashboard,
            subTitle: APPStrings.listOfDashboard,
            trailingIcon: AppImages.icArrowRight,
            onTap: (context) {
              context.pushNamed(AppRoutes.dashboardPage);
            }),
      ];
    } else {
      profileActionList = [
        ProfileListModel(
            image: AppImages.icMyOrders,
            title: APPStrings.myOrder,
            subTitle: APPStrings.listOfAllTheOrdersYouPlaced,
            trailingIcon: AppImages.icArrowRight,
            onTap: (context) {
              context.pushNamed(AppRoutes.orderPage);
            }),
        ProfileListModel(
            image: AppImages.icActions,
            title: APPStrings.auctions,
            subTitle: APPStrings.listOfAuctionsYouAppliedTo,
            trailingIcon: AppImages.icArrowRight,
            onTap: (context) {
              context.pushNamed(AppRoutes.auctionListingPage);
            }),
        ProfileListModel(
            image: AppImages.icInquiries,
            title: APPStrings.myInquiries,
            subTitle: APPStrings.yourSubmittedInquiries,
            trailingIcon: AppImages.icArrowRight,
            onTap: (context) {}),
        ProfileListModel(
            image: AppImages.icNewsFeed,
            title: APPStrings.newsFeed,
            subTitle: APPStrings.createAndSeeNewsFeeds,
            trailingIcon: AppImages.icArrowRight,
            onTap: (context) {
              context.pushNamed(AppRoutes.newsletterPage);
            }),
        ProfileListModel(
            image: AppImages.icStore,
            title: APPStrings.findAStore,
            subTitle: APPStrings.searchYourNearbyStores,
            trailingIcon: AppImages.icArrowRight,
            onTap: (context) {
              context.pushNamed(AppRoutes.findStorePage);
            }),
        ProfileListModel(
            image: AppImages.icMapPin,
            title: APPStrings.savedAddress,
            subTitle: APPStrings.listOfAllYourSavedAddresses,
            trailingIcon: AppImages.icArrowRight,
            onTap: (context) {
              context.pushNamed(AppRoutes.savedAddressPage);
            }),
        ProfileListModel(
            image: AppImages.icLock,
            title: APPStrings.changePassword,
            subTitle: APPStrings.changeYourExistingPassword,
            trailingIcon: AppImages.icArrowRight,
            onTap: (context) {
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
            title: APPStrings.preferences,
            subTitle: APPStrings.defaultCountryLanguageAndCurrency,
            trailingIcon: AppImages.icArrowRight,
            onTap: (context) {
              context.pushNamed(AppRoutes.preferencesPage);
            }),
        ProfileListModel(
            image: AppImages.icNotificationSettings,
            title: APPStrings.notificationSettings,
            subTitle: APPStrings.changeNotificationSettings,
            trailingIcon: AppImages.icArrowRight,
            onTap: (context) {
              context.pushNamed(AppRoutes.notificationSettingsPage);
            }),
      ];
    }
    profileCMSList = [
      ProfileListModel(
          image: AppImages.icAboutUs,
          title: APPStrings.aboutUs,
          onTap: (context) {
            context.pushNamed(AppRoutes.cmsWebViewPage, arguments: {
              RoutesData.cmsPageData: CmsWebViewDataModel(
                url: AppConst.profileAboutUsWebViewURL,
                title: APPStrings.aboutUs,
              )
            });
          }),
      ProfileListModel(
          image: AppImages.icEducation,
          title: APPStrings.education,
          isSubListExpanded: false,
          profileSubList: [
            ProfileListModel(
              title: APPStrings.diamonds,
              onTap: (context) {
                context.pushNamed(AppRoutes.cmsWebViewPage, arguments: {
                  RoutesData.cmsPageData: CmsWebViewDataModel(
                    url: AppConst.profileDiamondWebViewURL,
                    title: APPStrings.diamonds,
                  )
                });
              },
            ),
            ProfileListModel(
              title: APPStrings.labCreatedDiamonds,
              onTap: (context) {
                context.pushNamed(AppRoutes.cmsWebViewPage, arguments: {
                  RoutesData.cmsPageData: CmsWebViewDataModel(
                    url: AppConst.profileDiamondWebViewURL,
                    title: APPStrings.labCreatedDiamonds,
                  )
                });
              },
            ),
            ProfileListModel(
              title: APPStrings.gemstone,
              onTap: (context) {
                context.pushNamed(AppRoutes.cmsWebViewPage, arguments: {
                  RoutesData.cmsPageData: CmsWebViewDataModel(
                    url: AppConst.profileGemstoneWebViewURL,
                    title: APPStrings.gemstone,
                  )
                });
              },
            ),
            ProfileListModel(
              title: APPStrings.metals,
              onTap: (context) {
                context.pushNamed(AppRoutes.cmsWebViewPage, arguments: {
                  RoutesData.cmsPageData: CmsWebViewDataModel(
                    url: AppConst.profileMetalsWebViewURL,
                    title: APPStrings.metals,
                  )
                });
              },
            ),
            ProfileListModel(
              title: APPStrings.ringSizer,
              onTap: (context) {
                context.pushNamed(AppRoutes.cmsWebViewPage, arguments: {
                  RoutesData.cmsPageData: CmsWebViewDataModel(
                    url: AppConst.profileRingSizerWebViewURL,
                    title: APPStrings.ringSizer,
                  )
                });
              },
            ),
          ],
          onTap: (context) {
            context.pushNamed(AppRoutes.findStorePage);
          }),
      ProfileListModel(
          image: AppImages.icSupport,
          title: APPStrings.faqs,
          isSubListExpanded: false,
          onTap: (context) {
            context.pushNamed(AppRoutes.faqPage);
          }),
      ProfileListModel(
          image: AppImages.icPolicies,
          title: APPStrings.policies,
          onTap: (context) {
            context.pushNamed(AppRoutes.cmsWebViewPage, arguments: {
              RoutesData.cmsPageData: CmsWebViewDataModel(
                url: AppConst.profilePrivacyPolicyWebViewURL,
                title: APPStrings.policies,
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
      profileCMSList[event.index].onTap?.call(event.context);
    }
  }

  /// Logout event to clear session and navigate to login page
  void _onLogoutEvent(LogoutEvent event, Emitter<ProfileState> emit) async {
    BlocProvider.of<LandingBloc>(event.context).add(const LandingLogoutEvent());
    BlocProvider.of<LandingBloc>(event.context).add(LandingChangeTabEvent(LandingBloc.homeIndex, context: event.context));
    await StorageManager().clearSession();
    event.context.pushNamedAndRemoveUntil(AppRoutes.signInPage, (route) => false);
  }

  /// Delete profile event to clear session and navigate to login page
  void _onDeleteProfileEvent(DeleteProfileEvent event, Emitter<ProfileState> emit) async {
    BlocProvider.of<LandingBloc>(event.context).add(const LandingLogoutEvent());
    BlocProvider.of<LandingBloc>(event.context).add(LandingChangeTabEvent(LandingBloc.homeIndex, context: event.context));
    await StorageManager().clearSession();
    event.context.pushNamedAndRemoveUntil(AppRoutes.signInPage, (route) => false);
  }
}
