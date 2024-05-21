import 'package:kgk/kgk.dart';

import 'modules/forgot_password/bloc/forgot_password_bloc.dart';

class BlocGenerator {
  static List<BlocProvider> generateBlocList() {
    return [
      BlocProvider<SignInBloc>(create: (_) => SignInBloc()),
      BlocProvider<AppBloc>(create: (_) => AppBloc()..add(LoadAppEvent()), lazy: false),
      BlocProvider<DashboardBloc>(create: (_) => DashboardBloc()),
      BlocProvider<HomeBloc>(create: (_) => HomeBloc()),
      BlocProvider<CategoriesBloc>(create: (_) => CategoriesBloc()),
      BlocProvider<MyBagBloc>(create: (_) => MyBagBloc()),
      BlocProvider<SupportBloc>(create: (_) => SupportBloc()),
      BlocProvider<ProfileBloc>(create: (_) => ProfileBloc()),
      BlocProvider<ForgotPasswordBloc>(create: (_) => ForgotPasswordBloc()),
    ];
  }
}
