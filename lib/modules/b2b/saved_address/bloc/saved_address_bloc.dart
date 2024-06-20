// import 'package:kgk/kgk.dart';

// part 'saved_address_event.dart';
// part 'saved_address_state.dart';

// class SavedAddressBloc
//     extends Bloc<SavedAddressEvent, SavedAddressState> {
//   SavedAddressBloc() : super(SavedAddressInitialState()) {
//     on<SavedAddressLoadedEvent>(_onInitShippingAddressLoadEvent);

//     on<SavedAddressDeleteAddressEvent>(_onDeleteEvent);
//   }

//   void _onInitShippingAddressLoadEvent(
//       SavedAddressLoadedEvent event, Emitter<SavedAddressState> emit) {
//     final list = [
//       SavedAddressModel(
//           firstName: "Amol",
//           lastName: "Khade",
//           streetAddress: "ABC Chowk",
//           apartment: "Hello World Apartment",
//           city: "Nashik",
//           state: "MH",
//           zipCode: "4110233",
//           phoneNumber: "987654345",
//           isDefault: true,
//           isSelected: true),
//       SavedAddressModel(
//           firstName: "Gautam",
//           lastName: "Singhania",
//           streetAddress: "School house road",
//           apartment: "431",
//           city: "Georgetown",
//           state: "KY",
//           zipCode: "40324",
//           phoneNumber: "98765467677",
//           isDefault: false,
//           isSelected: false),
//     ];
//     emit(SavedAddressLoadedState(list));
//   }

//   void clearData() {}
//   void _onDeleteEvent(
//       SavedAddressDeleteAddressEvent event, Emitter<SavedAddressState> emit) {
//     if(state is SavedAddressLoadedState){
//       final updatedData = List<SavedAddressModel>.from((state as SavedAddressLoadedState).data)
//         ..remove(event.address);

//       if(updatedData.isEmpty){
//         emit(SavedAddressNoDataState("No data Found"));
//       }
//       else {
//         emit(SavedAddressLoadedState(updatedData));
//       }
//     }
//   }


// }
