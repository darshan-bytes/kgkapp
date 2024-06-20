// part of 'saved_address_bloc.dart';
    
// sealed class SavedAddressEvent extends Equatable {
//   const SavedAddressEvent();

//   @override
//   List<Object?> get props => [];
// }

// final class SavedAddressInitialEvent extends SavedAddressEvent {
//   final BuildContext context;

//   const SavedAddressInitialEvent(this.context);

//   @override
//   List<Object> get props => [context];
// }

// final class SavedAddressLoadedEvent extends SavedAddressEvent {}

// final class SavedAddressEditEvent extends SavedAddressEvent {}

// final class SavedAddressDeleteAddressEvent extends SavedAddressEvent {
//   final SavedAddressModel address;

//   const SavedAddressDeleteAddressEvent(this.address);

//   @override
//   List<Object> get props => [address];
// }

// final class SelectSavedAddressEvent extends SavedAddressEvent {}

// final class SelectSavedNoData extends SavedAddressEvent {
//   final String message;

//   const SelectSavedNoData(this.message);

//   @override
//   List<Object> get props => [message];
// }
