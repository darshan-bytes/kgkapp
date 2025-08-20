part of 'company_bloc.dart';

sealed class CompanyState extends Equatable {
  const CompanyState();
}

final class CompanyInitialState extends CompanyState {
  @override
  List<Object> get props => [];
}

final class CompanyReloadState extends CompanyState {
  @override
  List<Object> get props => [];
}

final class SelectCompanyListState extends CompanyState {
  const SelectCompanyListState();

  @override
  List<Object> get props => [];
}

final class CompanyListLoadedState extends CompanyState {
  final List<CscDetails> companyList;
  final CscDetails? selectedData;

  const CompanyListLoadedState({required this.companyList, this.selectedData});

  @override
  List<Object?> get props => [companyList, selectedData];
}
