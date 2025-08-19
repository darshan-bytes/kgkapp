import 'package:kgk/kgk.dart';

part 'share_presentation_event.dart';

part 'share_presentation_state.dart';

class SharePresentationBloc extends Bloc<SharePresentationEvent, SharePresentationState> {
  bool isPresentation = true;

  String appBarTitle = "";
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  MultipleSearchController controller = MultipleSearchController(allowDuplicateSelection: false, minCharsToShowItems: 0);
  List<PresentationSharedUserData> userList = [];

  List<UserIdDetails> userIdDetailsList = [];

  UserAccessType? selectedGeneralAccessType;

  String? webUrl;

  SharePresentationBloc() : super(SharePresentationInitial()) {
    on<SharePresentationInitialEvent>(_onSharePresentationInitialEvent);
    on<ChangeUserAccessTypeEvent>(_onChangeUserAccessTypeEvent);
    on<ChangeGeneralAccessTypeEvent>(_onChangeGeneralAccessTypeEvent);
  }

  // People access types
  final List<UserAccessType> arrPeopleAccessType = [
    UserAccessType(accessType: "Viewer", code: "viewer"),
    UserAccessType(accessType: "Editor", code: "editor"),
    UserAccessType(accessType: "Remove Access?", code: "remove_access", isRemove: true),
  ];

  // General access types
  final List<UserAccessType> arrGeneralAccessType = [
    UserAccessType(accessType: "Viewer"),
    UserAccessType(accessType: "Restricted"),
    UserAccessType(accessType: "Editor"),
  ];

  Future<void> _onSharePresentationInitialEvent(SharePresentationInitialEvent event, Emitter<SharePresentationState> emit) async {
    isPresentation = event.isPresentation;
    webUrl = event.webUrl;
    appBarTitle = isPresentation ? APPStrings.sharePresentation.tr : APPStrings.shareCatalogue.tr;
    userList.clear();
    emailController.clear();
    selectedGeneralAccessType = arrGeneralAccessType.first;
    emit(const SharePresentationLoadingState());
    emit(SharePresentationTitleLoadedState(appBarTitle));
    await fetchUserList(event.context);
    if (isPresentation) {
      await fetchSharedUserList(event.context, event.webUrl ?? "");
    } else {
      await fetchSharedCatalogueList(event.context, event.webUrl ?? "");
    }
    emit(const SharePresentationLoadedState());
  }

  void _onChangeUserAccessTypeEvent(ChangeUserAccessTypeEvent event, Emitter<SharePresentationState> emit) {
    emit(const SharePresentationReloadState());
    //TODO: Update the user access type in the user list
    // event.user.userAccessType = event.selectedUserAccessType;
    emit(ChangeUserAccessTypeState(event.selectedUserAccessType));
  }

  void _onChangeGeneralAccessTypeEvent(ChangeGeneralAccessTypeEvent event, Emitter<SharePresentationState> emit) {
    emit(const SharePresentationReloadState());
    selectedGeneralAccessType = event.selectedGeneralAccessType;
    emit(ChangeGeneralAccessTypeState(event.selectedGeneralAccessType));
  }

  Future<void> fetchUserList(BuildContext context) async {
    final result = await AppRepository(context).jewelleryInternalUsers();
    result?.fold(
      (l) {
        Utils.showMessage(l.message);
        userIdDetailsList = [];
      },
      (r) {
        userIdDetailsList = r;
      },
    );
  }

  Future<void> fetchSharedUserList(BuildContext context, String presentationNumber) async {
    final result = await AppRepository(context).sharedUsersByPresentationNumber(presentationNumber);
    result?.fold(
      (l) {
        Utils.showMessage(l.message);
        userList = [];
      },
      (r) {
        userList = r;
      },
    );
  }

  Future<void> fetchSharedCatalogueList(BuildContext context, String catalogueType) async {
    final result = await AppRepository(context).digitalCatalogueShareList(catalogueType);
    result?.fold(
      (l) {
        Utils.showMessage(l.message);
        userList = [];
      },
      (r) {
        userList =
            r.firstOrNull?.sharedWith.map((e) {
              return PresentationSharedUserData(
                accessType: e.isViewer ? 'viewer' : (e.isEditable ? 'editor' : ''),
                userId: e.id,
                userIdDetails: e.user,
              );
            }).toList() ??
            [];
      },
    );
  }
}
