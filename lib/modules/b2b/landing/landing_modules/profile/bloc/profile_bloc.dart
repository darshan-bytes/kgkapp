import 'package:kgk/kgk.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserType userType = UserType.b2bUser;
  late AppBloc appBloc;
  UserIdDetails? userIdDetails;

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

  List<Country> selectedCountryCodes = [
    Country.from(json: {
      "e164_cc": "91",
      "iso2_cc": "IN",
      "e164_sc": 0,
      "geographic": true,
      "level": 1,
      "name": "India",
      "example": "9123456789",
      "display_name": "India (IN) [+91]",
      "full_example_with_plus_sign": "+919123456789",
      "display_name_no_e164_cc": "India (IN)",
      "e164_key": "91-IN-0",
    })
  ];
  late Country selectedCountry;

  ProfileBloc() : super(ProfileInitialState()) {
    selectedCountry = Country.from(json: selectedCountryCodes.first.toJson());
    on<InitialProfileListEvent>(_onInitialProfileListEvent);
    on<ToggleProfileListEvent>(_onToggleProfileListEvent);
    on<LogoutEvent>(_onLogoutEvent);
    on<DeleteProfileEvent>(_onDeleteProfileEvent);
    on<EditProfileChangeCountryCodeEvent>(_onEditProfileChangeCountryCodeEvent);
    on<EditProfileSaveEvent>(_onEditProfileSaveEvent);
    on<EditProfilePhoneNumberValidationEvent>(_onEditProfilePhoneNumberValidationEvent);
    on<ChangePasswordEvent>(_onChangePasswordEvent);
  }

  void _onInitialProfileListEvent(InitialProfileListEvent event, Emitter<ProfileState> emit) {
    _fetchUserDetails();
    appBloc = BlocProvider.of<AppBloc>(event.context);
    userType = appBloc.userType;
    profileActionList.clear();
    if (userType == UserType.internal) {
      profileAdminList = [
        ProfileListModel(
            image: AppImages.icMyOrders,
            title: APPStrings.orderManagement,
            subTitle: APPStrings.listOfAllTheOrdersYouPlaced,
            trailingIcon: AppImages.icArrowRight,
            onTap: (context) {
              context.pushNamed(AppRoutes.orderPage);
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
    }
    if (userType == UserType.b2bUser) {
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
            onTap: (context) {
              context.pushNamed(AppRoutes.makeInquiryPage);
            }),
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
            onTap: (context) {
              context.pushNamed(AppRoutes.makeInquiryPage);
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
            image: AppImages.icWatchlist,
            title: APPStrings.watchlist,
            subTitle: APPStrings.listOfProductsAddedToWatchlist,
            trailingIcon: AppImages.icArrowRight,
            onTap: (context) {
              context.pushNamed(AppRoutes.watchListPage);
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
              _clearChangePasswordData();

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
                attribute: Attributes.aboutUsPage, // For future use
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
    Either<ErrorResponse, CommonResponse>? response = await UserRepository(event.context).logoutUser({});
    await response?.fold((l) async {
      BlocProvider.of<LandingBloc>(event.context).add(const LandingLogoutEvent());
      BlocProvider.of<LandingBloc>(event.context).add(LandingChangeTabEvent(LandingBloc.homeIndex, context: event.context));
      await StorageManager().clearSession();
      event.context.pushNamedAndRemoveUntil(AppRoutes.signInPage, (route) => false);
    }, (r) async {
      BlocProvider.of<LandingBloc>(event.context).add(const LandingLogoutEvent());
      BlocProvider.of<LandingBloc>(event.context).add(LandingChangeTabEvent(LandingBloc.homeIndex, context: event.context));
      await StorageManager().clearSession();
      event.context.pushNamedAndRemoveUntil(AppRoutes.signInPage, (route) => false);
    });
  }

  /// Delete profile event to clear session and navigate to login page
  void _onDeleteProfileEvent(DeleteProfileEvent event, Emitter<ProfileState> emit) async {
    Either<ErrorResponse, CommonResponse>? response = await UserRepository(event.context).deleteAccount();
    await response?.fold((l) {
      ErrorResponse errorModel = l;
      Utils.showMessage(errorModel.message);
    }, (r) async {
      BlocProvider.of<LandingBloc>(event.context).add(const LandingLogoutEvent());
      BlocProvider.of<LandingBloc>(event.context).add(LandingChangeTabEvent(LandingBloc.homeIndex, context: event.context));
      await StorageManager().clearSession();
      event.context.pushNamedAndRemoveUntil(AppRoutes.signInPage, (route) => false);
    });
  }

  void _fetchUserDetails() {
    UserIdDetails? userDetails = StorageManager().getUserData();
    if (userDetails != null) {
      userIdDetails = userDetails;
      firstNameController.text = userIdDetails?.firstname ?? '';
      lastNameController.text = userIdDetails?.lastname ?? '';
      emailController.text = userIdDetails?.email ?? '';
      contactNumberController.text = userIdDetails?.phone ?? '';
    }
  }

  void _onEditProfileChangeCountryCodeEvent(EditProfileChangeCountryCodeEvent event, Emitter<ProfileState> emit) {
    emit(ProfileReloadState());
    selectedCountry = event.country;
    emit(EditProfileChangeCountryCodeState(country: selectedCountry));
  }

  Future<void> _onEditProfilePhoneNumberValidationEvent(EditProfilePhoneNumberValidationEvent event, Emitter<ProfileState> emit) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (!emit.isDone) {
      if (event.phoneNumber.isNotEmpty && event.phoneNumber.length >= 10) {
        Either<ErrorResponse, CommonResponse>? phoneNumberValidationResponse =
            await UserRepository(event.context).validatePhoneNumber(code: selectedCountry.phoneCode, phoneNumber: event.phoneNumber);

        if (!emit.isDone) {
          phoneNumberValidationResponse?.fold((l) {
            Utils.showMessage(l.message);
          }, (r) {
            bool isPhoneNumberUsed = r.responseData;
            emit(EditProfilePhoneNumberValidationState(
                phoneNumberValidationFieldType: ValidationFieldType.phoneNumber, isError: isPhoneNumberUsed));
          });
        }
      }
    }
  }

  bool _validateEditProfile() {
    if (firstNameController.text.trim().isEmpty) {
      Utils.showMessage(APPStrings.errorFirstNameRequired.tr);
      return false;
    } else if (lastNameController.text.trim().isEmpty) {
      Utils.showMessage(APPStrings.errorLastNameRequired.tr);
      return false;
    } else if (emailController.text.trim().isEmpty) {
      Utils.showMessage(APPStrings.emailRequired.tr);
      return false;
    } else if (!Utils.isValidEmail(emailController.text)) {
      Utils.showMessage(APPStrings.validEmail.tr);
      return false;
    } else if (contactNumberController.text.trim().isEmpty) {
      Utils.showMessage(APPStrings.errorContactNumberRequired.tr);
      return false;
    }

    return true;
  }

  Future<void> _onEditProfileSaveEvent(EditProfileSaveEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileReloadState());
    if (_validateEditProfile()) {
      await _callEditUserProfileApi(event: event);
    }
  }

  Future<void> _callEditUserProfileApi({required EditProfileSaveEvent event}) async {
    final Map<String, dynamic> params = {
      ApiKey.firstname: firstNameController.text.trim(),
      ApiKey.lastname: lastNameController.text.trim(),
      ApiKey.phoneCode: selectedCountry.phoneCode,
      ApiKey.phone: contactNumberController.text.trim(),
    };
    Either<ErrorResponse, CommonResponse>? editProfileResponse = await UserRepository(event.context).editUserProfile(params);
    await editProfileResponse?.fold(
      (l) => Utils.showMessage(l.message),
      (r) async {
        UserIdDetails userData = r.responseData;
        await StorageManager().setUserData(userData);
        userIdDetails = userData;
        event.context.pop();
        Utils.showMessage(r.message);
      },
    );
  }

  bool _validateChangePassword() {
    if (currentPasswordController.text.trim().isEmpty) {
      Utils.showMessage(APPStrings.errorCurrentPasswordRequired.tr);
      return false;
    } else if (newPasswordController.text.trim().isEmpty) {
      Utils.showMessage(APPStrings.errorNewPasswordRequired.tr);
      return false;
    } else if (confirmPasswordController.text.trim().isEmpty) {
      Utils.showMessage(APPStrings.errorConfirmPasswordRequired.tr);
      return false;
    } else if (newPasswordController.text.trim() != confirmPasswordController.text.trim()) {
      Utils.showMessage(APPStrings.passwordsDoNotMatch.tr);
      return false;
    } else if (!Utils.isValidPassword(newPasswordController.text.trim())) {
      Utils.showMessage(APPStrings.validPassword.tr);
      return false;
    }

    return true;
  }

  void _onChangePasswordEvent(ChangePasswordEvent event, Emitter<ProfileState> emit) {
    emit(ProfileReloadState());
    if (_validateChangePassword()) {
      _callChangePasswordApi(event: event);
    }
  }

  Future<void> _callChangePasswordApi({required ChangePasswordEvent event}) async {
    final Map<String, dynamic> params = {
      ApiKey.oldPassword: currentPasswordController.text.trim(),
      ApiKey.newPassword: newPasswordController.text.trim(),
      ApiKey.isAdminChange: false
    };
    event.context.setAppLoading(true);

    Either<ErrorResponse, CommonResponse>? response = await UserRepository(event.context).changePasswordApi(params);
    response?.fold(
      (error) {
        event.context.setAppLoading(false);
        Utils.showMessage(error.message);
      },
      (success) async {
        await Utils.showMessage(success.message);
        _clearChangePasswordData();
        event.context.setAppLoading(false);
        add(LogoutEvent(context: event.context));
      },
    );
  }

  _clearChangePasswordData() {
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }
}
