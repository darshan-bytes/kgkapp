part of 'cms_web_view_bloc.dart';

sealed class CmsWebViewState extends Equatable {
  const CmsWebViewState();
}

final class CmsWebViewInitialState extends CmsWebViewState {
  @override
  List<Object> get props => [];
}

final class CmsWebViewLoadedState extends CmsWebViewState {
  final WebViewController controller;

  const CmsWebViewLoadedState({required this.controller});

  @override
  List<Object?> get props => [controller];
}
