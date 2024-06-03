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
      BlocProvider<HomeBloc>(create: (_) => HomeBloc()),
      BlocProvider<CategoriesBloc>(create: (_) => CategoriesBloc()),
      BlocProvider<MyBagBloc>(create: (_) => MyBagBloc()),
      BlocProvider<SupportBloc>(create: (_) => SupportBloc()),
      BlocProvider<ProfileBloc>(create: (_) => ProfileBloc()),
      BlocProvider<DashboardBloc>(create: (_) => DashboardBloc()),
      BlocProvider<ForgotPasswordBloc>(create: (_) => ForgotPasswordBloc()),
      BlocProvider<ResetPasswordBloc>(create: (_) => ResetPasswordBloc()),
      BlocProvider<ForgotEmailSentBloc>(create: (_) => ForgotEmailSentBloc()),
      BlocProvider<CollectionBloc>(create: (_) => CollectionBloc()),
      BlocProvider<ProductListBloc>(create: (_) => ProductListBloc()),
      BlocProvider<SortFilterBloc>(create: (_) => SortFilterBloc()),
      BlocProvider<SettingDetailBloc>(create: (_) => SettingDetailBloc()),
      BlocProvider<DiamondDetailBloc>(create: (_) => DiamondDetailBloc()),
      BlocProvider<DiamondListingBloc>(create: (_) => DiamondListingBloc()),
      BlocProvider<SettingListingBloc>(create: (_) => SettingListingBloc()),
      BlocProvider<CompleteProductBloc>(create: (_) => CompleteProductBloc()),
      BlocProvider<CompareProductBloc>(create: (_) => CompareProductBloc()),
      BlocProvider<AddAddressBloc>(create: (_) => AddAddressBloc()),
      BlocProvider<WishlistBloc>(create: (_) => WishlistBloc()),
      BlocProvider<PaymentBloc>(create: (_) => PaymentBloc()),
      BlocProvider<AddressListBloc>(create: (_) => AddressListBloc()),
      BlocProvider<DiamondFilterBloc>(create: (_) => DiamondFilterBloc()),
      BlocProvider<AuctionBloc>(create: (_) => AuctionBloc()),
    ];
  }
}
