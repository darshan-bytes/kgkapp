import 'package:kgk/kgk.dart';

part 'concept_list_event.dart';

part 'concept_list_state.dart';

class ConceptListBloc extends Bloc<ConceptListEvent, ConceptListState> {
  List<B2BCustomListingDataModel> conceptList = [];
  TextEditingController searchController = TextEditingController();

  ConceptListBloc() : super(ConceptListInitial()) {
    on<ConceptListInitialEvent>(_onConceptListInitialEvent);
    on<ConceptListSearchEvent>(_onConceptListSearchEvent);
  }

  void _onConceptListInitialEvent(ConceptListInitialEvent event, Emitter<ConceptListState> emit) {
    emit(ConceptListReloadState());

    conceptList = List.generate(
      20,
      (index) => B2BCustomListingDataModel(
        id: index.toString(),
        strConceptNumber: '14567',
        strPresentation: '1',
        strConceptName: 'Concept Name',
        status: OrderStatus.inProgress,
        strAssignTo: 'Jenny Wilson',
        strAssignToImageUrl: 'https://i.ibb.co/BLyLVHS/Frame-3978.png',
        strMarket: 'New York, USA',
        strMarketFlagImageUrl: 'https://i.ibb.co/wYmW2ht/United-States-of-America-US.png',
        strCreatedBy: 'Jenny Wilson',
        strCreatedByImageUrl: 'https://i.ibb.co/hy6pH4g/Frame-3977.png',
        strCreatedOn: '23/03/2023, 10:46',
      ),
    );

    emit(const ConceptListLoadedState());
  }

  void _onConceptListSearchEvent(ConceptListSearchEvent event, Emitter<ConceptListState> emit) {
    //TODO: Implement search logic
  }
}
