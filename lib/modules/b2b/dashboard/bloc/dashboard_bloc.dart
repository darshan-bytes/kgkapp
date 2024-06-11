import 'package:kgk/kgk.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  ///[currentIndex] is used to keep track of the current index of the bottom navigation bar
  int currentIndex = 0;

  ///[pages] is a list of widgets that will be displayed on the screen based on the current index
  final List<Widget> pages = [
    const HomeScreen(),
    const CategoriesScreen(),
    const MyBagScreen(),
    const SupportScreen(),
    const ProfileScreen(),
  ];

  ///[blocList] is a list of blocs that are used in the bottom navigation bar and used for performing
  /// actions on the screen based on the current index
  final List<Bloc> blocList = [
    BlocProvider.of<HomeBloc>(getNavigatorKeyContext),
    BlocProvider.of<CategoriesBloc>(getNavigatorKeyContext),
    BlocProvider.of<MyBagBloc>(getNavigatorKeyContext),
    BlocProvider.of<SupportBloc>(getNavigatorKeyContext),
    BlocProvider.of<ProfileBloc>(getNavigatorKeyContext),
  ];

  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardChangeTabEvent>(_onDashboardChangeTabEvent);
  }

  ///[_onDashboardChangeTabEvent] is a method that is called when the [DashboardChangeTabEvent] is dispatched
  /// to the bloc and it changes  the current index of the bottom navigation bar and emits the
  /// [DashboardChangeTabState] with the new index to the UI.
  void _onDashboardChangeTabEvent(
    DashboardChangeTabEvent event,
    Emitter<DashboardState> emit,
  ) {
    if (currentIndex != event.index) {
      currentIndex = event.index;
      switch (event.index) {
        case 2:
          blocList[currentIndex].add(InitialMyBagEvent());
          break;
      }
      emit(DashboardChangeTabState(event.index));
    }
  }
}
