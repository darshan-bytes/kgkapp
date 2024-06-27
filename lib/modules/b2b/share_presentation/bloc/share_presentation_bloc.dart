import 'package:kgk/kgk.dart';

part 'share_presentation_event.dart';

part 'share_presentation_state.dart';

class SharePresentationBloc extends Bloc<SharePresentationEvent, SharePresentationState> {
  bool isPresentation = true;

  String appBarTitle = "";
  final TextEditingController emailController = TextEditingController();
  List<UserListModel> userList = [];

  SharePresentationBloc() : super(SharePresentationInitial()) {
    on<SharePresentationInitialEvent>(_onSharePresentationInitialEvent);
  }

  Future<void> _onSharePresentationInitialEvent(SharePresentationInitialEvent event, Emitter<SharePresentationState> emit) async {
    isPresentation = event.isPresentation;
    appBarTitle = isPresentation ? APPStrings.sharePresentation.tr : APPStrings.shareCatalogue.tr;
    userList.clear();
    emailController.clear();
    emit(const SharePresentationLoadingState());
    emit(SharePresentationTitleLoadedState(appBarTitle));
    await Future.delayed(const Duration(seconds: 1));
    userList = [
      UserListModel(
        name: "Albert Flores",
        image: "https://i.ibb.co/729SGNK/Ellipse-10.png",
        email: "user@domain.com",
        role: UserRole(roleName: APPStrings.owner.tr, isModifiable: false),
      ),
      UserListModel(
        name: "Brooklyn Simmons",
        image: "https://i.ibb.co/fxCNcfr/Ellipse-9.png",
        email: "user@domain.com",
        role: UserRole(roleName: APPStrings.viewer.tr),
      ),
      UserListModel(
        name: "Ralph Edwards",
        image: "https://i.ibb.co/SRqFmPK/Ellipse-91.png",
        email: "user@domain.com",
        role: UserRole(roleName: APPStrings.viewer.tr),
      ),
      UserListModel(
        name: "Albert Flores",
        image: "https://i.ibb.co/Cm7hxkk/Ellipse-92.png",
        email: "user@domain.com",
        role: UserRole(roleName: APPStrings.editor.tr),
      ),
    ];
    emit(const SharePresentationLoadedState());
  }
}
