part of 'my_bag_bloc.dart';

abstract class MyBagEvent extends Equatable {
  const MyBagEvent();
}

final class InitialMyBagEvent extends MyBagEvent {
  @override
  List<Object> get props => [];
}
