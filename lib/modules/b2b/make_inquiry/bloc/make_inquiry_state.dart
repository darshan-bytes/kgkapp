part of 'make_inquiry_bloc.dart';

sealed class MakeInquiryState extends Equatable {
  const MakeInquiryState();
}

final class MakeInquiryInitial extends MakeInquiryState {
  @override
  List<Object> get props => [];
}

final class MakeInquiryLoadedState extends MakeInquiryState {
  const MakeInquiryLoadedState();

  @override
  List<Object> get props => [];
}

final class MakeInquiryReloadState extends MakeInquiryState {
  @override
  List<Object> get props => [];
}

final class ToggleMakeInquiryState extends MakeInquiryState {
  const ToggleMakeInquiryState();

  @override
  List<Object> get props => [];
}

final class ToggleProductState extends MakeInquiryState {
  const ToggleProductState();

  @override
  List<Object> get props => [];
}
