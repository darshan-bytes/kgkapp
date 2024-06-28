import 'package:kgk/kgk.dart';

class PddPreviewHistoryScreen extends StatelessWidget {
  const PddPreviewHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PddPreviewBloc pddPreviewBloc = BlocProvider.of<PddPreviewBloc>(context);
    return Scaffold(
      backgroundColor: AppTheme.of(context).colors.colorF7F9FA,
      appBar: SmartAppBar(
        title: APPStrings.versionHistory.tr,
        backgroundColor: AppTheme.of(context).colors.colorF7F9FA,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            children: [
              _versionHistoryDropdown(pddPreviewBloc),
              SizedBox(height: 16.h),
              _buildWebView(pddPreviewBloc),
            ],
          ),
        ),
      ),
    );
  }

  Widget _versionHistoryDropdown(PddPreviewBloc pddPreviewBloc) {
    return BlocBuilder<PddPreviewBloc, PddPreviewState>(
      buildWhen: (previous, current) => current is PddPreviewChangePreviewTypeState || current is PddPreviewLoadedState,
      builder: (context, state) {
        return SmartDropDown<PddVersionHistoryModel>(
          selectedItem: pddPreviewBloc.selectedversion,
          backgroundColor: AppTheme.of(context).colors.white,
          items: pddPreviewBloc.versionHistoryList.map((PddVersionHistoryModel versions) {
            return SmartDropDownItem<PddVersionHistoryModel>(
              value: versions,
              title: versions.historyDateTime ?? '',
            );
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
              return WebViewWidget(
                controller: pddPreviewBloc.webViewController,
              );
            } else {
              return const SmartCircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
