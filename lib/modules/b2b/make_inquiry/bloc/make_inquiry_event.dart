part of 'make_inquiry_bloc.dart';

sealed class MakeInquiryEvent extends Equatable {
  const MakeInquiryEvent();
}

class MakeInquiryInitialEvent extends MakeInquiryEvent {
  final BuildContext context;

  const MakeInquiryInitialEvent({required this.context});

  @override
  List<Object> get props => [context];
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

class ChangeSelectTypeEvent extends MakeInquiryEvent {
  final StatusModel statusModel;

  const ChangeSelectTypeEvent({required this.statusModel});

  @override
  List<Object> get props => [statusModel];
}

class ChangeSelectProductEvent extends MakeInquiryEvent {
  final ProductModel productModel;

  const ChangeSelectProductEvent({required this.productModel});

  @override
  List<Object> get props => [productModel];
}

class MakeInquirySubmitEvent extends MakeInquiryEvent {
  final BuildContext context;
  final String inquiryId;

  const MakeInquirySubmitEvent({required this.context, this.inquiryId = ''});

  @override
  List<Object> get props => [context, inquiryId];
}
