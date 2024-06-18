part of 'cms_web_view_bloc.dart';

sealed class CmsWebViewEvent extends Equatable {
  const CmsWebViewEvent();
}

final class CmsWebViewInitialEvent extends CmsWebViewEvent {
  final BuildContext context;

  const CmsWebViewInitialEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
