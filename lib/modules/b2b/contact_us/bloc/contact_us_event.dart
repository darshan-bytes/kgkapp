part of 'contact_us_bloc.dart';

sealed class ContactUsEvent extends Equatable {
  const ContactUsEvent();
}

class ContactUsInitialEvent extends ContactUsEvent {
  @override
  List<Object> get props => [];
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
