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
