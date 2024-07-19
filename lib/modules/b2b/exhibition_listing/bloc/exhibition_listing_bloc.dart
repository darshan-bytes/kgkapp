import 'package:kgk/kgk.dart';

part 'exhibition_listing_event.dart';

part 'exhibition_listing_state.dart';

class ExhibitionListingBloc extends Bloc<ExhibitionListingEvent, ExhibitionListingState> {
  List<ExhibitionListingModel> exhibitionCatalogueList = [];

  List<ExhibitionListingModel> exhibitionNameListing = [];

  List<ExhibitionSubListingModel> exhibitionSubList = _generateSubList();

  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  ExhibitionListingBloc() : super(ExhibitionListingInitialState()) {
    on<InitialExhibitionListingEvent>(_onInitialExhibitionListingEvent);
  }

  void _onInitialExhibitionListingEvent(InitialExhibitionListingEvent event, Emitter<ExhibitionListingState> emit) {
    if (paginationScrollController.isInitialised) {
      paginationScrollController.dispose();
      paginationScrollController = SmartPaginationScrollController();
    }
    paginationScrollController.init(loadAction: (int currentPage) {});
    exhibitionCatalogueList = List.generate(10, (index) {
      return ExhibitionListingModel(
          image: 'https://i.ibb.co/GdZM7Ht/Rectangle-637.png',
          name: 'Bridal Jewellery Collections Exhibition',
          author: 'by Martin Flyer',
          date: '25 - 28 Jul, 2023',
          time: '10 AM - 10 PM',
          status: 'Ongoing',
          location: 'D.K Patel Hall, Ahmedabad',
          onTap: () {},
          id: index.toString());
    });

    exhibitionNameListing = [
      ExhibitionListingModel(
        title: 'Exhibitions in India',
        exhibitionSubList: _generateSubList(),
      ),
      ExhibitionListingModel(
        title: 'Exhibitions in Ahmedabad',
        exhibitionSubList: _generateUpcomingSubList(),
      ),
      ExhibitionListingModel(
        title: 'Exhibitions in Vadodara',
        exhibitionSubList: _generateUpcomingSubList(),
      ),
    ];

    emit(ExhibitionListingLoadedState());
  }

  static List<ExhibitionSubListingModel> _generateSubList() {
    return List.generate(4, (index) {
      return ExhibitionSubListingModel(
        name: 'Engagement Rings Collections',
        author: 'by Martin Flyer',
        status: 'Ongoing',
        id: index.toString(),
      );
    });
  }

  static List<ExhibitionSubListingModel> _generateUpcomingSubList() {
    return List.generate(4, (index) {
      return ExhibitionSubListingModel(
        name: 'Engagement Rings Collections $index',
        author: 'by Martin Flyer',
        status: 'Upcoming',
        id: index.toString(),
      );
    });
  }
}
