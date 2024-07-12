import 'package:kgk/kgk.dart';

class PreviewCatalogueScreen extends StatelessWidget {
  const PreviewCatalogueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PreviewCatalogueBloc bloc = BlocProvider.of<PreviewCatalogueBloc>(context);
    final PreviewCatalogueStyle style = AppTheme.of(context).previewCatalogueStyle;
    return Scaffold(
      appBar: appBarPreferredSize(bloc),
      body: buildBody(bloc, context, style),
    );
  }

  PreferredSizeWidget appBarPreferredSize(PreviewCatalogueBloc bloc) {
    return PreferredSize(
      preferredSize: AppConst.appBarHeight,
      child: BlocBuilder<PreviewCatalogueBloc, PreviewCatalogueState>(
        buildWhen: (previous, current) => current is PreviewCatalogueLoadedState,
        builder: (context, state) {
          return SmartAppBar(
            title: bloc.title,
            onFavorite: () => context.pushNamed(AppRoutes.wishListPage),
            onSearch: () => context.pushNamed(AppRoutes.allReviewPage),
          );
        },
      ),
    );
  }

  Widget buildBody(PreviewCatalogueBloc bloc, BuildContext context, PreviewCatalogueStyle style) {
    return BlocBuilder<PreviewCatalogueBloc, PreviewCatalogueState>(
      buildWhen: (previous, current) => current is PreviewCatalogueLoadedState,
      builder: (context, state) {
        if (state is PreviewCatalogueLoadedState) {
          return Column(
            children: [
              _buildCommentAndShareRow(bloc, style, context),
              const Divider(),
              _buildPageStepper(bloc, style),
              Divider(thickness: 24.h, color: style.backgroundColor, height: 24.h),
              Expanded(
                child: bloc.isWebView ? _buildWebView(bloc, style) : _buildCustomCatalogueView(bloc, style),
              ),
              _buildCommentBottomNavBar(bloc, style),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildCommentAndShareRow(PreviewCatalogueBloc bloc, PreviewCatalogueStyle style, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: BorderRadius.circular(8.w),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          if (!bloc.isWebView) ...[
            BlocBuilder<PreviewCatalogueBloc, PreviewCatalogueState>(
              buildWhen: (previous, current) => current is PreviewCatalogueCommentState,
              builder: (context, state) {
                return Expanded(
                  flex: bloc.isCommentVisible ? 1 : 2,
                  child: SmartButton(
                    onTap: () {
                      bloc.add(const PreviewCatalogueCommentEvent());
                    },
                    title: bloc.isCommentVisible ? APPStrings.save.tr : APPStrings.selectAndComment.tr,
                  ),
                );
              },
            ),
            SizedBox(width: 16.w),
          ],
          Expanded(
            child: SmartButton(
              onTap: () {
                Utils.showSmartModalBottomSheet(
                  context: context,
                  enableDrag: false,
                  builder: (context) => const SharePresentationScreen(isPresentation: false),
                );
              },
              title: APPStrings.share.tr,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageStepper(PreviewCatalogueBloc bloc, PreviewCatalogueStyle style) {
    return BlocBuilder<PreviewCatalogueBloc, PreviewCatalogueState>(
      buildWhen: (previous, current) => current is PreviewCataloguePreviousNextPageState,
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              bloc.currentPage == 0
                  ? SizedBox(width: 24.w)
                  : SmartImage(
                      path: AppImages.icArrowLeft,
                      padding: EdgeInsets.all(8.w),
                      onTap: () {
                        bloc.add(const PreviewCataloguePreviousNextPageEvent(false));
                      },
                    ),
              Expanded(
                child: Center(
                  child: SizedBox(
                    height: 34.h,
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: bloc.pageList.length,
                        itemBuilder: (context, index) {
                          return SelectionButton(
                            isSelected: index == bloc.currentPage,
                            onTap: () {},
                            height: 34.w,
                            width: 34.w,
                            selectedButtonBorderColor: style.selectedStepBorderColor,
                            unselectedButtonBorderColor: style.stepBorderColor,
                            selectedButtonColor: style.whiteColor,
                            unselectedButtonColor: style.whiteColor,
                            title: (index + 1).toString(),
                            selectedButtonTextStyle: style.selectedStepTextStyle,
                            unselectedButtonTextStyle: style.stepTextStyle,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 16.w);
                        }),
                  ),
                ),
              ),
              bloc.currentPage == bloc.pageList.length - 1
                  ? SizedBox(width: 24.w)
                  : SmartImage(
                      path: AppImages.icArrowRight,
                      padding: EdgeInsets.all(8.w),
                      onTap: () {
                        bloc.add(const PreviewCataloguePreviousNextPageEvent(true));
                      },
                    ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCustomCatalogueView(PreviewCatalogueBloc bloc, PreviewCatalogueStyle style) {
    return BlocBuilder<PreviewCatalogueBloc, PreviewCatalogueState>(
      buildWhen: (previous, current) => current is PreviewCataloguePreviousNextPageState,
      builder: (context, state) {
        return SmartSingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 27.h),
          child: Column(
            children: [
              SmartText('${bloc.digitalCatalogueListingModel?.name ?? ''} ${(bloc.currentPage + 1)}', style: style.titleStyle),
              SizedBox(height: 12.h),
              SmartText(bloc.digitalCatalogueListingModel?.description ?? '', style: style.subTitleStyle, textAlign: TextAlign.center),
              SizedBox(height: 32.h),
              SmartGridView(
                items: List.generate(
                  bloc.productList.length,
                  (index) => BlocBuilder<PreviewCatalogueBloc, PreviewCatalogueState>(
                      buildWhen: (previous, current) =>
                          current is PreviewCatalogueCommentState || current is PreviewCatalogueCommentProductSelectState,
                      builder: (context, state) {
                        return ProductGridItem(
                          productDetails: bloc.productList[index],
                          onCommentTap: bloc.isCommentVisible
                              ? () {
                                  bloc.add(PreviewCatalogueCommentProductSelectEvent(index: index));
                                }
                              : null,
                          isCommentSelected: index == bloc.selectedCommentIndex,
                          onTap: bloc.isCommentVisible
                              ? () {
                                  bloc.add(PreviewCatalogueCommentProductSelectEvent(index: index));
                                }
                              : null,
                        );
                      }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWebView(PreviewCatalogueBloc bloc, PreviewCatalogueStyle style) {
    return WebViewWidget(controller: bloc.webViewController);
  }

  Widget _buildCommentBottomNavBar(PreviewCatalogueBloc bloc, PreviewCatalogueStyle style) {
    return BlocBuilder<PreviewCatalogueBloc, PreviewCatalogueState>(
      buildWhen: (previous, current) => current is PreviewCatalogueCommentState || current is PreviewCatalogueLoadedState,
      builder: (context, state) {
        if (bloc.isCommentVisible) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: style.whiteColor,
                child: SafeArea(
                  child: Container(
                    decoration: BoxDecoration(
                      color: style.whiteColor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(24.r), topRight: Radius.circular(24.r)),
                      boxShadow: [style.boxShadow],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                    child: Stack(
                      children: [
                        SmartTextField(
                          autofocus: false,
                          labelText: APPStrings.addAComment.tr,
                          controller: bloc.commentController,
                          focusNode: bloc.commentFocusNode,
                          maxLines: 3,
                          textInputAction: TextInputAction.newline,
                          onTapOutside: (value) => FocusManager.instance.primaryFocus?.unfocus(),
                        ),
                        Positioned(
                          right: 14.w,
                          top: 86.w,
                          child: SmartImage(
                            height: 24.w,
                            width: 24.w,
                            path: AppImages.icSendComment,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
