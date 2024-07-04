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
    digitalCatalogueList = List.generate(
      20,
      (index) {
        return DigitalCatalogueListingModel(
          id: index,
          name: index.remainder(2) == 0 ? 'Timeless radiance' : 'Gilded whispers',
          description: index.remainder(2) == 0
              ? 'Step  into a world of "Timeless Radiance" where elegance meets brilliance. Embrace the allure of exquisite jewelry that illuminates every moment with its captivating charm. Our carefully curated collection features shimmering diamonds, lustrous metals, and intricate designs, crafted to celebrate cherished memories and create enduring moments of beauty and splendor.'
              : 'Step into a world of "Gilded Whispers" where elegance meets brilliance. Embrace the allure of exquisite jewelry that illuminates every moment with its captivating charm. Our carefully curated collection features shimmering diamonds, lustrous metals, and intricate designs, crafted to celebrate cherished memories and create enduring moments of beauty and splendor.',
          image: index.remainder(2) == 0 ? 'https://i.ibb.co/8BMpdhW/Image.png' : 'https://i.ibb.co/n7SrRv7/Image.png',
          productCount: "32",
          date: "24/03/2023, 06:00 PM",
          isWebView: index.remainder(2) != 0,
          webUrl: index.remainder(2) != 0 ? 'https://www.kgkgroup.com/gemstones/' : null,
        );
      },
    );

    emit(const DigitalCatalogueLoadedState());
  }
}
