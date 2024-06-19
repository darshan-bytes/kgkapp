import 'package:kgk/modules/b2b/shipping_address/bloc/shipping_address_event.dart';
import 'package:kgk/modules/b2b/shipping_address/bloc/shipping_address_state.dart';

import '../../../../kgk.dart';
import '../model/shipping_address_model.dart';

class ShippingAddressBloc
    extends Bloc<ShippingAddressEvent, ShippingAddressState> {
  ShippingAddressBloc() : super(InitialState()) {
    on<ShippingAddressInitialEvent>(_onInitShippingAddressInit);
    on<ShippingAddressLoadedEvent>(_onInitShippingAddressLoadEvent);
    on<ShippingAddressDeleteAddressEvent>(_onDeleteEvent);
    on<SelectShippingAddressEvent>(_onSelectAddressEvent);
  }

  void _onInitShippingAddressInit(ShippingAddressInitialEvent event,
      Emitter<ShippingAddressState> emit) async {
    await Future.delayed(Duration(seconds: 3));
    final list = [
      ShippingAddressModel(   id: 1,
          firstName: "John",
          lastName: "Ramo",
          streetAddress: "ABC Square",
          apartment: "Zolo Apartment",
          city: "NewYork",
          state: "NY",
          zipCode: "45654",
          phoneNumber: "987654345",
          isDefault: true,
          isSelected: true),
      ShippingAddressModel(   id: 2,
          firstName: "Gautam",
          lastName: "Singhania",
          streetAddress: "School house road",
          apartment: "431",
          city: "Georgetown",
          state: "KY",
          zipCode: "40324",
          phoneNumber: "98765467677",
          isDefault: false,
          isSelected: false),
      ShippingAddressModel(
          id: 3,
          firstName: "Abhi",
          lastName: "Singhania",
          streetAddress: "School house road",
          apartment: "431",
          city: "Georgetown",
          state: "KY",
          zipCode: "40324",
          phoneNumber: "98765467677",
          isDefault: false,
          isSelected: false),
    ];
    emit(LoadedState(list));
  }

  void _onInitShippingAddressLoadEvent(
      ShippingAddressLoadedEvent event, Emitter<ShippingAddressState> emit) {
    final list = [
      ShippingAddressModel(
          id: 1,
          firstName: "Amffol",
          lastName: "Khade",
          streetAddress: "ABC Chowk",
          apartment: "Zolo Apartment",
          city: "Nashik",
          state: "MH",
          zipCode: "4110233",
          phoneNumber: "987654345",
          isDefault: true,
          isSelected: true)
    ];
    emit(LoadedState(list));
  }

  void clearData() {}

  void _onDeleteEvent(ShippingAddressDeleteAddressEvent event,
      Emitter<ShippingAddressState> emit) {
    if (state is LoadedState) {
      final updatedData =
          List<ShippingAddressModel>.from((state as LoadedState).data)
            ..remove(event.address);

      if (updatedData.isEmpty) {
        emit(NoDataState("No data Found"));
      } else {
        emit(LoadedState(updatedData));
      }
    }
  }

  void _onSelectAddressEvent(
      SelectShippingAddressEvent event, Emitter<ShippingAddressState> emit) {
    if (state is LoadedState) {
      final updatedData =
          List<ShippingAddressModel>.from((state as LoadedState).data);
      for (var model in updatedData) {
        if (model.id == event.id) {
          model.isSelected = true;
        } else {
          model.isSelected = false;
        }
      }
      emit(LoadedState(updatedData));
    }
  }
}
