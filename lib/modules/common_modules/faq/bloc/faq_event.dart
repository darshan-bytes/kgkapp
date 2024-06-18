part of 'faq_bloc.dart';

sealed class FaqEvent extends Equatable {
  const FaqEvent();
}

final class FaqInitialEvent extends FaqEvent {
  const FaqInitialEvent();

  @override
  List<Object?> get props => [];
}
