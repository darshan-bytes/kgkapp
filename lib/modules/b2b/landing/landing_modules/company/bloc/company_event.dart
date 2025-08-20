part of 'company_bloc.dart';

@immutable
sealed class CompanyEvent extends Equatable {
  const CompanyEvent();
}

final class InitialCompanyListEvent extends CompanyEvent {
  final BuildContext context;

  const InitialCompanyListEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class SelectCompanyListEvent extends CompanyEvent {
  final int index;

  const SelectCompanyListEvent(this.index);

  @override
  List<Object> get props => [index];
}

final class SearchCompanyListEvent extends CompanyEvent {
  final String searchQuery;

  const SearchCompanyListEvent(this.searchQuery);

  @override
  List<Object> get props => [searchQuery];
}
