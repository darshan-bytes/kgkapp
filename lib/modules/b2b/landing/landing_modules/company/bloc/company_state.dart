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
  final int index;
  final int oldIndex;

  const SelectCompanyListState(this.index, this.oldIndex);

  @override
  List<Object> get props => [index, oldIndex];
}

final class CompanyListLoadedState extends CompanyState {
  final List<CompanyListModel> companyList;
  final CompanyListModel? selectedData;

  const CompanyListLoadedState({
    required this.companyList,
    this.selectedData,
  });

  @override
  List<Object?> get props => [companyList, selectedData];
}
