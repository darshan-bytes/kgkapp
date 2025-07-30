import 'package:kgk/kgk.dart';

class PddListingScreen extends StatelessWidget {
  const PddListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PddListingBloc pddListingBloc = BlocProvider.of<PddListingBloc>(context);
    final diamondListingStyle = AppTheme.of(context).diamondListingStyle;
    return Scaffold(
      appBar: _buildAppBar(context),
      bottomNavigationBar: _buildBottomNavigationBar(pddListingBloc, context),
      floatingActionButton: _buildFloatingActionButton(pddListingBloc),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
          child: BlocBuilder<PddListingBloc, PddListingState>(
            buildWhen: (previous, current) => current is PddListingLoadedState || current is PddListingChangeListingTypeState,
            builder: (context, state) {
              if (state is PddListingLoadedState || state is PddListingChangeListingTypeState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 24.h),
                    _buildSearchTextField(context, pddListingBloc, diamondListingStyle),
                    SizedBox(height: 24.h),
                    _buildPddList(pddListingBloc, state),
                  ],
                );
              }
              return const SmartCircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  SmartAppBar _buildAppBar(BuildContext context) {
    return SmartAppBar(title: APPStrings.presentations.tr);
  }

  Widget _buildSearchTextField(BuildContext context, PddListingBloc pddListingBloc, DiamondListingStyle diamondListingStyle) {
    return Row(
      children: [
        Expanded(
          child: SmartTextField(
            focusNode: pddListingBloc.focusNode,
            hintText: APPStrings.searchPresentation.tr,
            controller: pddListingBloc.presentationSearchController,
            onValueChanges: (value) => pddListingBloc.add(PddListSearchEvent(context)),
            onFieldSubmitted: (value) => pddListingBloc.add(PddListSearchEvent(context)),
            suffixIcon: SmartImage(path: AppImages.icSearchThin, padding: EdgeInsetsDirectional.all(14.w)),
            onTapOutside: (value) => FocusScope.of(context).unfocus(),
          ),
        ),
        SizedBox(width: 16.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SelectionButton(
              width: 48.w,
              isSelected: pddListingBloc.isGrid,
              image: AppImages.icGrid,
              selectedButtonColor: diamondListingStyle.gridBackgroundColor,
              selectedButtonBorderColor: diamondListingStyle.gridBorderColor,
              selectedButtonIconColor: diamondListingStyle.gridIconColor,
              unselectedButtonIconColor: diamondListingStyle.listIconColor,
              unselectedButtonColor: diamondListingStyle.listBackgroundColor,
              unselectedButtonBorderColor: diamondListingStyle.listBorderColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
              onTap: () {
                pddListingBloc.add(const PresentationChangeListingTypeEvent(isGrid: true));
              },
            ),
            SelectionButton(
              width: 48.w,
              isSelected: !pddListingBloc.isGrid,
              image: AppImages.icList,
              selectedButtonColor: diamondListingStyle.gridBackgroundColor,
              selectedButtonBorderColor: diamondListingStyle.gridBorderColor,
              selectedButtonIconColor: diamondListingStyle.gridIconColor,
              unselectedButtonIconColor: diamondListingStyle.listIconColor,
              unselectedButtonColor: diamondListingStyle.listBackgroundColor,
              unselectedButtonBorderColor: diamondListingStyle.listBorderColor,
              borderRadius: BorderRadiusDirectional.only(topEnd: Radius.circular(4.r), bottomEnd: Radius.circular(4.r)),
              onTap: () {
                pddListingBloc.add(const PresentationChangeListingTypeEvent(isGrid: false));
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPddList(PddListingBloc bloc, PddListingState state) {
    return BlocBuilder<PddListingBloc, PddListingState>(
      buildWhen:
          (previous, current) =>
              current is PddListingChangeListingTypeState ||
              current is PddListLoadingMoreState ||
              current is PddListLoadedMoreState ||
              current is PddListingLoadedState ||
              current is PddListLoadingState,
      builder: (context, state) {
        if (state is PddListLoadingState) {
          return const SmartCircularProgressIndicator();
        }
        if (bloc.presentationList.isEmpty) {
          return _buildEmptyState();
        }
        return _buildListingView(bloc, state, context);
      },
    );
  }

  Widget _buildEmptyState() {
    return NoDataFoundWidget(text: APPStrings.noPresentationFound.tr);
  }

  Widget _buildListingView(PddListingBloc bloc, PddListingState state, BuildContext context) {
    return Expanded(
      child: RefreshIndicator.adaptive(
        onRefresh: () async {
          bloc.add(PddListPullToRefreshEvent(context));
        },
        child: ListView.builder(
          shrinkWrap: true,
          key: bloc.isGrid ? bloc.gridPaginationScrollController.gridKey : bloc.gridPaginationScrollController.listKey,
          controller: bloc.gridPaginationScrollController.controller,
          itemCount: bloc.presentationList.length,
          padding: EdgeInsetsDirectional.only(bottom: 30.h),
          itemBuilder: (context, index) {
            return BlocBuilder<PddListingBloc, PddListingState>(
              buildWhen: (previous, current) => current is PddListLoadingMoreState || current is PddListLoadedMoreState,
              builder: (context, state) {
                return Column(
                  children: [
                    bloc.isGrid
                        ? PresentationGridItem(
                          onTapMenuButton:
                              ((bloc.canDeletePresentation && bloc.presentationList[index].isCreatedByMe) ||
                                      (bloc.presentationList[index].status == ProjectStatus.pending && bloc.canApprovePresentation))
                                  ? () {
                                    _showMenuButtonTap(context, bloc, index);
                                  }
                                  : null,
                          margin: EdgeInsetsDirectional.only(
                            bottom: state is PddListLoadingMoreState && index == bloc.presentationList.length - 1 ? 0.h : 24.h,
                          ),
                          onTap:
                              bloc.canViewPresentation
                                  ? () {
                                    bloc.add(NavigateToPddPreviewEvent(index: index, context: context));
                                  }
                                  : null,
                          b2bCustomListingDataModel: bloc.presentationList[index],
                        )
                        : B2BListingItem(
                          margin: EdgeInsetsDirectional.only(
                            bottom: state is PddListLoadingMoreState && index == bloc.presentationList.length - 1 ? 0.h : 24.h,
                          ),
                          onTapMenuButton:
                              ((bloc.canDeletePresentation && bloc.presentationList[index].isCreatedByMe) ||
                                      (bloc.presentationList[index].status == ProjectStatus.pending && bloc.canApprovePresentation))
                                  ? () {
                                    _showMenuButtonTap(context, bloc, index);
                                  }
                                  : null,
                          type: B2BListingType.presentationListingType,
                          listingItemModel: bloc.presentationList[index],
                          onTap:
                              bloc.canViewPresentation
                                  ? () {
                                    bloc.add(NavigateToPddPreviewEvent(index: index, context: context));
                                  }
                                  : null,
                        ),
                    if (state is PddListLoadingMoreState && index == bloc.presentationList.length - 1)
                      const SmartCircularProgressIndicator(),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showMenuButtonTap(BuildContext mainContext, PddListingBloc bloc, int index) {
    OrderPopupStyle orderPopupStyle = AppTheme.of(mainContext).orderPopupStyle;
    Utils.showSmartModalBottomSheet(
      context: mainContext,
      enableDrag: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(16.r), topEnd: Radius.circular(16.r)),
      ),
      backgroundColor: orderPopupStyle.whiteColor,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(16.r), topEnd: Radius.circular(16.r)),
            color: orderPopupStyle.whiteColor,
          ),
          padding: EdgeInsetsDirectional.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (bloc.presentationList[index].status == ProjectStatus.pending && bloc.canApprovePresentation)
                _buildPopupOption(
                  mainContext,
                  text: APPStrings.approvePresentation.tr,
                  style: orderPopupStyle.optionTextStyle,
                  onTap: () {
                    context.pop();
                    handleApproveMenuButtonTap(context, bloc, bloc.presentationList[index].strPresentationNumber ?? '');
                  },
                ),
              if (bloc.canDeletePresentation && bloc.presentationList[index].isCreatedByMe)
                _buildPopupOption(
                  context,
                  text: APPStrings.deletePresentation.tr,
                  style: orderPopupStyle.cancelTextStyle,
                  onTap: () {
                    context.pop();
                    Utils.showSmartModalBottomSheet(
                      context: context,
                      builder:
                          (bottomSheetContext) => ConfirmationDialog(
                            title: APPStrings.removeSelectedPresentation.tr,
                            message: APPStrings.removeSelectedPresentationMsg.tr,
                            onApproved: () {
                              bloc.add(
                                PddListDeleteEvent(
                                  context: bottomSheetContext,
                                  presentationNumber: bloc.presentationList[index].strPresentationNumber ?? '',
                                ),
                              );
                            },
                            onDenied: () {
                              bottomSheetContext.pop();
                            },
                            onApprovedText: APPStrings.delete.tr,
                            onDeniedText: APPStrings.cancel.tr,
                          ),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPopupOption(
    BuildContext context, {
    required String text,
    required TextStyle style,
    EdgeInsetsGeometry? padding,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56.h,
        width: context.width,
        alignment: AlignmentDirectional.centerStart,
        padding: padding ?? EdgeInsetsDirectional.symmetric(horizontal: 20.w),
        child: SmartText(text, style: style),
      ),
    );
  }

  void handleApproveMenuButtonTap(BuildContext mainContext, PddListingBloc bloc, strPresentationNumber) {
    Utils.showSmartModalBottomSheet(
      context: mainContext,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(16.r), topEnd: Radius.circular(16.r)),
      ),
      builder:
          (bottomSheetContext) => ConfirmationDialog(
            title: APPStrings.presentationDialogTitle.tr,
            message: APPStrings.presentationDialogMsg.tr,
            onDenied: () {
              bottomSheetContext.pop();
            },
            onApproved: () {
              bloc.add(PddListReviewStateEvent(context: bottomSheetContext, isApproved: true, presentationNumber: strPresentationNumber));
            },
            onApprovedText: APPStrings.approve.tr,
            onDeniedText: APPStrings.cancel.tr,
          ),
    );
  }

  Widget _buildBottomNavigationBar(PddListingBloc pddListingBloc, BuildContext context) {
    return BlocBuilder<PddListingBloc, PddListingState>(
      buildWhen: (previous, current) => current is PddListingLoadedState || current is PddListingChangeListingTypeState,
      builder: (context, state) {
        if (state is PddListingLoadedState || state is PddListingChangeListingTypeState) {
          return FilterBottomActionBar(
            controller: pddListingBloc.gridPaginationScrollController.controller,
            onFilterTap: () {
              ///Here we will add the wishlist sort and filter data using this event in wishlist filter bloc
              BlocProvider.of<AdvanceSortFilterBloc>(
                context,
              ).add(AddAdvanceSortFilterDataEvent(filterOptionList: pddListingBloc.filterData, context: context));
              Utils.showSmartModalBottomSheet(
                context: context,
                builder:
                    (_) => AdvanceFilterScreen(
                      onApply: (value) {
                        if (value != null && value is List<FilterData>) {
                          pddListingBloc.add(FilterPresentationEvent(context, value));
                        }
                      },
                    ),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildFloatingActionButton(PddListingBloc pddListingBloc) {
    return BlocBuilder<PddListingBloc, PddListingState>(
      buildWhen: (previous, current) => current is PddListingChangeListingTypeState || current is PddListingLoadedState,
      builder: (context, state) {
        return ScrollToTopFAB(
          canScrollToTop: pddListingBloc.gridPaginationScrollController.canScrollToTop,
          onTap: pddListingBloc.gridPaginationScrollController.scrollToTop,
        );
      },
    );
  }
}
