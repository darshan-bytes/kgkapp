part of 'make_inquiry_bloc.dart';

sealed class MakeInquiryEvent extends Equatable {
  const MakeInquiryEvent();
}

class MakeInquiryInitialEvent extends MakeInquiryEvent {
  @override
  List<Object> get props => [];
}

class MakeInquiryReloadEvent extends MakeInquiryEvent {
  @override
  List<Object> get props => [];
}

class ChangeInquiryTypeEvent extends MakeInquiryEvent {
  final InquiryTypeModel inquiryTypeModel;

  const ChangeInquiryTypeEvent({required this.inquiryTypeModel});

  @override
  List<Object> get props => [inquiryTypeModel];
}

class ChangeSelectProductEvent extends MakeInquiryEvent {
  final ProductModel productModel;

  const ChangeSelectProductEvent({required this.productModel});

  @override
  List<Object> get props => [productModel];
}
