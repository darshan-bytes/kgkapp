import 'package:kgk/kgk.dart';

part 'digital_catalogue_event.dart';

part 'digital_catalogue_state.dart';

class DigitalCatalogueBloc extends Bloc<DigitalCatalogueEvent, DigitalCatalogueState> {
  List<DigitalCatalogueListingModel> digitalCatalogueList = [];

  DigitalCatalogueBloc() : super(DigitalCatalogueIntial()) {
    on<DigitalCatalogueInitialEvent>(_onDashboardInitialEvent);
  }

  void _onDashboardInitialEvent(DigitalCatalogueInitialEvent event, Emitter<DigitalCatalogueState> emit) {
    emit(const DigitalCatalogueReloadState());
    digitalCatalogueList = List.generate(20, (index) {
      return DigitalCatalogueListingModel(
          image: 'https://i.ibb.co/P5w4MHq/Banner.png',
          name: 'Timeless radiance',
          productCount: "32",
          date: "24/03/2023, 06:00 PM",
          id: index);
    });

    emit(const DigitalCatalogueLoadedState());
  }
}
