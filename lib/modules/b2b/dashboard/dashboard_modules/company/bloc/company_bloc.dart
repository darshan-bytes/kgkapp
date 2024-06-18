import 'package:kgk/kgk.dart';

part 'company_event.dart';

part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  CompanyListModel? selectData;

  List<CompanyListModel> companyList = [];

  CompanyBloc() : super(CompanyInitialState()) {
    on<InitialCompanyListEvent>(_onInitialCompanyListEvent);
    on<SelectCompanyListEvent>(_onSelectCompanyListEvent);
  }

  void _onInitialCompanyListEvent(InitialCompanyListEvent event, Emitter<CompanyState> emit) {
    companyList = [
      CompanyListModel(image: 'https://i.ibb.co/cyvpMrR/KGK-Group-Logo-1.png', title: 'KGK'),
      CompanyListModel(image: 'https://i.ibb.co/hB38mv2/Entice.png', title: 'Entice'),
      CompanyListModel(image: 'https://i.ibb.co/8M7vLPs/Martin-Flyer.png', title: 'Martin Flyer')
    ];
    selectData = companyList[0];
    emit(CompanyListLoadedState(companyList: companyList, selectedData: selectData));
  }

  void _onSelectCompanyListEvent(SelectCompanyListEvent event, Emitter<CompanyState> emit) {
    emit(CompanyReloadState());
    int oldIndex = companyList.indexOf(selectData ?? CompanyListModel());
    selectData = companyList[event.index];
    emit(SelectCompanyListState(event.index, oldIndex));
  }
}
