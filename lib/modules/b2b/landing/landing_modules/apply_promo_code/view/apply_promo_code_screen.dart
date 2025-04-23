import 'package:kgk/kgk.dart';

class ApplyPromoCodeScreen extends StatelessWidget {
  const ApplyPromoCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ApplyPromoCodeStyle style = AppTheme.of(context).applyPromoCodeStyle;
    final ApplyPromoCodeBloc bloc = BlocProvider.of<ApplyPromoCodeBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.coupons.tr),
      body: SafeArea(
        child: Column(
          children: [
            SmartTextField(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 16.h),
              controller: bloc.promoCodeController,
              hintText: APPStrings.hintPromoCode.tr,
              textInputAction: TextInputAction.done,
              onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
              suffixIcon: SmartText(
                APPStrings.apply.tr,
                onTap: () {
                  if (bloc.promoCodeController.text.isNullOrEmpty) return;
                  bloc.add(OnTapApplyPromoCodeEvent(context: context, promoCode: bloc.promoCodeController.text));
                },
                textAlign: TextAlign.center,
                optionalPadding: EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 12.h),
              ),
            ),
            Expanded(
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
                        Expanded(
                          child: Container(
                            padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 16.h),
                            color: style.backgroundColor,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (bloc.appliedPromoCode != null) ...[
                                    SmartText(APPStrings.appliedPromoCode.tr, style: style.titleStyle),
                                    SizedBox(height: 12.h),
                                    _buildApplyPromoCodeItem(
                                      model: bloc.appliedPromoCode!,
                                      style: style,
                                      context: context,
                                      bloc: bloc,
                                      isApplied: true,
                                    ),
                                    SizedBox(height: 20.h),
                                  ],
                                  SmartText(APPStrings.moreOffers.tr, style: style.titleStyle),
                                  ListView.separated(
                                    itemCount: bloc.applyPromoCodeList.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    separatorBuilder: (context, index) => SizedBox(height: 16.h),
                                    itemBuilder: (builderContext, index) {
                                      if (bloc.applyPromoCodeList[index] == bloc.appliedPromoCode) return SizedBox.shrink();
                                      return _buildApplyPromoCodeItem(
                                        model: bloc.applyPromoCodeList[index],
                                        style: style,
                                        context: context,
                                        bloc: bloc,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApplyPromoCodeItem({
    required ApplyPromoCodeModel model,
    required ApplyPromoCodeStyle style,
    required BuildContext context,
    required ApplyPromoCodeBloc bloc,
    bool isApplied = false,
  }) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: style.whiteColor,
        borderRadius: BorderRadius.circular(16.w),
        boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.2), blurRadius: 10.r, offset: Offset(0, 4))],
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
                      padding: EdgeInsetsDirectional.all(8.w),
                      decoration: BoxDecoration(color: style.orangeColor.withValues(alpha: 0.2), shape: BoxShape.circle),
                      child: Icon(Icons.local_offer_rounded, color: style.orangeColor, size: 18.w),
                    ),
                    SizedBox(width: 12.w),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SmartText(model.title ?? '', style: style.titleStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
                          SmartText(model.code, style: style.codeStyle),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (!isApplied) ...[
                _getApplyButton(
                  style,
                  icon: Icons.check_circle,
                  label: APPStrings.apply.tr,
                  onPressed: () {
                    bloc.add(OnTapApplyPromoCodeEvent(context: context, promoCode: model.code ?? ""));
                  },
                ),
              ] else ...[
                _getApplyButton(
                  style,
                  icon: Icons.close,
                  label: APPStrings.remove.tr,
                  onPressed: () {
                    bloc.add(OnTapRemovePromoCodeEvent(context: context));
                  },
                ),
              ],
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

  Widget _getApplyButton(ApplyPromoCodeStyle style, {required Function() onPressed, required IconData icon, required String label}) {
    final Throttle throttle = Throttle(milliseconds: 500);
    return ElevatedButton.icon(
      onPressed: () {
        throttle.run(onPressed);
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(60.w, 36.h),
        padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w, vertical: 2.h),
        backgroundColor: style.orangeColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.w)),
        elevation: 0,
      ),
      icon: Icon(icon, size: 14.w, color: style.whiteColor),
      label: SmartText(label, style: style.activeApplyTextStyle),
    );
  }
}
