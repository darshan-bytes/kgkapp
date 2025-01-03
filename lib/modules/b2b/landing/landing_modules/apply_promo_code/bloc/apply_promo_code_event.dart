part of 'apply_promo_code_bloc.dart';

sealed class ApplyPromoCodeEvent extends Equatable {
  const ApplyPromoCodeEvent();
}

final class InitialApplyPromoCodeEvent extends ApplyPromoCodeEvent {
  final BuildContext context;
  const InitialApplyPromoCodeEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

final class OnTapApplyPromoCodeEvent extends ApplyPromoCodeEvent {
  final BuildContext context;
  final String promoCode;

  const OnTapApplyPromoCodeEvent({required this.context, required this.promoCode});

  @override
  List<Object?> get props => [context, promoCode];
}

final class OnTapRemovePromoCodeEvent extends ApplyPromoCodeEvent {
  final BuildContext context;

  const OnTapRemovePromoCodeEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
