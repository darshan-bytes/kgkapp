import 'package:kgk/kgk.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            height: 60.h,
          ),
          SmartText(
            'View All Collection',
            onTap: () {
              context.pushNamed(AppRoutes.collectionPage);
            },
          ),
          SmartText(
            'Order Confirmation',
            onTap: () {
              context.pushNamed(AppRoutes.orderConfirmationPage, arguments: {RoutesData.orderNumber: "3000000049"});
            },
          ),
          SmartText(
            'Diamond info popup screen',
            onTap: () {
              context.pushNamed(AppRoutes.diamondInfoPopupPage);
            },
          ),
          SmartText(
            'Write a review screen',
            onTap: () {
              context.pushNamed(AppRoutes.writeReviewPage);
            },
          ),
          SmartText(
            'Product Menu Bottom Sheet',
            onTap: () async {
              await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                builder: (context) => const ProductMenuBottomSheet(),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(17),
            child: ProductInfoItem(
                onTap360View: () => printWrapped("onTap360View"),
                onTapDNA: () => printWrapped("onTapDNA"),
                onTapCertificate: () => printWrapped("onTapCertificate"),
                onTapImageViewer: () => printWrapped("onTapImageViewer"),
                onTapUSA: () => printWrapped("onTapUSA"),
                onTapMenuButton: () => printWrapped("onTapMenuButton"),
                productDetails: ProductDetails(
                  productInfoClarityChat: ProductInfoClarityChat(
                    productId: "1",
                    productName: "1.00 Cts Round Diamond",
                    ct: "10.04",
                    shape: "Marquise",
                    colour: "H",
                    clarity: "VVS1",
                    lotNumber: "MBFG716306",
                    certificateNumber: "230000066395",
                    measurements: "10.18 x 8.34 x 6.14",
                    lab: "GIA",
                    cut: "Excellent",
                    polish: "Excellent",
                    symmetry: "Excellent",
                    flourish: "O",
                    tablePercentage: "50",
                    depthPercentage: "50",
                    rap: "\$35,500.00",
                    discount: "-30.00",
                    perCts: "\$24,850.00",
                    amount: "\$1,24,995.50",
                  ),
                  productId: "1",
                  diamond: "1.5 gram",
                  gram: "1.5 gram",
                  imageUrl: "https://i.ibb.co/swb5gVs/Round.png",
                )),
          )
        ]),
      ),
    );
  }
}
