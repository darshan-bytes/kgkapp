import 'package:kgk/kgk.dart';

part 'company_event.dart';

part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  bool _isInitialized = false;
  CscDetails? selectData;

  List<CscDetails> companyList = [];

  CompanyBloc() : super(CompanyInitialState()) {
    on<InitialCompanyListEvent>(_onInitialCompanyListEvent);
    on<SelectCompanyListEvent>(_onSelectCompanyListEvent);
  }

  Future<void> _onInitialCompanyListEvent(InitialCompanyListEvent event, Emitter<CompanyState> emit) async {
    if (_isInitialized) return;
    selectData = StorageManager().getSelectedCsc();
    if (companyList.isEmpty) {
      await loadCompanyList(event.context, emit);
      if (selectData == null) {
        UserResponse? userResponse = StorageManager().getUserResponse();
        String? defaultCscCode = userResponse?.defaultCscCode;
        if (defaultCscCode != null) {
          selectData = companyList.firstWhereOrNull((element) => element.cscCode == defaultCscCode) ?? companyList.firstOrNull;
          if (selectData != null) {
            await StorageManager().setSelectedCsc(selectData!);
          }
        }
      }
    }
    emit(CompanyListLoadedState(companyList: companyList, selectedData: selectData));
    if (selectData != null) {
      companyList.remove(selectData);
      companyList.insert(0, selectData!);
    }
    if (companyList.isNotEmpty) {
      _isInitialized = true;
    }
  }

  Future<void> _onSelectCompanyListEvent(SelectCompanyListEvent event, Emitter<CompanyState> emit) async {
    emit(CompanyReloadState());
    int oldIndex = selectData == null ? -1 : companyList.indexOf(selectData!);
    selectData = companyList[event.index];
    if (selectData != null) {
      await StorageManager().setSelectedCsc(selectData!);
    }
    emit(SelectCompanyListState(event.index, oldIndex));
  }

  Future<void> loadCompanyList(BuildContext context, Emitter<CompanyState> emit) async {
    final response = await UserRepository(context).getCscMastersList();
    response?.fold(
      (error) {
        Utils.showMessage(error.message);
      },
      (companyListData) {
        companyList = companyListData;
        emit(CompanyListLoadedState(companyList: companyList, selectedData: selectData));
      },
    );
  }
}
