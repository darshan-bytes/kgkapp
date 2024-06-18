part of 'faq_bloc.dart';

sealed class FaqState extends Equatable {
  const FaqState();
}

final class FaqInitial extends FaqState {
  @override
  List<Object> get props => [];
}

final class FaqLoadedState extends FaqState {
  final List<FaqWrapper> faqs;

  const FaqLoadedState(this.faqs);

  @override
  List<Object> get props => [faqs];
}
