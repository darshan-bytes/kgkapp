import 'package:kgk/kgk.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionViewStyle style = AppTheme.of(context).collectionViewStyle;
    return Scaffold(
      appBar: SmartAppBar(
        title: APPStrings.collection.tr,
        onFavorite: () {
          context.pushNamed(AppRoutes.wishListPage);
        },
        onFilter: () {},
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: context.width,
            margin: EdgeInsets.only(bottom: 20.h),
            height: 176.h,
            color: style.headerBgColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmartText(
                  "Explore Collection Set",
                  style: style.headerTitleStyle,
                ),
                SmartText(
                  "Discover our new\ncollections",
                  style: style.headerSubTitleStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 14.w),
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SmartText(
                        "Love & passion on January",
                        style: style.collectionListTitleStyle,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      ListView.builder(
                          itemCount: 4,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                context.pushNamed(AppRoutes.productListGridPage, arguments: {RoutesData.productListData: index});
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 14.h),
                                child: SmartImage(
                                  path: index == 0 || index == 3
                                      ? "https://i.ibb.co/CQCRPFy/Banner.png"
                                      : "https://i.ibb.co/k4n8Qry/Banner.png",
                                  height: index == 0 || index == 3 ? 200.h : 140.h,
                                  width: context.width,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          }),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  );
                },
                itemCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics()),
          ),
        ]),
      ),
    );
  }
}
