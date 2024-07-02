import 'package:kgk/kgk.dart';

part 'exhibition_listing_event.dart';

part 'exhibition_listing_state.dart';

class ExhibitionListingBloc extends Bloc<ExhibitionListingEvent, ExhibitionListingState> {
  List<ExhibitionListingModel> exhibitionCatalogueList = [];

  List<ExhibitionListingModel> exhibitionNameListing = [];

  List<ExhibitionListingModel> exhibitionSubList = _generateSubList();

  ExhibitionListingBloc() : super(ExhibitionListingInitialState()) {
    on<InitialExhibitionListingEvent>(_onInitialExhibitionListingEvent);
  }

  void _onInitialExhibitionListingEvent(InitialExhibitionListingEvent event, Emitter<ExhibitionListingState> emit) {
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
        exhibitionSubList: _generateSubList(),
      ),
      ExhibitionListingModel(
        title: 'Exhibitions in Vadodara',
        exhibitionSubList: _generateSubList(),
      ),
    ];

    emit(ExhibitionListingLoadedState());
  }

  static List<ExhibitionListingModel> _generateSubList() {
    return List.generate(4, (index) {
      return ExhibitionListingModel(
        name: 'Engagement Rings Collections',
        author: 'by Martin Flyer',
        status: 'Ongoing',
        id: index.toString(),
      );
    });
  }
}
