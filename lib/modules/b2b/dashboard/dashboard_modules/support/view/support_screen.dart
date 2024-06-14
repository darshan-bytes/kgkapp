import 'package:kgk/kgk.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SmartText(
              'Diamond Filter',
              onTap: () {
                Utils.showSmartModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) {
                    BlocProvider.of<DiamondFilterBloc>(context).add(const LoadDiamondFilterDataEvent());
                    return DiamondFilterScreen(
                      onApply: () {},
                    );
                  },
                );
              },
            ),
            SizedBox(height: 20.h),
            SmartText(
              'Quotation Request Confirmation',
              onTap: () {
                Utils.showSmartModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) => QuotationRequestConfirmation(
                    onContinueShopping: () {
                      context.pop();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
