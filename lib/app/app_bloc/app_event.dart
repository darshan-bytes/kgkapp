part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();
}

class LoadAppEvent extends AppEvent {
  final BuildContext context;

  const LoadAppEvent({required this.context});

  @override
  List<Object> get props => [context];
}

class ChangeThemeEvent extends AppEvent {
  final BuildContext context;
  final String theme;

  const ChangeThemeEvent({required this.context, required this.theme});

  @override
  List<Object> get props => [context, theme];
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
  final VoidCallback? callback;

  const LanguageChangedEvent(this.languageCode, {required this.context, this.callback});

  @override
  List<Object?> get props => [languageCode, context, callback];
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
  final ProductDetailsModel productDetails;
  final BuildContext context;
  final Function()? onFavTap;

  const ProductAddToFavoriteEvent(this.productDetails, this.context, {this.onFavTap});

  @override
  List<Object?> get props => [productDetails, context, onFavTap];
}

class ProductRemoveFromFavoriteEvent extends AppEvent {
  final ProductDetailsModel productDetails;
  final BuildContext context;
  final Function()? onFavTap;

  const ProductRemoveFromFavoriteEvent(this.productDetails, this.context, {this.onFavTap});

  @override
  List<Object?> get props => [productDetails, context, onFavTap];
}

class ProductAddToBagEvent extends AppEvent {
  final ProductDetailsModel productDetails;
  final BuildContext context;

  const ProductAddToBagEvent(this.productDetails, this.context);

  @override
  List<Object> get props => [productDetails, context];
}

class ProductRemoveFromBagEvent extends AppEvent {
  final ProductDetailsModel productDetails;
  final BuildContext context;

  const ProductRemoveFromBagEvent(this.productDetails, this.context);

  @override
  List<Object> get props => [productDetails, context];
}

class ProductAddToWatchListEvent extends AppEvent {
  final ProductDetailsModel productDetails;
  final BuildContext context;

  const ProductAddToWatchListEvent(this.productDetails, this.context);

  @override
  List<Object> get props => [productDetails, context];
}
