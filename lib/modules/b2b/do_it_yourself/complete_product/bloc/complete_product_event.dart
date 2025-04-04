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

final class CompleteProductAddToBagEvent extends CompleteProductEvent {
  final BuildContext context;

  const CompleteProductAddToBagEvent(this.context);

  @override
  List<Object> get props => [context];
}
