import 'package:kgk/kgk.dart';

part 'compare_product_event.dart';

part 'compare_product_state.dart';

class CompareProductBloc extends Bloc<CompareProductEvent, CompareProductState> {
  CompareProductBloc() : super(CompareProductInitial()) {
    on<CompareProductEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  Map<int, FixedColumnWidth> generateTableColumnWidths(int length, double width) {
    Map<int, FixedColumnWidth> columnWidths = {};
    for (int i = 0; i < length; i++) {
      columnWidths[i] = FixedColumnWidth(width);
    }
    return columnWidths;
  }
}
