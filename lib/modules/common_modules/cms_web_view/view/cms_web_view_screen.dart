import 'package:kgk/kgk.dart';

class CmsWebViewScreen extends StatelessWidget {
  const CmsWebViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CmsWebViewBloc cmsWebViewBloc = BlocProvider.of<CmsWebViewBloc>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: context.appBarHeight,
        child: BlocBuilder<CmsWebViewBloc, CmsWebViewState>(
          buildWhen: (previous, current) => current is CmsWebViewLoadedState,
          builder: (context, state) {
            return SmartAppBar(title: cmsWebViewBloc.appBarTitle);
          },
        ),
      ),
      body: _buildWebView(cmsWebViewBloc),
    );
  }

  Widget _buildWebView(CmsWebViewBloc cmsWebViewBloc) {
    return SafeArea(
      child: BlocBuilder<CmsWebViewBloc, CmsWebViewState>(
        buildWhen: (previous, current) => current is CmsWebViewLoadedState,
        builder: (context, state) {
          if (state is CmsWebViewLoadedState) {
            return WebViewWidget(
              controller: cmsWebViewBloc.webViewController,
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
