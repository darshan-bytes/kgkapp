part of 'my_bag_bloc.dart';

abstract class MyBagState extends Equatable {
  const MyBagState();
}

final class MyBagInitial extends MyBagState {
  @override
  List<Object> get props => [];
}

final class MyBagReloadState extends MyBagState {
  @override
  List<Object> get props => [];
}
