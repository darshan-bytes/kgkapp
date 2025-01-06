part of 'contact_us_bloc.dart';

sealed class ContactUsState extends Equatable {
  const ContactUsState();
}

final class ContactUsInitial extends ContactUsState {
  @override
  List<Object> get props => [];
}

final class ContactUsChangeInquiryTypeState extends ContactUsState {
  const ContactUsChangeInquiryTypeState();

  @override
  List<Object> get props => [];
}

final class ContactUsChangeSelectProductState extends ContactUsState {
  const ContactUsChangeSelectProductState();

  @override
  List<Object> get props => [];
}

final class ContactUsReloadState extends ContactUsState {
  const ContactUsReloadState();

  @override
  List<Object> get props => [];
}

final class ContactUsSubmitState extends ContactUsState {
  const ContactUsSubmitState();

  @override
  List<Object> get props => [];
}