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
              title: APPStrings.ring.tr,
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
          return const Center(child: SmartText(APPStrings.add));
        } else {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            itemBuilder: (context, index) => CartProductItem(
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
