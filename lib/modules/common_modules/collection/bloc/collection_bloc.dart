import 'package:kgk/kgk.dart';

part 'collection_event.dart';

part 'collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  bool _isInitialised = false;
  List<CollectionDataModel> collectionMasterList = [];

  CollectionBloc() : super(CollectionInitial()) {
    on<CollectionInitialEvent>(_onInitialEvent);
  }

  Future<void> _onInitialEvent(CollectionInitialEvent event, Emitter<CollectionState> emit) async {
    if (_isInitialised) {
      return;
    }
    _isInitialised = true;
    emit(CollectionReloadState());
    Either<ErrorResponse, List<CollectionDataModel>>? response = await AppRepository(event.context).collectionMasterList();
    response?.fold((l) {
      Utils.showMessage(l.message);
    }, (r) {
      if (r.isNotNullNorEmpty) {
        collectionMasterList = r;
      }
    });
    emit(CollectionMasterListLoadedState());
  }

  void navigateToJewelleryListingScreen({required String collectionName, required BuildContext context}) {
    context.pushNamed(AppRoutes.productListGridPage,
        arguments: {RoutesData.isPageFor: ScreenIdentifier.productForRing, RoutesData.collectionName: collectionName});
  }
}
