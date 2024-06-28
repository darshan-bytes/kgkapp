import 'package:kgk/kgk.dart';

part 'digital_catalogue_event.dart';

part 'digital_catalogue_state.dart';

class DigitalCatalogueBloc
    extends Bloc<DigitalCatalogueEvent, DigitalCatalogueState> {
  List<DigitalCatalogueListingModel> digitalCatalogueList = [];

  DigitalCatalogueBloc() : super(DigitalCatalogueIntial()) {
    on<DigitalCatalogueInitialEvent>(_onDashboardInitialEvent);
  }

  void _onDashboardInitialEvent(
      DigitalCatalogueInitialEvent event, Emitter<DigitalCatalogueState> emit) {
    emit(const DigitalCatalogueReloadState());
    digitalCatalogueList = [
      DigitalCatalogueListingModel(
          image: 'https://i.ibb.co/P5w4MHq/Banner.png',
          name: 'Timeless radiance',
          productCount: "32",
          date: "24/03/2023, 06:00 PM",
          id: 1),
      DigitalCatalogueListingModel(
          image: 'https://i.ibb.co/P5w4MHq/Banner.png',
          name: 'Gilded whispers',
          productCount: "32",
          date: "24/03/2023, 06:00 PM",
          id: 2),
      DigitalCatalogueListingModel(
          image: 'https://i.ibb.co/P5w4MHq/Banner.png',
          name: 'Enchanted blooms',
          productCount: "32",
          date: "24/03/2023, 06:00 PM",
          id: 3),
      DigitalCatalogueListingModel(
          image: 'https://i.ibb.co/P5w4MHq/Banner.png',
          name: 'Timeless radiance',
          productCount: "32",
          date: "24/03/2023, 06:00 PM",
          id: 4),
      DigitalCatalogueListingModel(
          image: 'https://i.ibb.co/P5w4MHq/Banner.png',
          name: 'Timeless radiance',
          productCount: "32",
          date: "24/03/2023, 06:00 PM",
          id: 5),
      DigitalCatalogueListingModel(
          image: 'https://i.ibb.co/P5w4MHq/Banner.png',
          name: 'Gilded whispers',
          productCount: "32",
          date: "24/03/2023, 06:00 PM",
          id: 6),
      DigitalCatalogueListingModel(
          image: 'https://i.ibb.co/P5w4MHq/Banner.png',
          name: 'Enchanted blooms',
          productCount: "32",
          date: "24/03/2023, 06:00 PM",
          id: 7),
      DigitalCatalogueListingModel(
          image: 'https://i.ibb.co/P5w4MHq/Banner.png',
          name: 'Timeless radiance',
          productCount: "32",
          date: "24/03/2023, 06:00 PM",
          id: 8),
      DigitalCatalogueListingModel(
          image: 'https://i.ibb.co/P5w4MHq/Banner.png',
          name: 'Timeless radiance',
          productCount: "32",
          date: "24/03/2023, 06:00 PM",
          id: 9),
      DigitalCatalogueListingModel(
          image: 'https://i.ibb.co/P5w4MHq/Banner.png',
          name: 'Enchanted blooms',
          productCount: "32",
          date: "24/03/2023, 06:00 PM",
          id: 10),
    ];

    emit(const DigitalCatalogueLoadedState());
  }
}
