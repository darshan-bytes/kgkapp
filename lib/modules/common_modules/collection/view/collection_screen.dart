import 'package:kgk/kgk.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionViewStyle style = AppTheme.of(context).collectionViewStyle;
    return Scaffold(
      appBar: SmartAppBar(
        title: APPStrings.collection.tr,
        onFavorite: () {},
        onFilter: () {},
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(bottom: 20),
            height: 176,
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
            margin: const EdgeInsets.symmetric(horizontal: 14),
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SmartText(
                        "Love & passion on January",
                        style: style.collectionListTitleStyle,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                          itemCount: 4,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                //  For  product listing
                                // Navigator.pushNamed(context, AppRoutes.productListGridPage);
                                // // For  diamond listing
                                Navigator.pushNamed(context, AppRoutes.diamondListingPage);
                                // For seatting listing
                                // Navigator.pushNamed(context, AppRoutes.settingListingPage);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 14),
                                child: SmartImage(
                                  path: index == 0 || index == 3
                                      ? "https://i.ibb.co/CQCRPFy/Banner.png"
                                      : "https://i.ibb.co/k4n8Qry/Banner.png",
                                  height: index == 0 || index == 3 ? 200 : 140,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          }),
                      const SizedBox(
                        height: 20,
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
