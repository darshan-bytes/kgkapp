part of 'inquiry_detail_bloc.dart';

sealed class InquiryDetailState extends Equatable {
  const InquiryDetailState();
}

final class InquiryDetailInitial extends InquiryDetailState {
  const InquiryDetailInitial();

  @override
  List<Object> get props => [];
}

final class InquiryDetailLoading extends InquiryDetailState {
  const InquiryDetailLoading();

  @override
  List<Object> get props => [];
}

final class InquiryDetailLoaded extends InquiryDetailState {
  final MyInquiriesModel inquiryData;

  const InquiryDetailLoaded({required this.inquiryData});

  @override
  List<Object> get props => [inquiryData];
}
