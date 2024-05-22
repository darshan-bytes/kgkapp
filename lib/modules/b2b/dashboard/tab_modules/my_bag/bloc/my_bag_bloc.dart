import 'package:kgk/kgk.dart';

part 'my_bag_event.dart';
part 'my_bag_state.dart';

class MyBagBloc extends Bloc<MyBagEvent, MyBagState> {
  MyBagBloc() : super(MyBagInitial()) {
    on<MyBagEvent>((event, emit) {});
  }
}
