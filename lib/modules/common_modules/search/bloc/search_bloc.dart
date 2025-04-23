import 'package:kgk/kgk.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final TextEditingController searchController = TextEditingController();

  //Popular Search
  List<String> popularSearchList = [];

  //Recent Search
  List<String> recentSearchList = [];

  // Search by category  + Here use random model for demo
  List<AuctionListModel> searchByCategoryList = [];

  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>(_onInitialSearchEvent);
  }

  void _onInitialSearchEvent(SearchEvent event, Emitter<SearchState> emit) {
    emit(SearchReloadState());
    searchController.clear();
    popularSearchList = ['Diamond Rings', 'Yellow Diamond', 'Diamond Necklace', 'Colored Diamond', 'Diamond Bracelet'];

    recentSearchList = ['Diamond Rings', 'Yellow Diamond', 'Diamond Necklace ', 'Colored Diamond', 'Diamond Bracelet  ', 'Diamond Rounds'];

    List.generate(20, (index) {
      List<String> nameList = ["Necklace", "Earrings", "Ring", "Bracelet", "Pendant"];
      List<String> imageList = [
        "https://i.ibb.co/5jmqMcF/image-18654.png",
        "https://i.ibb.co/vBG9fzy/image-18655.png",
        "https://i.ibb.co/9wyrwGQ/Image.png",
        "https://i.ibb.co/D4kHrXY/image-18652.jpg",
      ];
      searchByCategoryList.add(
        AuctionListModel(
          id: index.toString(),
          name: nameList[Random().nextInt(nameList.length)],
          imageUrl: imageList[Random().nextInt(imageList.length)],
        ),
      );
    });

    emit(SearchInitial());
  }
}
