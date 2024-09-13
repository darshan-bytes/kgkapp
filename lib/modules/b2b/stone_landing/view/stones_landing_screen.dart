import 'package:kgk/kgk.dart';

class StonesLandingScreen extends StatelessWidget {
  const StonesLandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StonesLandingBloc bloc = BlocProvider.of<StonesLandingBloc>(context);
    final HomeScreenStyle homeScreenStyle = AppTheme.of(context).homeScreenStyle;
    final StonesLandingScreenStyle style = AppTheme.of(context).stonesLandingScreenStyle;

    return BlocBuilder<StonesLandingBloc, StonesLandingState>(
      buildWhen: (previous, current) => current is InitialStoneLandingState,
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(bloc, context, style),
          body: SafeArea(
            child: _getBody(context, bloc, style, homeScreenStyle),
            //  child: ListView(
            //    shrinkWrap: true,
            //    children: [_getBody(context, bloc, style, homeScreenStyle)],
            //  ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(StonesLandingBloc bloc, BuildContext context, StonesLandingScreenStyle style) {
    return SmartAppBar(
      title: bloc.appbarTitle,
      backgroundColor: style.whiteColor,
      onSearch: () => context.pushNamed(AppRoutes.searchPage),
      onFavorite: () => context.pushNamed(AppRoutes.wishListPage),
    );
  }

  Widget _getBody(BuildContext context, StonesLandingBloc bloc, StonesLandingScreenStyle style, HomeScreenStyle homeScreenStyle) {
    switch (bloc.screenIdentifier) {
      case ScreenIdentifier.landingForDiamonds:
        return DiamondLandingScreen(bloc: bloc, style: style, homeScreenStyle: homeScreenStyle);
      case ScreenIdentifier.landingForGemstones:
        return GemstoneLandingScreen(bloc: bloc, style: style, homeScreenStyle: homeScreenStyle);
      case ScreenIdentifier.landingForJewellery:
        return JewelleryLandingScreen(bloc: bloc, style: style, homeScreenStyle: homeScreenStyle);
      default:
        return DiamondLandingScreen(bloc: bloc, style: style, homeScreenStyle: homeScreenStyle);
    }
  }
}
