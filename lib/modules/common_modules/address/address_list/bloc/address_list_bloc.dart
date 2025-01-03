import 'package:kgk/kgk.dart';

part 'address_list_event.dart';

part 'address_list_state.dart';

class AddressListBloc extends Bloc<AddressListEvent, AddressListState> {
  AddressListBloc() : super(AddressListInitial()) {
    on<LoadAddressListEvent>(_onLoadAddressListEvent);
    on<ChangeSelectedAddressEvent>(_onChangeSelectedAddressEvent);
    on<DeleteAddressEvent>(_onDeleteAddressEvent);
    on<EditAddressEvent>(_onEditAddressEvent);
    on<AddNewAddressEvent>(_onAddNewAddressEvent);
    on<ToggleBillingAndShippingSameEvent>(_onToggleBillingAndShippingSameEvent);
    on<ChangeProductListExpansionEvent>(_onChangeProductListExpansionEvent);
    on<ContinueToPaymentEvent>(_onContinueToPayment);
    on<OrderSummaryDataRefreshEvent>(_onOrderSummaryDataRefreshEvent);
  }

  late AppBloc appBloc;
  UserType userType = UserType.b2cUser;

  GlobalKey<SmartExpansionTileState> productsListExpansionKey = GlobalKey();

  bool isProductListExpanded = false;

  AddressDetails? selectedShippingAddress;
  AddressDetails? selectedBillingAddress;
  List<AddressDetails> addressList = [];

  bool isBillingAndShippingSame = true;

  BagOrderSummaryDataModel? bagOrderSummaryData;

  Future<void> _onLoadAddressListEvent(LoadAddressListEvent event, Emitter<AddressListState> emit) async {
    emit(const AddressListReloadState());
    appBloc = BlocProvider.of<AppBloc>(event.context);
    userType = appBloc.userType;
    await appBloc.fetchAddressList(event.context, isForceFetch: true);
    addressList = appBloc.savedAddressList;
    selectedShippingAddress = addressList.firstWhereOrNull((element) => element.isDefaultShipping) ?? addressList.firstOrNull;
    selectedBillingAddress = addressList.firstWhereOrNull((element) => element.isDefaultBilling) ?? addressList.firstOrNull;
    isBillingAndShippingSame = selectedShippingAddress == selectedBillingAddress;
    fetchOrderSummaryDataFromMyBagBloc(event.context);
    emit(AddressListLoadedState(addressList, selectedShippingAddress, selectedBillingAddress, isBillingAndShippingSame));
  }

  void _onChangeSelectedAddressEvent(ChangeSelectedAddressEvent event, Emitter<AddressListState> emit) {
    AddressDetails? selectedAddress = event.isBilling ? selectedBillingAddress : selectedShippingAddress;
    int oldIndex = addressList.indexOf(selectedAddress ?? AddressDetails());
    if (event.isBilling) {
      selectedBillingAddress = addressList[event.index];
    } else {
      selectedShippingAddress = addressList[event.index];
      if (isBillingAndShippingSame) {
        selectedBillingAddress = selectedShippingAddress;
      }
    }
    emit(ChangeSelectedAddressState(event.index, oldIndex, isBilling: event.isBilling));
  }

  Future<void> _onDeleteAddressEvent(DeleteAddressEvent event, Emitter<AddressListState> emit) async {
    emit(const AddressListReloadState());

    AddressDetails address = addressList[event.index];

    final response = await AppRepository(event.context).deleteAddress(address.id ?? '');
    response?.fold(
      (l) {
        Utils.showMessage(l.message);
      },
      (r) {
        if (selectedShippingAddress == address && addressList.length > 1 && event.index != 0) {
          selectedShippingAddress = addressList.first;
        }
        if (selectedBillingAddress == address && addressList.length > 1 && event.index != 0) {
          selectedBillingAddress = addressList.first;
        }
        addressList.removeAt(event.index);
        emit(AddressListLoadedState(addressList, selectedShippingAddress, selectedBillingAddress, isBillingAndShippingSame));
      },
    );

    emit(const DeleteAddressState());
  }

  Future<void> _onEditAddressEvent(EditAddressEvent event, Emitter<AddressListState> emit) async {
    await event.context.pushNamed(AppRoutes.addAddressPage, arguments: {RoutesData.addressDetails: addressList[event.index]}).then(
      (value) {
        if (value != null) {
          try {
            AddressDetails? addressDetails = value[RoutesData.addressDetails];

            if (addressDetails != null) {
              addressList[event.index] = addressDetails;
            }
            selectedShippingAddress = addressList[event.index];
            if (isBillingAndShippingSame) {
              selectedBillingAddress = addressList[event.index];
            }
            emit(AddressListLoadedState(addressList, selectedShippingAddress, selectedBillingAddress, isBillingAndShippingSame));
          } catch (e) {
            printWrapped('Error in updating address: $e');
          }
        }
      },
    );
  }

  Future<void> _onAddNewAddressEvent(AddNewAddressEvent event, Emitter<AddressListState> emit) async {
    final Map<RoutesData, dynamic>? result =
        await event.context.pushNamed(AppRoutes.addAddressPage, arguments: {RoutesData.isFromCheckout: true});
    if (result != null && result.containsKey(RoutesData.addressDetails) && result[RoutesData.addressDetails] is AddressDetails) {
      AddressDetails addressDetails = result[RoutesData.addressDetails];
      addressList.add(addressDetails);
      selectedShippingAddress = addressDetails;
      emit(AddNewAddressState(addressDetails));
    }
  }

  void _onToggleBillingAndShippingSameEvent(ToggleBillingAndShippingSameEvent event, Emitter<AddressListState> emit) {
    isBillingAndShippingSame = !isBillingAndShippingSame;
    if (isBillingAndShippingSame) {
      selectedBillingAddress = selectedShippingAddress;
    } else {
      selectedBillingAddress = addressList.firstWhereOrNull((e) => e.isDefaultBilling) ?? addressList.firstOrNull;
    }
    emit(ToggleBillingAndShippingSameState(isBillingAndShippingSame));
  }

  void _onChangeProductListExpansionEvent(ChangeProductListExpansionEvent event, Emitter<AddressListState> emit) {
    isProductListExpanded = !isProductListExpanded;
    emit(ChangeProductListExpansionState(isProductListExpanded));
  }

  Future<void> _onContinueToPayment(ContinueToPaymentEvent event, Emitter<AddressListState> emit) async {
    try {
      final Map<String, dynamic> body = {
        ApiKey.isShippingAddress: selectedShippingAddress?.id,
        ApiKey.isBillingAddress: selectedBillingAddress?.id,
      };

      final response = await AppRepository(event.context).bagUserAddress(body);

      await response?.fold(
        (l) {
          Utils.showMessage(l.message);
        },
        (r) async {
          //TODO: Place order API
          // Below line is commented because the Payment flow is not yet available from the backend side.
          // event.context.pushNamed(AppRoutes.paymentPage);
          if (userType == UserType.b2cUser) {
            await placeIndividualOrderAPI(event.context);
          } else {
            await placeB2BUserOrderAPI(event.context);
          }
        },
      );
    } catch (e) {
      Utils.showMessage(e.toString());
    }
  }

  Future<void> placeIndividualOrderAPI(BuildContext context) async {
    final Either<ErrorResponse, CommonResponse<PlaceOrderResponse>>? response = await AppRepository(context).orderIndividual();

    await response?.fold(
      (l) {
        Utils.showMessage(l.message);
      },
      (r) async {
        handleNavigateToOrderSuccessAndClearCart(context, message: r.message, uniqueId: r.responseData?.uniqueId);
      },
    );
  }

  Future<void> placeB2BUserOrderAPI(BuildContext context) async {
    final MyBagBloc myBagBloc = BlocProvider.of<MyBagBloc>(context);
    List<PlaceOrderProductRequest> placeOrderProductRequestList = myBagBloc.placeOrderProductRequestList;
    BagListDataModel? bagListDataModel = myBagBloc.bagListDataModel;
    BagOrderSummaryDataModel? bagOrderSummaryData = myBagBloc.bagOrderSummaryData;
    String? currency = StorageManager().getSelectedCurrency();
    final Map<String, dynamic> body = {
      ApiKey.commodity: myBagBloc.commodity?.value,
      ApiKey.billingAddressId: selectedBillingAddress?.id,
      ApiKey.shippingAddressId: selectedShippingAddress?.id,
      ApiKey.currency: currency,
      ApiKey.products: placeOrderProductRequestList.map((e) => e.toJson()).toList(),
      ApiKey.orderContext: AppConst.orderContext,
      ApiKey.orderContextId: StorageManager().getBagId(),
      ApiKey.totalDiscount: bagListDataModel?.summary?.discountPercentage,
      ApiKey.totalPrice: bagListDataModel?.summary?.totalAmount,
      ApiKey.meta: {
        ApiKey.paymentCondition: myBagBloc.selectedPaymentCondition?.slug,
        ApiKey.discount: myBagBloc.variationController.text,
        ApiKey.comments: myBagBloc.noteController.text.trim(),
      },
    };

    final response = await AppRepository(context).placeB2BOrder(body);

    response?.fold(
      (l) {
        Utils.showMessage(l.message);
      },
      (r) async {
        handleNavigateToOrderSuccessAndClearCart(context, message: r.message, uniqueId: r.responseData?.uniqueId);
      },
    );
  }

  void handleNavigateToOrderSuccessAndClearCart(BuildContext context, {String? message, String? uniqueId}) {
    BlocProvider.of<MyBagBloc>(context).add(ClearMyBagEvent(context));
    Utils.showMessage(message);
    context.pushNamedAndRemoveUntil(
      AppRoutes.orderConfirmationPage,
      (route) => route.settings.name != AppRoutes.landingPage,
      arguments: {
        RoutesData.orderNumber: uniqueId,
      },
    );
  }

  void _onOrderSummaryDataRefreshEvent(OrderSummaryDataRefreshEvent event, Emitter<AddressListState> emit) {
    emit(AddressListReloadState());
    fetchOrderSummaryDataFromMyBagBloc(event.context);
    emit(AddressListLoadedState(addressList, selectedShippingAddress, selectedBillingAddress, isBillingAndShippingSame));
  }

  void fetchOrderSummaryDataFromMyBagBloc(BuildContext context) {
    bagOrderSummaryData = BlocProvider.of<MyBagBloc>(context).bagOrderSummaryData;
  }
}
