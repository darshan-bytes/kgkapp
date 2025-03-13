import 'package:kgk/kgk.dart';

class GetInspiredSection extends StatelessWidget {
  final StonesLandingBloc bloc;
  final HomeScreenStyle homeScreenStyle;
  final StonesLandingScreenStyle style;
  final String title;
  final List<AuctionListModel> itemList;
  final void Function(BuildContext, AuctionListModel) onTap;
  final Color? backgroundColor;
  final double? height;

  const GetInspiredSection(
      {super.key,
      required this.bloc,
      required this.homeScreenStyle,
      required this.style,
      required this.title,
      required this.itemList,
      required this.onTap,
      this.backgroundColor,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w, vertical: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmartText(title, style: style.sectionLabelStyle),
          SizedBox(height: 16.h),
          SmartGridView(
            columns: 2,
            spacing: 12.w,
            runSpacing: 24.h,
            items: List.generate(
              itemList.length > 4 ? 4 : itemList.length,
              (index) {
                AuctionListModel field = itemList[index];
                return GestureDetector(
                  onTap: () => onTap(context, field),
                  child: SmartImageTitleColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    topWidget: SmartImage(height: height ?? 188.w, path: field.imageUrl ?? '', fit: BoxFit.fill),
                    title: field.name ?? '',
                    titleStyle: homeScreenStyle.getInspiredTitleStyle,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
