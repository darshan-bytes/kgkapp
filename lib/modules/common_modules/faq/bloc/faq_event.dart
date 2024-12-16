part of 'faq_bloc.dart';

sealed class FaqEvent extends Equatable {
  const FaqEvent();
}

final class FaqInitialEvent extends FaqEvent {
  final BuildContext context;

  const FaqInitialEvent(this.context);

  @override
  List<Object> get props => [context];
}
