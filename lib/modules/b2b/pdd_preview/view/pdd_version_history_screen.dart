import 'package:kgk/kgk.dart';

class PddPreviewHistoryScreen extends StatelessWidget {
  const PddPreviewHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PddPreviewBloc pddPreviewBloc = BlocProvider.of<PddPreviewBloc>(context);
    final style = AppTheme.of(context).pddVersionHistoryStyle;
    return Scaffold(
      backgroundColor: style.backgroundColor,
      appBar: SmartAppBar(title: APPStrings.versionHistory.tr),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.all(16.0.w),
          child: Column(children: [_versionHistoryDropdown(pddPreviewBloc, style), SizedBox(height: 16.h), _buildWebView(pddPreviewBloc)]),
        ),
      ),
    );
  }

  Widget _versionHistoryDropdown(PddPreviewBloc pddPreviewBloc, PddVersionHistoryStyle style) {
    return BlocBuilder<PddPreviewBloc, PddPreviewState>(
      buildWhen: (previous, current) => current is PddPreviewChangePreviewTypeState || current is PddPreviewLoadedState,
      builder: (context, state) {
        return SmartDropDown<PddVersionHistoryModel>(
          selectedItem: pddPreviewBloc.selectedversion,
          backgroundColor: style.backgroundColor,
          items:
              pddPreviewBloc.versionHistoryList.map((PddVersionHistoryModel versions) {
                return SmartDropDownItem<PddVersionHistoryModel>(value: versions, title: versions.historyDateTime ?? '');
              }).toList(),
          onChanged: (value) {
            if (value != null) {
              pddPreviewBloc.add(VersionHistoryChangeEvent(pddVersionHistoryModel: value));
            }
          },
        );
      },
    );
  }

  Widget _buildWebView(PddPreviewBloc pddPreviewBloc) {
    return Expanded(
      child: SafeArea(
        child: BlocBuilder<PddPreviewBloc, PddPreviewState>(
          buildWhen: (previous, current) => current is PddPreviewLoadedState,
          builder: (context, state) {
            if (state is PddPreviewLoadedState) {
              return WebViewWidget(controller: pddPreviewBloc.webViewController);
            } else {
              return const SmartCircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
