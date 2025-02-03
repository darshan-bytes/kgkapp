part of 'saved_address_bloc.dart';

sealed class SavedAddressState extends Equatable {
  const SavedAddressState();
}

final class SavedAddressInitial extends SavedAddressState {
  const SavedAddressInitial();

  @override
  List<Object> get props => [];
}

final class SavedAddressLoadedState extends SavedAddressState {
  const SavedAddressLoadedState();

  @override
  List<Object> get props => [];
}

final class SavedAddressReloadState extends SavedAddressState {
  const SavedAddressReloadState();

  @override
  List<Object> get props => [];
}
