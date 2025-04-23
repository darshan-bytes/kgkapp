import 'package:kgk/kgk.dart';

class PddPreviewScreen extends StatelessWidget {
  const PddPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PddPreviewBloc bloc = BlocProvider.of<PddPreviewBloc>(context);
    return Scaffold(
      backgroundColor: AppTheme.of(context).colors.colorF7F9FA,
      appBar: _buildAppBar(bloc, context),
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<PddPreviewBloc, PddPreviewState>(
              buildWhen: (previous, current) => current is PddPreviewLoadedState,
              builder: (context, state) {
                if (state is PddPreviewLoadedState) {
                  return Padding(padding: EdgeInsetsDirectional.all(16.0.w), child: _previewOptions(bloc, context));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            const Divider(),
            _buildWebView(bloc),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(PddPreviewBloc bloc, BuildContext context) {
    return PreferredSize(
      preferredSize: context.appBarHeight,
      child: BlocBuilder<PddPreviewBloc, PddPreviewState>(
        buildWhen: (previous, current) {
          return current is PddPreviewLoadedState;
        },
        builder: (context, state) {
          return SmartAppBar(title: bloc.presentationId);
        },
      ),
    );
  }

  Widget _previewOptions(PddPreviewBloc bloc, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectionButton(
                width: 48.w,
                isSelected: false,
                image: AppImages.icVersionHistory,
                onTap: () {
                  bloc.add(NavigateToPddVersionHistoryEvent(context: context));
                },
              ),
              SelectionButton(width: 48.w, isSelected: false, image: AppImages.icAddComment, onTap: () {}),
              SelectionButton(
                width: 48.w,
                isSelected: false,
                image: AppImages.icShare,
                onTap: () {
                  Utils.showSmartModalBottomSheet(
                    context: context,
                    enableDrag: false,
                    builder: (context) => const SharePresentationScreen(),
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child:
              bloc.presentation?.status?.toLowerCase() != ApiKey.approved
                  ? SmartButton(
                    onTap: () {
                      bloc.add(PresentationApproveEvent(context: context));
                    },
                    title: APPStrings.approve.tr,
                  )
                  : SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildWebView(PddPreviewBloc bloc) {
    return Expanded(
      child: BlocBuilder<PddPreviewBloc, PddPreviewState>(
        buildWhen: (previous, current) => current is PddPreviewLoadedState,
        builder: (context, state) {
          if (state is PddPreviewLoadedState) {
            return WebViewWidget(controller: bloc.webViewController);
          } else {
            return const SmartCircularProgressIndicator();
          }
        },
      ),
    );
  }
}
