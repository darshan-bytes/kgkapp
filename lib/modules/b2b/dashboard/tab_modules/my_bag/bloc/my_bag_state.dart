part of 'my_bag_bloc.dart';

sealed class MyBagState extends Equatable {
  const MyBagState();
}

final class MyBagInitial extends MyBagState {
  @override
  List<Object> get props => [];
}
