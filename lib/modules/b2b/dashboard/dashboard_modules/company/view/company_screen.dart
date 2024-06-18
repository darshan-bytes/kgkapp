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
        leadingImage: "https://i.ibb.co/cyvpMrR/KGK-Group-Logo-1.png",
        onFavorite: () {
          context.pushNamed(AppRoutes.wishListPage);
        },
        onNotification: () {
          context.pushNamed(AppRoutes.notificationPage);
        },
      ),
      body: SafeArea(
        child: SmartSingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 14.0.w, horizontal: 14.0.w),
                child: SmartText(
                  APPStrings.selectACompany.tr,
                  style: style.titleStyle,
                ),
              ),
              _buildCompanyList(style, bloc),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompanyList(CompanyScreenStyle style, CompanyBloc bloc) {
    return BlocBuilder<CompanyBloc, CompanyState>(builder: (context, state) {
      return ListView.separated(
        itemCount: bloc.companyList.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
        primary: false,
        itemBuilder: (context, index) {
          final CompanyListModel companyListData = bloc.companyList[index];
          return BlocBuilder<CompanyBloc, CompanyState>(
            buildWhen: (previous, current) => current is SelectCompanyListState && (current.index == index || current.oldIndex == index),
            builder: (context, state) {
              return InkWell(
                onTap: () {
                  bloc.add(SelectCompanyListEvent(index));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0.h, horizontal: 16.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SmartImage(
                        path: bloc.companyList[index].image ?? '',
                        height: 40.w,
                        width: 40.w,
                      ),
                      SizedBox(width: 12.0.w),
                      Expanded(
                        child: SmartText(
                          bloc.companyList[index].title,
                          style: style.textStyle,
                        ),
                      ),
                      if (bloc.selectData == companyListData)
                        SmartImage(
                          path: AppImages.icGreenCheck,
                          height: 24.w,
                          width: 24.w,
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        separatorBuilder: (context, index) => Divider(
          indent: 16.w,
          endIndent: 16.w,
        ),
      );
    });
  }
}
