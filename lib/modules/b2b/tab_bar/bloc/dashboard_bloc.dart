import 'package:kgk/kgk.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  int currentIndex = 0;
  final List<Widget> pages = [
    const HomeScreen(),
    const CategoriesScreen(),
    const MyBagScreen(),
    const SupportScreen(),
    const ProfileScreen(),
  ];

  final blocList = [
    BlocProvider.of<HomeBloc>(getNavigatorKeyContext),
    BlocProvider.of<CategoriesBloc>(getNavigatorKeyContext),
    BlocProvider.of<MyBagBloc>(getNavigatorKeyContext),
    BlocProvider.of<SupportBloc>(getNavigatorKeyContext),
    BlocProvider.of<ProfileBloc>(getNavigatorKeyContext),
  ];

  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardChangeTabEvent>(_onDashboardChangeTabEvent);
  }

  void _onDashboardChangeTabEvent(DashboardChangeTabEvent event, Emitter<DashboardState> emit) {
    if (currentIndex != event.index) {
      currentIndex = event.index;
      emit(DashboardChangeTabState(event.index));
    }
  }
}
