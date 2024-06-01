import 'package:kgk/kgk.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SmartText('Add Account', onTap: () {
          context.pushNamed(AppRoutes.addressListPage);
        }),
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
        ElevatedButton(
          onPressed: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => DiamondPurchaseSheet(),
          ),
          child: Text('Show Bottom Sheet'),
        )
      ]),
    );
  }
}

// class MyBottomSheet extends StatefulWidget {
//   @override
//   MyBottomSheetState createState() => MyBottomSheetState();
// }
//
// class _MyBottomSheetState extends State<MyBottomSheet> {
//   List<String> additionalData = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           for (String data in additionalData.reversed) ...[
//             Container(
//               color: Colors.green,
//               padding: EdgeInsets.all(16.0),
//               child: Text(
//                 data,
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//           Container(
//             color: Colors.blue,
//             padding: EdgeInsets.all(16.0),
//             child: Text(
//               "Sticky Data",
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 additionalData.add("Additional Data ${additionalData.length + 1}");
//               });
//             },
//             child: Text("Add Additional Data"),
//           ),
//         ],
//       ),
//     );
//   }
// }

class DiamondPurchaseSheet extends StatelessWidget {
  const DiamondPurchaseSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final SortStyle style = AppTheme.of(context).sortStyle;
    return Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SmartAppBar(
              isBack: false,
              titleStyle: style.titleStyle,
              isBorder: false,
              backgroundColor: const Color(0xFFFFFFFF),
              appBarHeight: kToolbarHeight,
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const SmartImage(path: AppImages.icCross),
                ),
              ],
            ),
            SmartText("text")
            // ListView.builder(
            //   padding: const EdgeInsets.symmetric(vertical: 16),
            //   shrinkWrap: true,
            //   itemCount: sortFilterBloc.sortData.length,
            //   itemBuilder: (context, index) {
            //     final sortData = sortFilterBloc.sortData[index];
            //     return InkWell(
            //       onTap: () {
            //         sortFilterBloc.add(SelectSortDataEvent(sortData: sortData));
            //         Navigator.of(context).pop();
            //       },
            //       child: Container(
            //         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            //         child: Row(
            //           children: [
            //             Expanded(
            //               child: SmartText(
            //                 sortData.name,
            //                 style: style.itemTitleStyle,
            //               ),
            //             ),
            //             if (sortFilterBloc.selectedSortData.code == sortData.code) const SmartImage(path: AppImages.icCheck),
            //           ],
            //         ),
            //       ),
            //     );
            //   },
            // ),
          ],
        ));
  }

  Widget _buildYourOrderSummary(OrderConfirmationStyle style) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SmartText(
          APPStrings.yourOrderNumber.tr,
          style: style.subTitleStyle,
        ),
        SmartText(
          "",
          style: style.orderNumberStyle,
        ),
      ],
    );
  }
}
