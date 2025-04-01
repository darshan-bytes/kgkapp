part of 'my_inquiry_bloc.dart';

sealed class MyInquiryEvent extends Equatable {
  const MyInquiryEvent();
}

class MyInquiryInitialEvent extends MyInquiryEvent {
  final BuildContext context;

  const MyInquiryInitialEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class FilterMyInquiryEvent extends MyInquiryEvent {
  final BuildContext context;
  final List<FilterData> filterData;

  const FilterMyInquiryEvent(this.context, this.filterData);

  @override
  List<Object> get props => [context, filterData];
}

final class MyInquiryLoadMoreEvent extends MyInquiryEvent {
  final int currentPage;
  final BuildContext context;

  const MyInquiryLoadMoreEvent(this.currentPage, this.context);

  @override
  List<Object> get props => [currentPage];
}

final class MyInquiryEditEvent extends MyInquiryEvent {
  final String inquiryId;
  final BuildContext context;

  const MyInquiryEditEvent(this.inquiryId, this.context);

  @override
  List<Object> get props => [inquiryId, context];
}

final class MyInquiryUpdateEvent extends MyInquiryEvent {
  final BuildContext context;

  const MyInquiryUpdateEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class MyInquiryRemoveEvent extends MyInquiryEvent {
  final int index;
  final BuildContext context;

  const MyInquiryRemoveEvent(this.index, this.context);

  @override
  List<Object> get props => [index, context];
}
