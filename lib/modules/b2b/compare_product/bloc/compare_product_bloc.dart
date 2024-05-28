import 'package:kgk/kgk.dart';

part 'compare_product_event.dart';

part 'compare_product_state.dart';

class CompareProductBloc extends Bloc<CompareProductEvent, CompareProductState> {
  CompareProductBloc() : super(CompareProductInitial()) {
    on<CompareProductEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
