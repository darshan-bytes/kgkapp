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
                padding: EdgeInsets.all(16.w),
                child: Row(
                  children: [
                    Expanded(
                      child: SmartTextField.search(
                        height: 48.h,
                        onValueChanges: (value) => {},
                        onFieldSubmitted: (value) => {},
                        hintText: APPStrings.searchOrder.tr,
                      ),
                    ),
                    SizedBox(width: 16.0.w),
                    SelectionButton(
                      width: 48.w,
                      imageHeight: 24.5.w,
                      imageWidth: 24.5.w,
                      isSelected: false,
                      image: AppImages.icMenu,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              _ordersListing(bloc, context),
            ],
          );
        });
  }

  Widget _ordersListing(ExhibitionDetailsBloc exhibitionDetailsOrdersBloc, BuildContext context) {
    return BlocBuilder<ExhibitionDetailsBloc, ExhibitionDetailsState>(
      buildWhen: (previous, current) =>
          current is ExhibitionListingLoadedMoreState ||
          current is ExhibitionListingLoadingMoreState ||
          current is ExhibitionDetailsLoadedState,
      builder: (context, state) {
        if (bloc.exhibitionOrdersList.isEmpty) {
          return NoDataFoundWidget(text: APPStrings.noDataFound.tr);
        }
        return ListView.separated(
          padding: EdgeInsets.only(top: 8.w, left: 16.w, right: 16.w),
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
                ),
                if (state is ExhibitionListingLoadingMoreState && index == bloc.exhibitionOrdersList.length - 1)
                  const SmartCircularProgressIndicator(),
              ],
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
        );
      },
    );
  }
}
