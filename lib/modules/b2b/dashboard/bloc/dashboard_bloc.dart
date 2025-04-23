import 'package:kgk/kgk.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  List<DashboardDateRangeDataModel> dateRangeList = [];
  DashboardDateRangeDataModel? selectedDateRange;

  List<DashboardStatisticsDataModel> statisticsList = [];

  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardInitialEvent>(_onDashboardInitialEvent);
    on<DashboardDateRangeChangeEvent>(_onDashboardDateRangeChangeEvent);
  }

  void _onDashboardInitialEvent(DashboardInitialEvent event, Emitter<DashboardState> emit) {
    emit(const DashboardReloadState());
    dateRangeList = [
      DashboardDateRangeDataModel(title: 'Today', id: 1),
      DashboardDateRangeDataModel(title: 'Yesterday', id: 2),
      DashboardDateRangeDataModel(title: 'Last 7 days', id: 3),
      DashboardDateRangeDataModel(title: 'Last 30 days', id: 4),
      DashboardDateRangeDataModel(title: 'This month', id: 5),
      DashboardDateRangeDataModel(title: 'Last month', id: 6),
      DashboardDateRangeDataModel(title: 'Last 1 year', id: 7),
    ];
    selectedDateRange = dateRangeList.first;

    statisticsList = [
      DashboardStatisticsDataModel(
        title: 'Total purchase',
        value: '\$83,000.00',
        subTitle: '+\$1,000.00 today',
        variation: '12%',
        isNegative: true,
      ),
      DashboardStatisticsDataModel(title: 'Orders received', value: '4587', subTitle: '+124 today', variation: '6%', isNegative: true),
      DashboardStatisticsDataModel(title: 'Total sell', value: '\$97,451.00', subTitle: '+\$1,578.00 today', variation: '5%'),
      DashboardStatisticsDataModel(title: 'Lead conversion', value: '654', subTitle: '+8 today', variation: '2%'),
      DashboardStatisticsDataModel(title: 'Total due amount', value: '\$30,547.00', subTitle: '+\$1,985.00 today', variation: '6%'),
    ];
    emit(const DashboardLoadedState());
  }

  void _onDashboardDateRangeChangeEvent(DashboardDateRangeChangeEvent event, Emitter<DashboardState> emit) {
    emit(const DashboardReloadState());
    selectedDateRange = event.dateRange;
    emit(const DashboardDateRangeChangeState());
  }
}
