part of 'design_briefs_bloc.dart';

sealed class DesignBriefsEvent extends Equatable {
  const DesignBriefsEvent();
}

final class InitialDesignBriefsEvent extends DesignBriefsEvent {
  final BuildContext context;

  const InitialDesignBriefsEvent({required this.context});

  @override
  List<Object> get props => [context];
}
