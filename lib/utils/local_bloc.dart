import 'package:kgk/kgk.dart';

class LocaleBloc extends Cubit<Locale> {
  LocaleBloc({required Locale initialLocale}) : super(initialLocale);

  void changeLocale(Locale newLocale) {
    emit(newLocale);
  }
}
