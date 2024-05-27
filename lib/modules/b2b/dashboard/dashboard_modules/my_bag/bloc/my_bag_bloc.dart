import 'package:kgk/kgk.dart';

part 'my_bag_event.dart';
part 'my_bag_state.dart';

class MyBagBloc extends Bloc<MyBagEvent, MyBagState> {
  List<ProductDetails> myBagProductList = [];

  MyBagBloc() : super(MyBagInitial()) {
    on<InitialMyBagEvent>(_onInitialMyBagEvent);
  }

  void _onInitialMyBagEvent(InitialMyBagEvent event, Emitter<MyBagState> emit) {
    emit(MyBagReloadState());
    List.generate(
        8,
        (index) => myBagProductList.add(
              ProductDetails(
                diamond: "1.5 gram",
                gram: "1.5 gram",
                imageUrl:
                    "https://s3-alpha-sig.figma.com/img/9ebd/9517/705a51c9fc5153f1dfac36afd60d16c9?Expires=1717372800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=CEg00oBHot6FBC0S~Jgw7iEpQ8mNWZVdQNorFxVAef310QMk5wmJYsAJm6gNWbd9YG-WSLNPc6Q9MAPEeXz2BgYTWjrTnkQWPWCgxqJswcHGQHgnZxMZmXM96HnkylNG17Pg~WURYovysiTsZS8p7H35ha09xWKBhxQvFf8Y6I5pyO2QTiPF-xHyabnzy~6lzTJXnXrEbKli7InPVL0hXMn1EDrTSMr4BAh1y0oZYzz-VQWRuFRn7mmyBpOhrkUrBMucWnlfpB9F3rz72aAqE898LfJTKfdSILEP41fI-fVdASU9sAMhm6b9XPwXvt-VjcU0PqEdDuUh8sAgW2fDGw__",
                name: "2.00 Carat H VS1 Excellent Cut Round Diamond",
                originalPrice: "\$ 3,000",
              ),
            ));
    emit(MyBagInitial());
  }
}
