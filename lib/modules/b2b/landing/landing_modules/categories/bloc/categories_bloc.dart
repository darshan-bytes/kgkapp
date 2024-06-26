import 'package:kgk/kgk.dart';

part 'categories_event.dart';

part 'categories_state.dart';

enum ArrowPosition { leftTop, centerTop, rightTop }

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  int? selectedRowIndex;
  int? selectedItemIndex;
  ArrowPosition arrowPosition = ArrowPosition.rightTop;

  ScrollController scrollController = ScrollController();

  List<CategoriesModel> categories = [
    CategoriesModel(
      name: 'Natural \nDiamonds',
      image: 'https://i.ibb.co/HgjT1rt/Image.png',
    ),
    CategoriesModel(name: 'Lab-grown \nDiamonds', image: 'https://i.ibb.co/ZWKWks5/Image.png'),
    CategoriesModel(name: 'Gemstone', image: 'https://i.ibb.co/HgjT1rt/Image.png'),
    CategoriesModel(name: 'Jewellery', image: 'https://i.ibb.co/ZWKWks5/Image.png'),
    CategoriesModel(name: 'Do It \nYourself', image: 'https://i.ibb.co/HgjT1rt/Image.png'),
    CategoriesModel(name: 'About Us', image: 'https://i.ibb.co/ZWKWks5/Image.png'),
    CategoriesModel(name: 'PDD', image: 'https://i.ibb.co/HgjT1rt/Image.png'),
    CategoriesModel(name: 'Project', image: 'https://i.ibb.co/ZWKWks5/Image.png'),
    CategoriesModel(name: 'Design', image: 'https://i.ibb.co/ZWKWks5/Image.png'),
  ];

  List<String> productsDetailsList = ['Collection', 'Best Selling', 'Seasonal Offers', 'Occasion Offer', 'Deals'];

  CategoriesBloc() : super(CategoriesInitial()) {
    on<CategoriesSelectedEvent>(onCategoriesSelectedEvent);
  }

  void onCategoriesSelectedEvent(CategoriesSelectedEvent event, Emitter<CategoriesState> emit) {
    emit(CategoriesReloaded());

    if (selectedRowIndex == event.index && selectedItemIndex == event.itemIndex) {
      selectedRowIndex = -1;
      selectedItemIndex = -1;
    } else {
      selectedRowIndex = event.index;
      selectedItemIndex = event.itemIndex;
    }

    if (event.itemIndex == 0) {
      arrowPosition = ArrowPosition.leftTop;
    } else if (event.itemIndex == 1) {
      arrowPosition = ArrowPosition.centerTop;
    } else if (event.itemIndex == 2) {
      arrowPosition = ArrowPosition.rightTop;
    }

    emit(CategoriesSelected());
  }
}
