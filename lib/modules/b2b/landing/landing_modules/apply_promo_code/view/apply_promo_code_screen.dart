import 'package:kgk/kgk.dart';

class ApplyPromoCodeScreen extends StatelessWidget {
  ApplyPromoCodeScreen({super.key});

  final TextEditingController promoCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ApplyPromoCodeStyle style = AppTheme.of(context).applyPromoCodeStyle;
    final ApplyPromoCodeBloc bloc = BlocProvider.of<ApplyPromoCodeBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.coupons.tr),
      body: SafeArea(
        child: BlocBuilder<ApplyPromoCodeBloc, ApplyPromoCodeState>(
          buildWhen: (previous, current) => current is ApplyPromoCodeLoadedState || current is ApplyPromoCodeLoadingState,
          builder: (context, state) {
            if (state is ApplyPromoCodeLoadingState) {
              return const SmartCircularProgressIndicator();
            }
            if (state is ApplyPromoCodeLoadedState) {
              if (bloc.applyPromoCodeList.isNullOrEmpty) {
                return const NoDataFoundWidget();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmartTextField(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    controller: promoCodeController,
                    hintText: APPStrings.hintPromoCode.tr,
                    textInputAction: TextInputAction.done,
                    suffixIcon: SmartText(APPStrings.apply.tr, onTap: () {
                      context.pop(arguments: {RoutesData.promoCode: promoCodeController.text});
                    }, textAlign: TextAlign.center, optionalPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h)),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                      color: style.backgroundColor,
                      child: ListView.separated(
                        itemCount: bloc.applyPromoCodeList.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        separatorBuilder: (context, index) => SizedBox(height: 16.h),
                        itemBuilder: (context, index) {
                          Widget header = SmartText(APPStrings.moreOffers.tr, style: style.titleStyle);
                          if (index == 0) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                header,
                                SizedBox(height: 12.h),
                                _buildApplyPromoCodeItem(model: bloc.applyPromoCodeList[index], style: style, context: context),
                              ],
                            );
                          }
                          return _buildApplyPromoCodeItem(model: bloc.applyPromoCodeList[index], style: style, context: context);
                        },
                      ),
                    ),
                  )
                ],
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildApplyPromoCodeItem({required ApplyPromoCodeModel model, required ApplyPromoCodeStyle style, required BuildContext context}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: style.whiteColor,
        borderRadius: BorderRadius.circular(16.w),
        boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.2), blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(color: style.orangeColor.withValues(alpha: 0.2), shape: BoxShape.circle),
                      child: Icon(Icons.local_offer_rounded, color: style.orangeColor, size: 18.w),
                    ),
                    SizedBox(width: 12.w),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SmartText(model.title ?? '', style: style.titleStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
                          SmartText(model.code, style: style.codeStyle)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Apply Button
              ElevatedButton.icon(
                onPressed: () {
                  context.pop(arguments: {RoutesData.promoCode: model.code});
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(60.w, 30.h),
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
                  backgroundColor: style.orangeColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.w)),
                  elevation: 0,
                ),
                icon: Icon(Icons.check_circle, size: 14.w, color: style.whiteColor),
                label: SmartText(APPStrings.apply.tr, style: style.activeApplyTextStyle),
              )
            ],
          ),
          SizedBox(height: 6.h),
          Divider(),
          SizedBox(height: 6.h),
          SmartText(model.description, style: style.descriptionStyle, maxLines: 2, overflow: TextOverflow.ellipsis),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.calendar_month, size: 16.w, color: style.orangeColor),
              SizedBox(width: 8.w),
              SmartText(model.offerValidTillEXT, style: style.descriptionStyle),
            ],
          ),
        ],
      ),
    );
  }
}
