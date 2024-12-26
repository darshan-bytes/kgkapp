part of 'apply_promo_code_bloc.dart';

sealed class ApplyPromoCodeState extends Equatable {
  const ApplyPromoCodeState();

  @override
  List<Object> get props => [];
}

final class ApplyPromoCodeInitial extends ApplyPromoCodeState {}

final class ApplyPromoCodeLoadedState extends ApplyPromoCodeState {}

final class ApplyPromoCodeLoadingState extends ApplyPromoCodeState {}
