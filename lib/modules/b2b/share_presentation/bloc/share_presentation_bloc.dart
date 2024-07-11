import 'package:kgk/kgk.dart';

part 'share_presentation_event.dart';

part 'share_presentation_state.dart';

class SharePresentationBloc extends Bloc<SharePresentationEvent, SharePresentationState> {
  bool isPresentation = true;

  String appBarTitle = "";
  final TextEditingController emailController = TextEditingController();
  List<UserListModel> userList = [];

  UserAccessType? selectedGeneralAccessType;

  SharePresentationBloc() : super(SharePresentationInitial()) {
    on<SharePresentationInitialEvent>(_onSharePresentationInitialEvent);
    on<ChangeUserAccessTypeEvent>(_onChangeUserAccessTypeEvent);
    on<ChangeGeneralAccessTypeEvent>(_onChangeGeneralAccessTypeEvent);
  }

  // People access types
  final List<UserAccessType> arrPeopleAccessType = [
    UserAccessType(accessType: "Owner"),
    UserAccessType(accessType: "Editor"),
    UserAccessType(accessType: "Commenter"),
    UserAccessType(accessType: "Viewer"),
  ];

  // General access types
  final List<UserAccessType> arrGeneralAccessType = [
    UserAccessType(accessType: "Viewer"),
    UserAccessType(accessType: "Restricted"),
    UserAccessType(accessType: "Editor"),
  ];

  Future<void> _onSharePresentationInitialEvent(SharePresentationInitialEvent event, Emitter<SharePresentationState> emit) async {
    isPresentation = event.isPresentation;
    appBarTitle = isPresentation ? APPStrings.sharePresentation.tr : APPStrings.shareCatalogue.tr;
    userList.clear();
    emailController.clear();
    selectedGeneralAccessType = arrGeneralAccessType.first;
    emit(const SharePresentationLoadingState());
    emit(SharePresentationTitleLoadedState(appBarTitle));
    await Future.delayed(const Duration(seconds: 1));
    userList = [
      UserListModel(
        name: "Albert Flores",
        image: "https://i.ibb.co/729SGNK/Ellipse-10.png",
        email: "user@domain.com",
        role: UserRole(roleName: APPStrings.owner.tr, isModifiable: false),
        userAccessType: arrPeopleAccessType.first,
      ),
      UserListModel(
        name: "Brooklyn Simmons",
        image: "https://i.ibb.co/fxCNcfr/Ellipse-9.png",
        email: "user@domain.com",
        role: UserRole(roleName: APPStrings.viewer.tr),
        userAccessType: arrPeopleAccessType.last,
      ),
      UserListModel(
        name: "Ralph Edwards",
        image: "https://i.ibb.co/SRqFmPK/Ellipse-91.png",
        email: "user@domain.com",
        role: UserRole(roleName: APPStrings.viewer.tr),
        userAccessType: arrPeopleAccessType.last,
      ),
      UserListModel(
        name: "Albert Flores",
        image: "https://i.ibb.co/Cm7hxkk/Ellipse-92.png",
        email: "user@domain.com",
        role: UserRole(roleName: APPStrings.editor.tr),
        userAccessType: arrPeopleAccessType.last,
      ),
    ];
    emit(const SharePresentationLoadedState());
  }

  void _onChangeUserAccessTypeEvent(ChangeUserAccessTypeEvent event, Emitter<SharePresentationState> emit) {
    emit(const SharePresentationReloadState());
    event.user.userAccessType = event.selectedUserAccessType;
    emit(ChangeUserAccessTypeState(event.selectedUserAccessType));
  }

  void _onChangeGeneralAccessTypeEvent(ChangeGeneralAccessTypeEvent event, Emitter<SharePresentationState> emit) {
    emit(const SharePresentationReloadState());
    selectedGeneralAccessType = event.selectedGeneralAccessType;
    emit(ChangeGeneralAccessTypeState(event.selectedGeneralAccessType));
  }
}
