part of 'email_sent_bloc.dart';

sealed class EmailSentState extends Equatable {
  const EmailSentState();
  
  @override
  List<Object> get props => [];
}

final class EmailSentInitial extends EmailSentState {}
