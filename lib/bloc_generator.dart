import 'kgk.dart';

class BlocGenerator {
  static List<BlocProvider> generateBlocList() {
    return [
      BlocProvider<SignInBloc>(create: (_) => SignInBloc()),
      BlocProvider<AppBloc>(create: (_) => AppBloc()..add(LoadAppEvent()), lazy: false),
    ];
  }
}
