import 'package:kgk/kgk.dart';

part 'project_listing_event.dart';
part 'project_listing_state.dart';

class ProjectListingBloc extends Bloc<ProjectListingEvent, ProjectListingState> {
  final TextEditingController projectSearchController = TextEditingController();

  List<B2BCustomListingDataModel> filteredProjectList = _generateProjectList();

  ProjectListingBloc() : super(ProjectListingInitial()) {
    on<InitialProjectListingEvent>(_onInitialProjectListEvent);
    on<FilterProjectEvent>(_onFilterProjectEvent);
  }

  void _onInitialProjectListEvent(InitialProjectListingEvent event, Emitter<ProjectListingState> emit) {
    emit(ProjectListingReloadState());
    clearData();
    emit(ProjectListingLoadedState());
  }

  void _onFilterProjectEvent(FilterProjectEvent event, Emitter<ProjectListingState> emit) {
    emit(ProjectListingReloadState());
    final searchText = projectSearchController.text.toLowerCase();
    filteredProjectList =
        _generateProjectList().where((element) => (element.strProjectNumber ?? '').toLowerCase().contains(searchText)).toList();
    emit(FilterProjectState());
  }

  void clearData() {
    projectSearchController.clear();
    filteredProjectList = _generateProjectList();
  }

  static List<B2BCustomListingDataModel> _generateProjectList() {
    return List.generate(20, (index) {
      return B2BCustomListingDataModel(
        id: index.toString(),
        strProjectNumber: '1254875',
        strDesign: '1',
        strProjectName: 'Full blue moon',
        status: OrderStatus.active,
        strCustomer: 'Jenny Wilson',
        strCustomerImageUrl: 'https://i.ibb.co/hy6pH4g/Frame-3977.png',
        holdStatus: OrderStatus.onGoing,
        strCreatedOn: '23/03/2023',
        strCreatedBy: 'Jenny Wilson',
        strCreatedByImageUrl: 'https://i.ibb.co/BLyLVHS/Frame-3978.png',
      );
    });
  }
}
