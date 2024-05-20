part of 'app_bloc.dart';

sealed class AppState extends Equatable {
  const AppState();
}

final class AppInitial extends AppState {
  @override
  List<Object> get props => [];
}

final class ThemeDataState extends AppState {
  final ThemeData themeData;

  const ThemeDataState(this.themeData);

  @override
  List<Object> get props => [themeData];
}

class ConnectivityState extends AppState {
  final bool isConnected;

  const ConnectivityState(this.isConnected);

  @override
  List<Object> get props => [isConnected];
}
