import 'package:kgk/kgk.dart';

class PresentationScreen extends StatelessWidget {
  const PresentationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PresentationBloc bloc = BlocProvider.of<PresentationBloc>(context);

    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.presentations.tr.toUpperCamelCase),
      bottomNavigationBar: _buildBottomNavigationBar(bloc, context),
      floatingActionButton: BlocBuilder<PresentationBloc, PresentationState>(
        buildWhen: (previous, current) => current is PresentationLoadedState || current is PaginationControllerLoadedState,
        builder: (context, state) {
          if (!bloc.paginationScrollController.isInitialised) {
            return SizedBox.shrink();
          }
          return ScrollToTopFAB(
            canScrollToTop: bloc.paginationScrollController.canScrollToTop,
            onTap: bloc.paginationScrollController.scrollToTop,
          );
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 16.0.w),
          child: BlocBuilder<PresentationBloc, PresentationState>(
            buildWhen: (previous, current) => current is PresentationLoadedState,
            builder: (context, state) {
              if (state is PresentationLoadedState) {
                return _buildPresentationList(bloc);

                /// Below code is commented as of now as for now it is removed from the features
                // return Column(
                //   crossAxisAlignment: CrossAxisAlignment.stretch,
                //   children: [
                // SizedBox(height: 24.h),
                // SmartTextField(
                //   hintText: APPStrings.searchPresentation.tr,
                //   controller: bloc.presentationSearchController,
                //   suffixIcon: SmartImage(path: AppImages.icSearchThin, padding: EdgeInsetsDirectional.all(16.w)),
                //   onTapOutside: (val) {},
                //   textInputAction: TextInputAction.search,
                // ),
                // ],
                // );
              } else {
                return const SmartCircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPresentationList(PresentationBloc bloc) {
    if (!bloc.paginationScrollController.isInitialised) {
      return SizedBox.shrink();
    }
    if (bloc.presentationList.isEmpty) {
      return NoDataFoundWidget(text: APPStrings.noDataFound.tr);
    }
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsetsDirectional.symmetric(vertical: 24.w),
      controller: bloc.paginationScrollController.scrollController,
      itemCount: bloc.presentationList.length,
      itemBuilder: (context, index) {
        B2BCustomListingDataModel presentationItem = bloc.presentationList[index];
        return B2BListingItem(
          type: B2BListingType.presentationType,
          listingItemModel: presentationItem,
          onTapMenuButton:
              bloc.userType == UserType.internal
                  ? () {
                    handleMenuButtonTap(context, bloc, presentationItem.strPresentationNumber ?? '');
                  }
                  : null,
          onTap: () {},
        );
      },
      separatorBuilder: (_, __) => SizedBox(height: 16.h),
    );
  }

  void handleMenuButtonTap(BuildContext mainContext, PresentationBloc bloc, strPresentationNumber) {
    Utils.showSmartModalBottomSheet(
      context: mainContext,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(16.r), topEnd: Radius.circular(16.r)),
      ),
      builder:
          (context) => ConfirmationDialog(
            title: APPStrings.presentationDialogTitle.tr,
            message: APPStrings.presentationDialogMsg.tr,
            onApproved: () {
              bloc.add(PresentationReviewStateEvent(context: mainContext, isApproved: true, presentationNumber: strPresentationNumber));
            },
            onApprovedText: APPStrings.approve.tr,
            onDeniedText: APPStrings.reject.tr,
          ),
    );
  }

  Widget _buildBottomNavigationBar(PresentationBloc bloc, BuildContext context) {
    if (!bloc.paginationScrollController.isInitialised) {
      return SizedBox.shrink();
    }
    return SafeArea(
      child: FilterBottomActionBar(
        controller: bloc.paginationScrollController.controller,
        onFilterTap: () {
          Utils.showSmartModalBottomSheet(context: context, builder: (context) => FilterScreen(onApply: () {}));
        },
      ),
    );
  }
}
