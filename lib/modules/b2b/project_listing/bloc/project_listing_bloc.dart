import 'package:kgk/kgk.dart';

part 'project_listing_event.dart';

part 'project_listing_state.dart';

class ProjectListingBloc extends Bloc<ProjectListingEvent, ProjectListingState> {
  //Controller for search
  final TextEditingController projectSearchController = TextEditingController();

  //List of projects
  List<B2BCustomListingDataModel> projectList = _generateProjectList();

  //Pagination controller
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  ProjectListingBloc() : super(ProjectListingInitial()) {
    on<InitialProjectListingEvent>(_onInitialProjectListEvent);
    on<ProjectListLoadMoreEvent>(_onProjectListLoadMoreEvent);
  }

  void _onInitialProjectListEvent(InitialProjectListingEvent event, Emitter<ProjectListingState> emit) {
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(ProjectListLoadMoreEvent(currentPage));
      },
    );
    clearData();
    emit(ProjectListingLoadedState());
  }

  void clearData() {
    projectSearchController.clear();
    projectList = _generateProjectList();
  }

  Future<void> _onProjectListLoadMoreEvent(ProjectListLoadMoreEvent event, Emitter<ProjectListingState> emit) async {
    emit(const ProjectListLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    projectList.addAll(_generateProjectList());
    paginationScrollController.isPageLoaded.complete(event.currentPage == 3);
    emit(ProjectListLoadedMoreState(event.currentPage + 1));
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }

  static List<B2BCustomListingDataModel> _generateProjectList() {
    return List.generate(10, (index) {
      return B2BCustomListingDataModel(
        id: index.toString(),
        strProjectNumber: '1254875',
        strDesign: '1',
        strProjectName: 'Full blue moon',
        status: OrderStatus.active,
        strCustomer: 'Jenny Wilson',
        strCustomerImageUrl: 'https://i.ibb.co/hy6pH4g/Frame-3977.png',
        holdStatus: OrderStatus.onGoing,
        strCreatedOn: '23/03/2023, 10:46',
        strCreatedBy: 'Jenny Wilson',
        strCreatedByImageUrl: 'https://i.ibb.co/BLyLVHS/Frame-3978.png',
      );
    });
  }
}
