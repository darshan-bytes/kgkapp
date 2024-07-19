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

  Completer<bool> refreshCompleter = Completer<bool>();

  ProjectListingBloc() : super(ProjectListingInitial()) {
    on<InitialProjectListingEvent>(_onInitialProjectListEvent);
    on<ProjectListLoadMoreEvent>(_onProjectListLoadMoreEvent);
    on<ProjectListPullToRefreshEvent>(_onProjectListPullToRefresh);
  }

  void _onInitialProjectListEvent(InitialProjectListingEvent event, Emitter<ProjectListingState> emit) {
    if (paginationScrollController.isInitialised) {
      paginationScrollController.dispose();
      paginationScrollController = SmartPaginationScrollController();
    }
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(ProjectListLoadMoreEvent(currentPage));
      },
    );

    if (!refreshCompleter.isCompleted) {
      refreshCompleter.complete(true);
    }

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
        status: ProjectStatus.blueInProgress,
        strCustomer: 'Jenny Wilson',
        strCustomerImageUrl: 'https://i.ibb.co/hy6pH4g/Frame-3977.png',
        holdStatus: ProjectStatus.released,
        strCreatedOn: '23/03/2023, 10:46',
        strCreatedBy: 'Jenny Wilson',
        strCreatedByImageUrl: 'https://i.ibb.co/BLyLVHS/Frame-3978.png',
      );
    });
  }

  Future<void> _onProjectListPullToRefresh(ProjectListPullToRefreshEvent event, Emitter<ProjectListingState> emit) async {
    await Future.delayed(const Duration(seconds: 1));
    paginationScrollController.pullToRefresh();
    projectList = _generateProjectList();
    refreshCompleter.complete(true);
    emit(ProjectListingLoadedState());
  }

  Future<bool> pullToRefresh() async {
    if (!refreshCompleter.isCompleted) {
      return false;
    }
    refreshCompleter = Completer<bool>();
    add(const ProjectListPullToRefreshEvent());
    bool result = await refreshCompleter.future;
    return result;
  }
}
