import 'package:kgk/kgk.dart';

class BlocGenerator {
  static List<BlocProvider> generateBlocList() {
    return [
      BlocProvider<SignInBloc>(create: (_) => SignInBloc()),
      BlocProvider<GetReadyBloc>(create: (_) => GetReadyBloc()),
      BlocProvider<AppBloc>(create: (_) => AppBloc()..add(LoadAppEvent()), lazy: false),
      BlocProvider<SignInBloc>(create: (_) => SignInBloc()),
      BlocProvider<SignUpBloc>(create: (_) => SignUpBloc()),
      BlocProvider<CategoriesBloc>(create: (_) => CategoriesBloc()),
      BlocProvider<DashboardBloc>(create: (_) => DashboardBloc()),
      BlocProvider<HomeBloc>(create: (_) => HomeBloc()),
      BlocProvider<CategoriesBloc>(create: (_) => CategoriesBloc()),
      BlocProvider<MyBagBloc>(create: (_) => MyBagBloc()),
      BlocProvider<SupportBloc>(create: (_) => SupportBloc()),
      BlocProvider<ProfileBloc>(create: (_) => ProfileBloc()),
      BlocProvider<ForgotPasswordBloc>(create: (_) => ForgotPasswordBloc()),
      BlocProvider<ResetPasswordBloc>(create: (_) => ResetPasswordBloc()),
      BlocProvider<ForgotEmailSentBloc>(create: (_) => ForgotEmailSentBloc()),
      BlocProvider<CollectionBloc>(create: (_) => CollectionBloc()),
      BlocProvider<RingDetailBloc>(create: (_) => RingDetailBloc()),
    ];
  }
}
