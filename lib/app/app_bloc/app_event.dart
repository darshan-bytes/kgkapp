part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();
}

class LoadAppEvent extends AppEvent {
  @override
  List<Object> get props => [];
}

class ChangeThemeEvent extends AppEvent {
  final String theme;

  const ChangeThemeEvent(this.theme);

  @override
  List<Object> get props => [theme];
}

class ConnectivityChangedEvent extends AppEvent {
  final bool connectivityResult;

  const ConnectivityChangedEvent(this.connectivityResult);

  @override
  List<Object> get props => [connectivityResult];
}

class LanguageChangedEvent extends AppEvent {
  final String languageCode;
  final BuildContext context;

  const LanguageChangedEvent(this.languageCode, {required this.context});

  @override
  List<Object> get props => [languageCode, context];
}

class SetAppLoadingEvent extends AppEvent {
  final bool isLoading;

  const SetAppLoadingEvent(this.isLoading);

  @override
  List<Object> get props => [isLoading];
}

class SetUserTypeEvent extends AppEvent {
  final UserType userType;

  const SetUserTypeEvent(this.userType);

  @override
  List<Object> get props => [userType];
}

class ProductAddToFavoriteEvent extends AppEvent {
  final ProductDetails productDetails;
  final BuildContext context;

  const ProductAddToFavoriteEvent(this.productDetails, this.context);

  @override
  List<Object> get props => [productDetails, context];
}

class ProductRemoveFromFavoriteEvent extends AppEvent {
  final ProductDetails productDetails;
  final BuildContext context;

  const ProductRemoveFromFavoriteEvent(this.productDetails, this.context);

  @override
  List<Object> get props => [productDetails, context];
}

class ProductAddToBagEvent extends AppEvent {
  final ProductDetails productDetails;
  final BuildContext context;

  const ProductAddToBagEvent(this.productDetails, this.context);

  @override
  List<Object> get props => [productDetails, context];
}

class ProductRemoveFromBagEvent extends AppEvent {
  final ProductDetails productDetails;
  final BuildContext context;

  const ProductRemoveFromBagEvent(this.productDetails, this.context);

  @override
  List<Object> get props => [productDetails, context];
}
