part of 'forgot_email_sent_bloc.dart';

sealed class ForgotEmailSentState extends Equatable {
  const ForgotEmailSentState();

  @override
  List<Object> get props => [];
}

final class EmailSentInitial extends ForgotEmailSentState {}
