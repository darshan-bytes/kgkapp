import 'package:kgk/kgk.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  /// The type of user, defaults to B2C user.
  UserType userType = UserType.b2bUser;

  /// This object holds the details of the currently logged-in user.
  UserIdDetails? userIdDetails;

  /// This controller handles the functionality for editing the profile and changing the password.
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  /// This focus node is used to track the focus state of the text fields.
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode contactNumberFocusNode = FocusNode();
  FocusNode currentPasswordFocusNode = FocusNode();
  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  String? firstNameError;
  String? lastNameError;
  String? contactNumberError;

  String? currentPasswordError;
  String? passwordError;
  String? confirmPasswordError;

  /// This list holds the details of the actions that can be performed on the profile.
  List<ProfileListModel> profileActionList = [];

  /// This list holds the details of the CMS actions that can be performed on the profile.
  List<ProfileListModel> profileCMSList = [];

  /// This list holds the details of the admin actions that can be performed on the profile.
  List<ProfileListModel> profileAdminList = [];

  /// This variable is used to check if the user is logged in or not.
  bool get isSkipUser => StorageManager().getIsSkipLogin();

  bool isExpandedList = false;
  GlobalKey<ScaffoldState> saveBtnKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();

  /// This object is used to pick the image from the gallery or camera.
  final ImagePicker _picker = ImagePicker();

  /// profile image
  List<XFile> profilePickedImageList = [];

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
    on<EditProfileFieldChangeEvent>(_onEditProfileFieldChangeEvent);
    on<ProfilePickImageEvent>(_onProfilePickImage);
    on<RemoveProfileImageEvent>(_onRemoveProfileImage);
    on<ChangePasswordFieldChangeEvent>(_onChangePasswordFieldChangeEvent);
  }

  Future<void> _onInitialProfileListEvent(InitialProfileListEvent event, Emitter<ProfileState> emit) async {
    await _initializeBloc(event.context, emit);
  }

  Future<void> _onToggleProfileListEvent(ToggleProfileListEvent event, Emitter<ProfileState> emit) async {
    _handleToggleProfileList(context: event.context, index: event.index, emit: emit);
  }

  Future<void> _onEditProfileChangeCountryCodeEvent(EditProfileChangeCountryCodeEvent event, Emitter<ProfileState> emit) async {
    _handleEditProfileChangeCountryCode(emit: emit, country: event.country);
  }

  Future<void> _onEditProfilePhoneNumberValidationEvent(EditProfilePhoneNumberValidationEvent event, Emitter<ProfileState> emit) async {
    await _handleEditProfilePhoneNumberValidation(context: event.context, phoneNumber: event.phoneNumber, emit: emit);
  }

  Future<void> _onEditProfileSaveEvent(EditProfileSaveEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileReloadState());
    if (_validateEditProfile(emit)) {
      await _callEditUserProfileApi(event: event);
    }
  }

  Future<void> _onChangePasswordEvent(ChangePasswordEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileReloadState());
    if (_validateChangePassword(emit)) {
      await _callChangePasswordApi(event: event);
    }
  }

  Future<void> _onProfilePickImage(ProfilePickImageEvent event, Emitter<ProfileState> emit) async {
    await _handleProfilePickImage(emit: emit, imageSource: event.imageSource);
  }

  void _onRemoveProfileImage(RemoveProfileImageEvent event, Emitter<ProfileState> emit) {
    _handleRemoveProfileImage(emit: emit);
  }

  void _onEditProfileFieldChangeEvent(EditProfileFieldChangeEvent event, Emitter<ProfileState> emit) {
    emit(ProfileReloadState());
    switch (event.fieldType) {
      case FieldTypeValidationEnum.firstName:
        firstNameError = null;
        break;
      case FieldTypeValidationEnum.lastName:
        lastNameError = null;
        break;
      case FieldTypeValidationEnum.contactNumber:
        contactNumberError = null;
        break;
      default:
        break;
    }
    emit(EditProfileFieldErrorState(fieldType: event.fieldType));
  }

  void _onChangePasswordFieldChangeEvent(ChangePasswordFieldChangeEvent event, Emitter<ProfileState> emit) {
    emit(ProfileReloadState());
    switch (event.fieldType) {
      case FieldTypeValidationEnum.currentPassword:
        currentPasswordError = null;
        break;
      case FieldTypeValidationEnum.password:
        passwordError = null;
        break;
      case FieldTypeValidationEnum.confirmPassword:
        confirmPasswordError = null;
        break;
      default:
        break;
    }
    emit(ChangePasswordFieldErrorState(fieldType: event.fieldType));
  }

  Future<void> _onLogoutEvent(LogoutEvent event, Emitter<ProfileState> emit) async {
    await _handleLogout(context: event.context, emit: emit);
  }

  Future<void> _onDeleteProfileEvent(DeleteProfileEvent event, Emitter<ProfileState> emit) async {
    await _handleDeleteProfile(context: event.context, emit: emit);
  }

  Future<void> _initializeBloc(BuildContext context, Emitter<ProfileState> emit) async {
    /// Set the user type
    userType = BlocProvider.of<AppBloc>(context).userType;

    /// Clear and initialize profile actions list
    profileActionList.clear();

    /// Fetch the user details from storage and set in text fields
    await _fetchUserDetailsAPI(context, emit);

    /// Set profile actions based on user type
    if (userType == UserType.internal) {
      profileActionList = _getInternalUserProfileActions(context);
    } else if (userType == UserType.b2bUser) {
      profileActionList = _getB2BUserProfileActions(context);
    } else if (isSkipUser) {
      profileActionList = _getSkipUserProfileActions();
    } else {
      profileActionList = _getDefaultProfileActions(context);
    }

    /// Add CMS related profile actions
    profileCMSList = _getCMSProfileActions();
  }

  /// Get user details from storage
  void _getUserDetailsFromStorage() {
    UserIdDetails? userDetails = StorageManager().getUserData();
    if (userDetails != null) {
      userIdDetails = userDetails;
      firstNameController.text = userIdDetails?.firstname ?? '';
      lastNameController.text = userIdDetails?.lastname ?? '';
      emailController.text = userIdDetails?.email ?? '';
      contactNumberController.text = userIdDetails?.phone ?? '';
      if (userIdDetails?.profilePic != null) {
        profilePickedImageList.clear();
        profilePickedImageList.add(XFile(userIdDetails?.profilePicUrl?.setMediaUrl ?? ''));
      }
      firstNameError = null;
      lastNameError = null;
      contactNumberError = null;
    }
  }

  Future<void> _fetchUserDetailsAPI(BuildContext context, Emitter<ProfileState> emit) async {
    emit(ProfileReloadState());
    Either<ErrorResponse, CommonResponse>? getProfileResponse = await UserRepository(context).getUserProfile();
    await getProfileResponse?.fold(
      (l) => Utils.showMessage(l.message),
      (r) async {
        UserIdDetails userData = r.responseData;
        userIdDetails = userData;
        await StorageManager().setUserData(userData);
        firstNameController.text = userIdDetails?.firstname ?? '';
        lastNameController.text = userIdDetails?.lastname ?? '';
        emailController.text = userIdDetails?.email ?? '';
        contactNumberController.text = userIdDetails?.phone ?? '';
        profilePickedImageList.clear();
        if (userIdDetails?.profilePic != null) {
          profilePickedImageList.add(XFile(userIdDetails?.profilePicUrl?.setMediaUrl ?? ''));
        }
        BlocProvider.of<LandingBloc>(context)
            .add(LandingProfilePictureUpdateEvent(profilePicture: userIdDetails?.profilePicUrl?.setMediaUrl));
        firstNameError = null;
        lastNameError = null;
        contactNumberError = null;
      },
    );
    emit(ProfileLoadedState());
  }

  /// Handles toggle profile list
  void _handleToggleProfileList({required BuildContext context, required int index, required Emitter<ProfileState> emit}) {
    emit(ProfileReloadState());
    if (profileCMSList[index].profileSubList.isNotNullNorEmpty) {
      profileCMSList[index].isSubListExpanded = !profileCMSList[index].isSubListExpanded;
      emit(const ToggleProfileState());
    } else {
      profileCMSList[index].onTap?.call(context);
    }
  }

  void _handleEditProfileChangeCountryCode({required Country country, required Emitter<ProfileState> emit}) {
    emit(ProfileReloadState());
    selectedCountry = country;
    emit(EditProfileChangeCountryCodeState(country: selectedCountry));
  }

  Future<void> _handleEditProfilePhoneNumberValidation(
      {required String phoneNumber, required BuildContext context, required Emitter<ProfileState> emit}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (!emit.isDone) {
      if (phoneNumber.isNotEmpty && phoneNumber.length >= 10) {
        Either<ErrorResponse, CommonResponse>? phoneNumberValidationResponse =
            await UserRepository(context).validatePhoneNumber(code: selectedCountry.phoneCode, phoneNumber: phoneNumber);

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

  bool _validateEditProfile(Emitter<ProfileState> emit) {
    if (firstNameController.text.trim().isEmpty) {
      firstNameError = APPStrings.errorFirstNameRequired.tr;
      emit(EditProfileFieldErrorState(fieldType: FieldTypeValidationEnum.firstName));
    }
    if (lastNameController.text.trim().isEmpty) {
      lastNameError = APPStrings.errorLastNameRequired.tr;
      emit(EditProfileFieldErrorState(fieldType: FieldTypeValidationEnum.lastName));
    }

    if (contactNumberController.text.trim().isEmpty) {
      contactNumberError = APPStrings.errorContactNumberRequired.tr;
      emit(EditProfileFieldErrorState(fieldType: FieldTypeValidationEnum.contactNumber));
    } else if (!CountryUtils.validatePhoneNumber(contactNumberController.text.trim(), "+${selectedCountry.phoneCode}")) {
      contactNumberError = APPStrings.errorContactNumberValid.tr;
      emit(EditProfileFieldErrorState(fieldType: FieldTypeValidationEnum.contactNumber));
    }

    return firstNameError.isNullOrEmpty && lastNameError.isNullOrEmpty && contactNumberError.isNullOrEmpty;
  }

  Future<void> _callEditUserProfileApi({required EditProfileSaveEvent event}) async {
    final Map<String, dynamic> params = {
      ApiKey.firstname: firstNameController.text.trim(),
      ApiKey.lastname: lastNameController.text.trim(),
      ApiKey.phoneCode: selectedCountry.phoneCode,
      ApiKey.phone: contactNumberController.text.trim(),
      if (userIdDetails?.profilePic != null) ApiKey.profilePic: userIdDetails?.profilePic,
    };
    Either<ErrorResponse, CommonResponse>? editProfileResponse = await UserRepository(event.context).editUserProfile(params,
        images: profilePickedImageList.isNotEmpty
            ? profilePickedImageList.where((e) => e.path.isNotNullNorEmpty).map((e) => e.path).toList()
            : []);
    await editProfileResponse?.fold(
      (l) => Utils.showMessage(l.message),
      (r) async {
        UserIdDetails userData = r.responseData;
        await StorageManager().setUserData(userData);
        userIdDetails = userData;
        event.context.pop();
        Utils.showMessage(r.message);
        BlocProvider.of<LandingBloc>(getNavigatorKeyContext)
            .add(LandingProfilePictureUpdateEvent(profilePicture: userData.profilePicUrl?.setMediaUrl, isForce: true));
      },
    );
  }

  bool _validateChangePassword(Emitter<ProfileState> emit) {
    bool isValidate = true;
    if (currentPasswordController.text.trim().isEmpty) {
      currentPasswordError = APPStrings.errorCurrentPasswordRequired.tr;
      emit(ChangePasswordFieldErrorState(fieldType: FieldTypeValidationEnum.currentPassword));
      isValidate = false;
    }
    if (newPasswordController.text.trim().isEmpty) {
      passwordError = APPStrings.errorPasswordRequired.tr;
      emit(ChangePasswordFieldErrorState(fieldType: FieldTypeValidationEnum.password));
      isValidate = false;
    } else if (!Utils.isValidPassword(newPasswordController.text.trim())) {
      passwordError = APPStrings.validPassword.tr;
      emit(ChangePasswordFieldErrorState(fieldType: FieldTypeValidationEnum.password));
      isValidate = false;
    }
    if (confirmPasswordController.text.trim().isEmpty) {
      confirmPasswordError = APPStrings.errorConfirmPasswordRequired.tr;
      emit(ChangePasswordFieldErrorState(fieldType: FieldTypeValidationEnum.confirmPassword));
      isValidate = false;
    } else if (newPasswordController.text != confirmPasswordController.text) {
      confirmPasswordError = APPStrings.errorPasswordNotMatch.tr;
      emit(ChangePasswordFieldErrorState(fieldType: FieldTypeValidationEnum.confirmPassword));
      isValidate = false;
    }
    return isValidate;
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

  void _clearChangePasswordData() {
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  /// Helper function to get profile actions for internal users
  List<ProfileListModel> _getInternalUserProfileActions(BuildContext context) {
    return [
      ProfileListModel(
        image: AppImages.icMyOrders,
        title: APPStrings.orderManagement,
        subTitle: APPStrings.listOfAllTheOrdersYouPlaced,
        trailingIcon: AppImages.icArrowRight,
        onTap: (context) {
          context.pushNamed(AppRoutes.orderPage);
        },
      ),
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
        },
      ),
      ProfileListModel(
        image: AppImages.icMasters,
        title: APPStrings.masters,
        subTitle: APPStrings.masterDataOfUserAndNewsLetter,
        trailingIcon: AppImages.icArrowRight,
        onTap: (context) {
          context.pushNamed(AppRoutes.userMasterListingPage);
        },
      ),
      ProfileListModel(
        image: AppImages.icStore,
        title: APPStrings.dashboard,
        subTitle: APPStrings.listOfDashboard,
        trailingIcon: AppImages.icArrowRight,
        onTap: (context) {
          context.pushNamed(AppRoutes.dashboardPage);
        },
      ),
    ];
  }

  /// Helper function to get profile actions for B2B users
  List<ProfileListModel> _getB2BUserProfileActions(BuildContext context) {
    return [
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
              context: context,
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

  /// Helper function to get default profile actions
  List<ProfileListModel> _getDefaultProfileActions(BuildContext context) {
    return [
      ProfileListModel(
          image: AppImages.icMyOrders,
          title: APPStrings.myOrder,
          trailingIcon: AppImages.icArrowRight,
          onTap: (context) {
            context.pushNamed(AppRoutes.orderPage);
          }),
      ProfileListModel(
          image: AppImages.icActions,
          title: APPStrings.auctions,
          trailingIcon: AppImages.icArrowRight,
          onTap: (context) {
            context.pushNamed(AppRoutes.auctionListingPage);
          }),
      ProfileListModel(
          image: AppImages.icInquiries,
          title: APPStrings.myInquiries,
          trailingIcon: AppImages.icArrowRight,
          onTap: (context) {
            context.pushNamed(AppRoutes.makeInquiryPage);
          }),
      ProfileListModel(
          image: AppImages.icWatchlist,
          title: APPStrings.watchlist,
          trailingIcon: AppImages.icArrowRight,
          onTap: (context) {
            context.pushNamed(AppRoutes.watchListPage);
          }),
      ProfileListModel(
          image: AppImages.icNewsFeed,
          title: APPStrings.newsFeed,
          trailingIcon: AppImages.icArrowRight,
          onTap: (context) {
            context.pushNamed(AppRoutes.newsletterPage);
          }),
      ProfileListModel(
          image: AppImages.icStore,
          title: APPStrings.findAStore,
          trailingIcon: AppImages.icArrowRight,
          onTap: (context) {
            context.pushNamed(AppRoutes.findStorePage);
          }),
      ProfileListModel(
          image: AppImages.icMapPin,
          title: APPStrings.savedAddress,
          trailingIcon: AppImages.icArrowRight,
          onTap: (context) {
            context.pushNamed(AppRoutes.savedAddressPage);
          }),
      ProfileListModel(
          image: AppImages.icLock,
          title: APPStrings.changePassword,
          trailingIcon: AppImages.icArrowRight,
          onTap: (context) {
            _clearChangePasswordData();

            Utils.showSmartModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12.r), topRight: Radius.circular(12.r)),
              ),
              builder: (context) => const ChangePasswordBottomSheet(),
            );
          }),
      ProfileListModel(
          image: AppImages.icPreferences,
          title: APPStrings.preferences,
          trailingIcon: AppImages.icArrowRight,
          onTap: (context) {
            context.pushNamed(AppRoutes.preferencesPage);
          }),
      ProfileListModel(
          image: AppImages.icNotificationSettings,
          title: APPStrings.notificationSettings,
          trailingIcon: AppImages.icArrowRight,
          onTap: (context) {
            context.pushNamed(AppRoutes.notificationSettingsPage);
          }),
    ];
  }

  /// Helper function to get CMS related profile actions
  List<ProfileListModel> _getCMSProfileActions() {
    return [
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
        },
      ),
      ProfileListModel(
          image: AppImages.icEducation,
          title: APPStrings.education,
          isSubListExpanded: false,
          profileSubList: [
            ProfileListModel(
              title: APPStrings.diamonds,
              onTap: (context) {
                context.pushNamed(
                  AppRoutes.cmsWebViewPage,
                  arguments: {
                    RoutesData.cmsPageData: CmsWebViewDataModel(
                      url: AppConst.profileDiamondWebViewURL,
                      title: APPStrings.diamonds,
                    )
                  },
                );
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
        },
      ),
    ];
  }

  /// Helper function to get skip user profile actions
  List<ProfileListModel> _getSkipUserProfileActions() {
    return [
      ProfileListModel(
        image: AppImages.icNewsFeed,
        title: APPStrings.newsFeed,
        subTitle: APPStrings.createAndSeeNewsFeeds,
        trailingIcon: AppImages.icArrowRight,
        onTap: (context) {
          context.pushNamed(AppRoutes.newsletterPage);
        },
      ),
      ProfileListModel(
        image: AppImages.icPreferences,
        title: APPStrings.preferences,
        subTitle: APPStrings.defaultCountryLanguageAndCurrency,
        trailingIcon: AppImages.icArrowRight,
        onTap: (context) {
          context.pushNamed(AppRoutes.preferencesPage);
        },
      ),
    ];
  }

  /// Logout event to clear session and navigate to login page
  Future<void> _handleLogout({required BuildContext context, required Emitter<ProfileState> emit}) async {
    Either<ErrorResponse, CommonResponse>? response = await UserRepository(context).logoutUser({});
    clearData();
    await response?.fold((l) async {
      BlocProvider.of<LandingBloc>(context).add(const LandingLogoutEvent());
      BlocProvider.of<LandingBloc>(context).add(LandingChangeTabEvent(LandingBloc.homeIndex, context: context));
      await StorageManager().clearSession();
      context.pushNamedAndRemoveUntil(AppRoutes.signInPage, (route) => false);
    }, (r) async {
      BlocProvider.of<LandingBloc>(context).add(const LandingLogoutEvent());
      BlocProvider.of<LandingBloc>(context).add(LandingChangeTabEvent(LandingBloc.homeIndex, context: context));
      await StorageManager().clearSession();

      context.pushNamedAndRemoveUntil(AppRoutes.signInPage, (route) => false);
    });
  }

  /// Delete profile event to clear session and navigate to login page
  Future<void> _handleDeleteProfile({required BuildContext context, required Emitter<ProfileState> emit}) async {
    Either<ErrorResponse, CommonResponse>? response = await UserRepository(context).deleteAccount();
    await response?.fold((l) {
      ErrorResponse errorModel = l;
      Utils.showMessage(errorModel.message);
    }, (r) async {
      BlocProvider.of<LandingBloc>(context).add(const LandingLogoutEvent());
      BlocProvider.of<LandingBloc>(context).add(LandingChangeTabEvent(LandingBloc.homeIndex, context: context));
      await StorageManager().clearSession();
      context.pushNamedAndRemoveUntil(AppRoutes.signInPage, (route) => false);
    });
  }

  void clearData() {
    userIdDetails = null;
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    contactNumberController.clear();
    firstNameError = null;
    lastNameError = null;
    contactNumberError = null;
  }

  void onTapEditProfileButton({required BuildContext context}) {
    _getUserDetailsFromStorage();
    Utils.showSmartModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12.r), topRight: Radius.circular(12.r)),
      ),
      builder: (context) => LayoutBuilder(
        builder: (context, _) {
          return AnimatedPadding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            duration: const Duration(milliseconds: 50),
            curve: Curves.easeOut,
            child: Container(
              constraints: BoxConstraints(maxHeight: context.height, minHeight: 660.h),
              child: const EditProfileBottomSheet(),
            ),
          );
        },
      ),
    );
  }

  Future<void> _handleProfilePickImage({required Emitter<ProfileState> emit, required ImageSource imageSource}) async {
    try {
      await _pickSingleImage(imageSource, emit);
    } on PlatformException catch (e) {
      _handlePlatformException(e);
    }
  }

  Future<void> _pickSingleImage(ImageSource source, Emitter<ProfileState> emit) async {
    emit(ProfileReloadState());
    XFile? pickedImage = await _picker.pickImage(source: source);
    if (pickedImage != null) {
      profilePickedImageList.clear();
      profilePickedImageList.add(pickedImage);
      emit(ProfilePickImageState());
    }
  }

  void _handleRemoveProfileImage({required Emitter<ProfileState> emit}) {
    emit(ProfileReloadState());
    profilePickedImageList.clear();
    emit(ProfilePickImageState());
  }

  void _handlePlatformException(PlatformException e) {
    switch (e.code) {
      case 'camera_access_denied':
      case 'photo_access_denied':
        Utils.showDoubleActionDialog(
          title: e.message,
          okButtonText: APPStrings.ok.tr,
          cancelButtonText: APPStrings.cancel.tr,
          content: APPStrings.errorAllowCameraSettings.tr,
          onOkPressed: () {
            openAppSettings();
          },
        );
        break;
      default:
        Utils.showMessage("An error occurred: ${e.message}");
        break;
    }
  }
}
