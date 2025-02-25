import 'package:kgk/kgk.dart';

part 'compare_product_event.dart';

part 'compare_product_state.dart';

class CompareProductBloc extends Bloc<CompareProductEvent, CompareProductState> {
  MyBagBloc? myBagBloc;
  Commodity? commodity;
  String? jewelleryType;
  List<FilterOptionModel> filterList = [];
  final List<ProductDetailsModel> productList = [];
  final List<String> productIdList = [];
  List<Map<String, dynamic>> compareResult = [];

  bool _isInitialized = false;

  CompareProductBloc() : super(CompareProductInitial()) {
    on<CompareProductAddProductEvent>(_onCompareProductAddProduct);
    on<CompareProductRemoveProductEvent>(_onCompareProductRemoveProduct);
    on<CompareProductClearEvent>(_onCompareProductClear);
    on<CompareProductGenerateTableEvent>(_onCompareProductGenerateTable);
  }

  /// Generates a map of column widths for a table
  Map<int, FixedColumnWidth> generateTableColumnWidths(int length, double width) =>
      {for (int i = 0; i < length; i++) i: FixedColumnWidth(width)};

  /// Handles adding a product to the comparison list
  Future<void> _onCompareProductAddProduct(CompareProductAddProductEvent event, Emitter<CompareProductState> emit) async {
    // Initialize the commodity if null
    Commodity productCommodity = event.product.commodity ?? Commodity.jewellery;
    if (commodity == null) {
      commodity ??= productCommodity;
      filterList = await BlocProvider.of<AppBloc>(event.context).getFilterOptionList(event.context, commodity?.value ?? '');
    }

    bool isDisplayError = commodity != productCommodity;
    if (!isDisplayError && (commodity == Commodity.jewellery)) {
      jewelleryType ??= event.product.jewelleryType;
      isDisplayError = jewelleryType != event.product.jewelleryType;
    }
    // Handle different commodities case
    if (isDisplayError) {
      final result = await Utils.showSmartModalBottomSheet(
        context: event.context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        ),
        builder: (context) => ConfirmationDialog(
          title: APPStrings.differentCommoditiesSelected.tr,
          message: APPStrings.cantCompareDifferentCommodities.tr,
          onApproved: () => context.pop(arguments: {RoutesData.isContinueClearCompare: true}),
          onDenied: () => context.pop(),
          onApprovedText: APPStrings.strContinue.tr,
          onDeniedText: APPStrings.cancel.tr,
        ),
      );

      if (result?[RoutesData.isContinueClearCompare] == true) {
        commodity = productCommodity;
        jewelleryType = event.product.jewelleryType;
        filterList = await BlocProvider.of<AppBloc>(event.context).getFilterOptionList(event.context, commodity?.value ?? '');
        productIdList.clear();
      } else {
        return;
      }
    }

    // Add the product if not already present
    if (event.product.productId.isNotNullNorEmpty && !productIdList.contains(event.product.productId)) {
      productIdList.add(event.product.productId!); // Add product explicitly
      productList.add(event.product); // Add product to the list
      emit(CompareProductReloadState());
      emit(CompareProductAddedState(productIdList: List.unmodifiable(productIdList)));
    }
  }

  /// Handles removing a product from the comparison list
  void _onCompareProductRemoveProduct(CompareProductRemoveProductEvent event, Emitter<CompareProductState> emit) {
    int index = productIdList.indexOf(event.productId);
    if (index > -1) {
      productIdList.removeAt(index);
      productList.removeAt(index);
      if (compareResult.isNotEmpty) {
        compareResult.removeAt(index);
      }
      emit(CompareProductReloadState());
      emit(CompareProductAddedState(productIdList: List.unmodifiable(productIdList)));
      if (event.isFromCompareScreen) {
        if (productIdList.isNotEmpty) {
          emit(CompareProductsLoadedState());
        } else {
          event.context.pop();
        }
      }
    }
  }

  /// Clears all products from the comparison list
  void _onCompareProductClear(CompareProductClearEvent event, Emitter<CompareProductState> emit) {
    productIdList.clear();
    emit(CompareProductReloadState());
    emit(CompareProductAddedState(productIdList: List.unmodifiable(productIdList)));
  }

  /// Stub for table generation logic
  Future<void> _onCompareProductGenerateTable(CompareProductGenerateTableEvent event, Emitter<CompareProductState> emit) async {
    if (_isInitialized) return;
    _isInitialized = true;
    emit(CompareProductLoadingState());

    if (StorageManager().getIsSkipLogin()) {
      myBagBloc ??= BlocProvider.of<MyBagBloc>(event.context);
      if (myBagBloc != null && (myBagBloc!.commodity == null || myBagBloc!.commodity == commodity)) {
        myBagBloc!.add(InitialMyBagEvent(context: event.context));
        await for (final state in myBagBloc!.stream) {
          if (state is MyBagLoadedState) {
            break;
          }
        }
      }
    }

    try {
      final Map<String, dynamic> body = {
        ApiKey.products: productIdList.map((e) => {ApiKey.id: e, ApiKey.collectionType: commodity?.value}).toList(),
      };

      final response = await AppRepository(event.context).compareProducts(body: body);
      response?.fold(
        (l) {
          emit(CompareProductErrorState(message: l.message ?? ''));
        },
        (r) {
          compareResult = r;
          for (int i = 0; i < compareResult.length; i++) {
            if (StorageManager().getIsSkipLogin()) {
              productList[i].isAddedToCart =
                  myBagBloc?.bagListDataModel?.result.map((e) => e.suid).toList().contains(productList[i].suid) ?? false;
            } else {
              productList[i].isAddedToCart = compareResult[i][ApiKey.isAddedToCart] ?? false;
            }
          }
          emit(CompareProductsLoadedState());
        },
      );
    } catch (e) {
      emit(CompareProductErrorState(message: e.toString()));
    }
  }

  void setInitialized(bool bool) {
    _isInitialized = bool;
  }

  void handleBagButtonClick(BuildContext context, int index) {
    if (!productList[index].isAddedToCart) {
      BlocProvider.of<AppBloc>(context).onTapBag(context, productDetails: productList[index]);
      productList[index].isAddedToCart = true;
    } else {
      BlocProvider.of<LandingBloc>(context).add(LandingChangeTabEvent(LandingBloc.myBagIndex, context: context));
      context.popUntil((route) => route.settings.name == AppRoutes.landingPage);
    }
  }
}
