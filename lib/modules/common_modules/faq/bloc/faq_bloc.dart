import 'package:kgk/kgk.dart';

part 'faq_event.dart';

part 'faq_state.dart';

class FaqBloc extends Bloc<FaqEvent, FaqState> {
  final TextEditingController searchController = TextEditingController();
  List<FaqWrapper> faq = [];
  bool isLoading = true;

  FaqBloc() : super(FaqInitial()) {
    on<FaqInitialEvent>(_onInitialFaqListEvent);
  }

  Future<void> _onInitialFaqListEvent(FaqInitialEvent event, Emitter<FaqState> emit) async {
    faq.clear();
    await getFaqList(event.context);
    isLoading = false;
    emit(FaqLoadedState(faq));
  }

  Future<void> getFaqList(BuildContext context) async {
    await AppRepository(context).fetchStrapiFaqData().then((value) {
      value.fold((l) {
        Utils.showMessage(l.message);
      }, (r) {
        List<FaqData> faqStrapiList = r;
        List<Map<String, dynamic>> faqData = faqStrapiList.map((e) => e.toJson()).toList();
        List<FaqWrapper> faqWrappers = parseFaqs(faqData);
        faq.addAll(faqWrappers);
      });
    });
  }

  List<FaqWrapper> parseFaqs(List<Map<String, dynamic>> json) {
    Map<String, List<Map<String, dynamic>>> groupedFaqs = {};

    for (var item in json) {
      String title = item['title'] ?? 'General';
      groupedFaqs.putIfAbsent(title, () => []).add(item);
    }

    return groupedFaqs.entries.map((entry) => FaqWrapper.fromJson(entry.key, entry.value)).toList();
  }
}
