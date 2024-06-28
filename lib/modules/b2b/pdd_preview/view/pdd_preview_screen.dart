import 'package:kgk/kgk.dart';

class PddPreviewScreen extends StatelessWidget {
  const PddPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PddPreviewBloc pddPreviewBloc = BlocProvider.of<PddPreviewBloc>(context);
    return Scaffold(
      backgroundColor: AppTheme.of(context).colors.colorF7F9FA,
      appBar: _buildAppBar(pddPreviewBloc),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0.w),
              child: _previewOptions(pddPreviewBloc, context),
            ),
            const Divider(),
            _buildWebView(pddPreviewBloc),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(PddPreviewBloc pddPreviewBloc) {
    return PreferredSize(
      preferredSize: AppConst.appBarHeight,
      child: BlocBuilder<PddPreviewBloc, PddPreviewState>(
        buildWhen: (previous, current) {
          return current is PddPreviewLoadedState;
        },
        builder: (context, state) {
          return SmartAppBar(
            title: pddPreviewBloc.appbarTitle,
          );
        },
      ),
    );
  }

  Widget _previewOptions(PddPreviewBloc pddPreviewBloc, BuildContext context) {
    return Row(children: [
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SelectionButton(
              width: 48.w,
              isSelected: false,
              image: AppImages.icVersionHistory,
              onTap: () {
                pddPreviewBloc.add(NavigateToPddVersionHistoryEvent(context: context));
              },
            ),
            SelectionButton(
              width: 48.w,
              isSelected: false,
              image: AppImages.icAddComment,
              onTap: () {},
            ),
            SelectionButton(
              width: 48.w,
              isSelected: false,
              image: AppImages.icShare,
              onTap: () {},
            ),
          ],
        ),
      ),
      SizedBox(width: 16.w),
      Expanded(
        child: SmartButton(onTap: () {}, title: APPStrings.approve.tr),
      ),
    ]);
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
