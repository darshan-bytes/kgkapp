import 'package:kgk/kgk.dart';

part 'product_list_grid_event.dart';

part 'product_list_grid_state.dart';

class ProductListGridBloc extends Bloc<ProductListGridEvent, ProductListGridState> {
  // List of numbers for the dropdown
  List<String> pageNumbers = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10'];

  // The selected number of pages, initialized to the first item
  String selectedPageNumber = '01';

  ProductListGridBloc() : super(ProductListGridInitial()) {
    on<ChangePageNumberEvent>(onPageNumberChanged);
  }

  void onPageNumberChanged(ChangePageNumberEvent event, Emitter<ProductListGridState> emit) {
    emit(ReloadProductState());
    selectedPageNumber = event.pageNumber;
    emit(ChangePageNumberState());
  }
}
