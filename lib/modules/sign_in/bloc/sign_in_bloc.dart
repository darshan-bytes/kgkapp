import 'package:kgk/kgk.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  bool switchValue = false;
  late BuildContext context;

  SignInBloc() : super(SignInInitial()) {
    String lang = StorageManager().getLocale() ?? APPStrings.languageEn;
    if (lang == APPStrings.languageEn) {
      switchValue = false;
    } else {
      switchValue = true;
    }
    on<ChangeSwitchValueEvent>(onChangeSwitchValue);
  }

  Future<void> onChangeSwitchValue(ChangeSwitchValueEvent event, Emitter<SignInState> emit) async {
    emit(const SignInReloadState());
    switchValue = event.switchValue;

    if (event.switchValue) {
      await StorageManager().setLocale(APPStrings.languageKo);
    } else {
      await StorageManager().setLocale(APPStrings.languageEn);
    }

    await AppLocalizations.of(getNavigatorKeyContext)?.changeLocale();
    emit(const ChangeValueState());
  }
}
