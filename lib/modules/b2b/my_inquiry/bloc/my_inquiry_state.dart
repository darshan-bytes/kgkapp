part of 'my_inquiry_bloc.dart';

sealed class MyInquiryState extends Equatable {
  const MyInquiryState();
}

final class MyInquiryInitial extends MyInquiryState {
  @override
  List<Object> get props => [];
}

final class MyInquiryLoadedState extends MyInquiryState {
  @override
  List<Object> get props => [];
}

final class MyInquiryReloadState extends MyInquiryState {
  @override
  List<Object> get props => [];
}
