part of 'contact_us_bloc.dart';

sealed class ContactUsEvent extends Equatable {
  const ContactUsEvent();
}

class ContactUsInitialEvent extends ContactUsEvent {
  final BuildContext context;

  const ContactUsInitialEvent({required this.context});

  @override
  List<Object> get props => [context];
}

class ContactUsChangeInquiryTypeEvent extends ContactUsEvent {
  final InquiryTypeModel inquiryTypeModel;

  const ContactUsChangeInquiryTypeEvent({required this.inquiryTypeModel});

  @override
  List<Object> get props => [inquiryTypeModel];
}

class ContactUsChangeSelectProductEvent extends ContactUsEvent {
  final ProductModel productModel;

  const ContactUsChangeSelectProductEvent({required this.productModel});

  @override
  List<Object> get props => [productModel];
}

class ContactUsSubmitEvent extends ContactUsEvent {
  final BuildContext context;

  const ContactUsSubmitEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class ContactUsChangeCountryCodeEvent extends ContactUsEvent {
  final Country country;

  const ContactUsChangeCountryCodeEvent({required this.country});

  @override
  List<Object> get props => [country];
}

final class ContactUsRemoveContactEvent extends ContactUsEvent {
  final int index;

  const ContactUsRemoveContactEvent(this.index);

  @override
  List<Object> get props => [index];
}
