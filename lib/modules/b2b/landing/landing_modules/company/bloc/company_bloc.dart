import 'package:kgk/kgk.dart';

part 'company_event.dart';

part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final TextEditingController searchController = TextEditingController();
  CscDetails? selectData;

  List<CscDetails> _companyList = [];

  List<CscDetails> get companyList {
    if (searchController.text.trim().isEmpty) {
      return _companyList;
    } else {
      return _companyList
          .where((element) => element.cscName?.toLowerCase().contains(searchController.text.trim().toLowerCase()) ?? false)
          .toList();
    }
  }

  CompanyBloc() : super(CompanyInitialState()) {
    on<InitialCompanyListEvent>(_onInitialCompanyListEvent);
    on<SelectCompanyListEvent>(_onSelectCompanyListEvent);
    on<SearchCompanyListEvent>(_onSearchCompanyList, transformer: BlocEventDeBouncer.debounceTransformer());
  }

  Future<void> _onInitialCompanyListEvent(InitialCompanyListEvent event, Emitter<CompanyState> emit) async {
    selectData = StorageManager().getSelectedCsc();
    await loadCompanyList(event.context, emit);
    if (selectData == null) {
      UserResponse? userResponse = StorageManager().getUserResponse();
      String? defaultCscCode = userResponse?.defaultCscCode;
      if (defaultCscCode != null) {
        selectData = _companyList.firstWhereOrNull((element) => element.cscCode == defaultCscCode) ?? _companyList.firstOrNull;
        if (selectData != null) {
          await StorageManager().setSelectedCsc(selectData!);
        }
      }
    }
    if (selectData != null) {
      _companyList.remove(selectData);
      _companyList.insert(0, selectData!);
    }
    if (_companyList.isNotEmpty) {
      emit(CompanyListLoadedState(companyList: _companyList, selectedData: selectData));
    }

    searchController.addListener(() {
      add(SearchCompanyListEvent(searchController.text));
    });
  }

  Future<void> _onSelectCompanyListEvent(SelectCompanyListEvent event, Emitter<CompanyState> emit) async {
    emit(CompanyReloadState());
    selectData = companyList[event.index];
    if (selectData != null) {
      await StorageManager().setSelectedCsc(selectData!);
    }
    emit(SelectCompanyListState());
  }

  Future<void> loadCompanyList(BuildContext context, Emitter<CompanyState> emit) async {
    final response = await UserRepository(context).getCscMastersList();
    response?.fold(
      (error) {
        Utils.showMessage(error.message);
      },
      (companyListData) {
        _companyList = companyListData;
        emit(CompanyListLoadedState(companyList: companyList, selectedData: selectData));
      },
    );
  }

  // REF: https://thekgk.atlassian.net/browse/TA-834
  Future<void> _onSearchCompanyList(SearchCompanyListEvent event, Emitter<CompanyState> emit) async {
    emit(CompanyListLoadedState(companyList: companyList, selectedData: selectData));
  }
}
