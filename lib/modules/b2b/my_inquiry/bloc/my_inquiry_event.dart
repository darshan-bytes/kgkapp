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
