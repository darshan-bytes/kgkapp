import 'package:kgk/kgk.dart';

part 'address_list_event.dart';

part 'address_list_state.dart';

class AddressListBloc extends Bloc<AddressListEvent, AddressListState> {
  AddressListBloc() : super(AddressListInitial()) {
    on<ChangeSelectedAddressEvent>(_onChangeSelectedAddressEvent);
    on<DeleteAddressEvent>(_onDeleteAddressEvent);
    on<EditAddressEvent>(_onEditAddressEvent);
    on<AddNewAddressEvent>(_onAddNewAddressEvent);
    on<ToggleBillingAndShippingSameEvent>(_onToggleBillingAndShippingSameEvent);
    on<ChangeProductListExpansionEvent>(_onChangeProductListExpansionEvent);
  }

  GlobalKey<SmartExpansionTileState> productsListExpansionKey = GlobalKey();
  bool isProductListExpanded = false;

  AddressDetails? selectedAddress;
  List<AddressDetails> addressList = [
    AddressDetails(
      firstName: "Gautam",
      lastName: "Singhania",
      contactNumber: "+91-850-427-9498",
      addressLine1: "123, ABC Colony",
      addressLine2: "Near XYZ Park",
      city: "Delhi",
      state: "Delhi",
      country: "India",
      zipCode: "110001",
    ),
    AddressDetails(
      firstName: "Rahul",
      lastName: "Sharma",
      contactNumber: "+91-850-427-9498",
      addressLine1: "123, ABC Colony",
      addressLine2: "Near XYZ Park",
      city: "Mumbai",
      state: "Maharashtra",
      country: "India",
      zipCode: "400001",
    ),
  ];

  bool isBillingAndShippingSame = true;

  List<ProductDetails> productList = List.generate(
      25,
      (index) => ProductDetails(
            productId: index.toString(),
            imageUrl:
                'https://s3-alpha-sig.figma.com/img/b565/a299/4cad8feb0dc565fcb23a5df4b8a8aa9f?Expires=1717372800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=bngvfjokcYR5qP3qicAkkvvY9SxFgBLXhBlaL~4lqLjlUOko6k2LOmg5LT5GSAikSbdf4TJh64kIfhs59GcliNFg9UQU9Zstps6QkpWjHsgc~kInzl3rKyBeeFTQDGMFwLzBsLdjlnQiYh7uN3Y8xPpFeW7xewz~z9TST5RzBgFkAd2d-jyJiyrnlOc5ubcYsSlBG3DpKp7--GzK4OzkespCMjGgFO608x3N-~~CVZd5QeNBYTLTJODLe9DABhX~DDeTDyun-3Ihcp7jvxl7y9UbR9zLQDR6H67fYYxXN3WhLZshgLz8RVAT~RG-UDqKv2zTyMd-f8xi9E4CAy7sng__',
            name: "Diamond Vine Ring in 18k Rose Gold",
            originalPrice: '\$5,000.00',
            discountPercentage: "You have saved 10%",
            offerPrice: '\$3,000.00',
          ));

  void _onChangeSelectedAddressEvent(ChangeSelectedAddressEvent event, Emitter<AddressListState> emit) {
    int oldIndex = addressList.indexOf(selectedAddress ?? AddressDetails());
    selectedAddress = addressList[event.index];
    emit(ChangeSelectedAddressState(event.index, oldIndex));
  }

  void _onDeleteAddressEvent(DeleteAddressEvent event, Emitter<AddressListState> emit) {
    emit(const AddressListReloadState());
    if (selectedAddress == addressList[event.index]) {
      selectedAddress = null;
    }
    addressList.removeAt(event.index);
    emit(const DeleteAddressState());
  }

  void _onEditAddressEvent(EditAddressEvent event, Emitter<AddressListState> emit) {
    //TODO: Implement edit address
  }

  Future<void> _onAddNewAddressEvent(AddNewAddressEvent event, Emitter<AddressListState> emit) async {
    final Map<RoutesData, dynamic>? result = await event.context.pushNamed(AppRoutes.addAddressPage);
    if (result != null && result.containsKey(RoutesData.addressDetails) && result[RoutesData.addressDetails] is AddressDetails) {
      AddressDetails addressDetails = result[RoutesData.addressDetails];
      addressList.add(addressDetails);
      selectedAddress = addressDetails;
      emit(AddNewAddressState(addressDetails));
    }
  }

  void _onToggleBillingAndShippingSameEvent(ToggleBillingAndShippingSameEvent event, Emitter<AddressListState> emit) {
    isBillingAndShippingSame = !isBillingAndShippingSame;
    emit(ToggleBillingAndShippingSameState(isBillingAndShippingSame));
  }

  void _onChangeProductListExpansionEvent(ChangeProductListExpansionEvent event, Emitter<AddressListState> emit) {
    isProductListExpanded = !isProductListExpanded;
    emit(ChangeProductListExpansionState(isProductListExpanded));
  }
}
