import 'package:kgk/kgk.dart';
import 'package:kgk/widgets/cart_product_item.dart';

class MyBagScreen extends StatelessWidget {
  const MyBagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MyBagBloc bloc = BlocProvider.of<MyBagBloc>(context);
    final MyBagScreenStyle style = AppTheme.of(context).myBagScreenStyle;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppConst.appBarHeight,
        child: BlocBuilder<MyBagBloc, MyBagState>(
          builder: (context, state) {
            return SmartAppBar(
              title: APPStrings.myBag.tr,
              isBack: false,
              onFilter: () {},
              onFavorite: () {},
            );
          },
        ),
      ),
      body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
        children: [const SizedBox(height: 24), _buildMyBagList(bloc)],
      ))),
    );
  }

  Widget _buildMyBagList(MyBagBloc bloc) {
    return BlocBuilder<MyBagBloc, MyBagState>(
      builder: (context, state) {
        if (bloc.myBagProductList.isEmpty) {
          return Center(child: SmartText(APPStrings.myBagEmpty.tr));
        } else {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            itemBuilder: (context, index) => CartProductItem(
              selectedQuality: "18K Gold",
              selectedQuantity: 10,
              margin: const EdgeInsets.only(bottom: 17),
              onEyeTap: () {},
              onFavTap: () {},
              onAddToBagTap: () {},
              onTap: () {},
              productDetails: bloc.myBagProductList[index],
            ),
            itemCount: bloc.myBagProductList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          );
        }
      },
    );
  }
}
