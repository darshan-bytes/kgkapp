import 'package:kgk/kgk.dart';

class ExhibitionDetailsOrdersScreen extends StatelessWidget {
  final ExhibitionDetailsBloc bloc;

  const ExhibitionDetailsOrdersScreen({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExhibitionDetailsBloc, ExhibitionDetailsState>(
      buildWhen: (previous, current) => current is ExhibitionDetailsLoadedState,
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.all(16.w),
              child: Row(
                children: [
                  Expanded(
                    child: SmartTextField.search(
                      height: 48.w,
                      hintText: APPStrings.searchOrder.tr,
                      controller: bloc.searchOrderController,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
                      focusNode: bloc.focusNode,
                      onTap: () {
                        Scrollable.ensureVisible(
                          bloc.tabTargetKey.currentContext!,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn,
                        );
                      },
                      onTapOutside: (value) => FocusScope.of(context).unfocus(),
                      onValueChanges: (value) {
                        bloc.add(ExhibitionOrdersListSearchEvent(context: context));
                      },
                      onFieldSubmitted: (value) {
                        bloc.add(ExhibitionOrdersListSearchEvent(context: context));
                      },
                    ),
                  ),
                ],
              ),
            ),
            _ordersListing(bloc, context),
          ],
        );
      },
    );
  }

  Widget _ordersListing(ExhibitionDetailsBloc exhibitionDetailsOrdersBloc, BuildContext context) {
    return BlocBuilder<ExhibitionDetailsBloc, ExhibitionDetailsState>(
      buildWhen:
          (previous, current) =>
              current is ExhibitionListingLoadedMoreState ||
              current is ExhibitionListingLoadingMoreState ||
              current is ExhibitionDetailsLoadedState ||
              current is ExhibitionDetailsLoadingState,
      builder: (context, state) {
        if (state is ExhibitionDetailsLoadingState) return SmartCircularProgressIndicator();
        if (bloc.exhibitionOrdersList.isEmpty) {
          return NoDataFoundWidget(text: APPStrings.noDataFound.tr, height: context.height * 0.5);
        }
        return ListView.builder(
          padding: EdgeInsetsDirectional.only(top: 8.w, start: 16.w, end: 16.w, bottom: 48.h),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: bloc.exhibitionOrdersList.length,
          itemBuilder: (context, index) {
            final item = exhibitionDetailsOrdersBloc.exhibitionOrdersList[index];
            return Column(
              children: [
                B2BListingItem(
                  listingItemModel: item,
                  type: B2BListingType.exhibitionDetailPageOrdersType,
                  onTapMenuButton: () {},
                  isLastFullWidthRequired: true,
                  margin: EdgeInsetsDirectional.only(bottom: 16.w),
                ),
                if (state is ExhibitionListingLoadingMoreState && index == bloc.exhibitionOrdersList.length - 1)
                  const SmartCircularProgressIndicator(),
              ],
            );
          },
        );
      },
    );
  }
}
