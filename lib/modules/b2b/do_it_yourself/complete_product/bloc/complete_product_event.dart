part of 'complete_product_bloc.dart';

sealed class CompleteProductEvent extends Equatable {
  const CompleteProductEvent();
}

final class CompleteProductInitialEvent extends CompleteProductEvent {
  final BuildContext context;

  const CompleteProductInitialEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class CompleteProductCompareToggle extends CompleteProductEvent {
  final bool isCompare;

  const CompleteProductCompareToggle(this.isCompare);

  @override
  List<Object> get props => [];
}
