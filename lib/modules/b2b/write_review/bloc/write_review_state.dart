part of 'write_review_bloc.dart';

sealed class WriteReviewState extends Equatable {
  const WriteReviewState();
  
  @override
  List<Object> get props => [];
}

final class WriteReviewInitial extends WriteReviewState {}
