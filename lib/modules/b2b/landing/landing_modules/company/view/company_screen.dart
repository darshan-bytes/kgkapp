import 'package:kgk/kgk.dart';

class CompanyScreen extends StatelessWidget {
  const CompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CompanyScreenStyle style = AppTheme.of(context).companyScreenStyle;
    final CompanyBloc bloc = BlocProvider.of<CompanyBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(
        isBack: false,
        leadingImage: AppImages.icHeaderLogoGet,
        onFavorite: () {
          context.pushNamed(AppRoutes.wishListPage);
        },
        onNotification: () {
          context.pushNamed(AppRoutes.notificationPage);
        },
      ),
      body: SafeArea(
        child: BlocBuilder<CompanyBloc, CompanyState>(
          buildWhen: (previous, current) => current is CompanyListLoadedState,
          builder: (context, state) {
            if (state is! CompanyListLoadedState) return const SizedBox.shrink();
            return SmartSingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 14.0.w, horizontal: 14.0.w),
                    child: SmartText(APPStrings.selectACompany.tr, style: style.titleStyle),
                  ),
                  _buildCompanyList(style, bloc),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 16.h),
        child: SmartButton(
          title: APPStrings.viewDashboard.tr,
          onTap: () {
            context.pushNamed(AppRoutes.dashboardPage);
          },
        ),
      ),
    );
  }

  Widget _buildCompanyList(CompanyScreenStyle style, CompanyBloc bloc) {
    return BlocBuilder<CompanyBloc, CompanyState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: bloc.companyList.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsetsDirectional.only(top: 16.h, bottom: 8.h),
          primary: false,
          itemBuilder: (context, index) {
            final CscDetails companyListData = bloc.companyList[index];
            return Column(
              children: [
                BlocBuilder<CompanyBloc, CompanyState>(
                  buildWhen: (previous, current) => current is SelectCompanyListState,
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        bloc.add(SelectCompanyListEvent(index));
                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.symmetric(vertical: 12.0.h, horizontal: 16.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Below code is commented because the image is not available
                            /*SmartImage(
                            path: bloc.companyList[index].image ?? '',
                            height: 40.w,
                            width: 40.w,
                          ),
                          SizedBox(width: 12.0.w),*/
                            Expanded(child: SmartText(bloc.companyList[index].cscName, style: style.textStyle)),
                            if (bloc.selectData == companyListData) SmartImage(path: AppImages.icGreenCheck, height: 24.w, width: 24.w),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Divider(indent: 16.w, endIndent: 16.w), // Add divider between items
              ],
            );
          },
        );
      },
    );
  }
}
