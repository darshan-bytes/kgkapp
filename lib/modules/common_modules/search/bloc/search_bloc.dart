import 'package:kgk/kgk.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final TextEditingController searchController = TextEditingController();

  //Popular Search
  List<String> popularSearchList = [];

  //Recent Search
  List<String> recentSearchList = [];

  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>(_onInitialSearchEvent);
  }

  void _onInitialSearchEvent(SearchEvent event, Emitter<SearchState> emit) {
    emit(SearchReloadState());
    searchController.clear();
    popularSearchList = [
      'Diamond Rings',
      'Yellow Diamond',
      'Diamond Necklace',
      'Colored Diamond',
      'Diamond Bracelet',
    ];

    recentSearchList = [
      'Diamond Rings',
      'Yellow Diamond',
      'Diamond Necklace ',
      'Colored Diamond',
      'Diamond Bracelet  ',
      'Diamond Rounds',
    ];

    emit(SearchInitial());
  }
}
