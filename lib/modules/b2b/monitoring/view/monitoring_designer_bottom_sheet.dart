import 'package:kgk/kgk.dart';

class MonitoringDesignerBottomSheet extends StatelessWidget {
  final MonitoringBloc monitoringBloc;

  const MonitoringDesignerBottomSheet({super.key, required this.monitoringBloc});

  @override
  Widget build(BuildContext context) {
    MonitoringScreenStyle style = AppTheme.of(context).monitoringScreenStyle;
    return BlocProvider(
      create: (context) => monitoringBloc,
      child: SmartSingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            constraints: BoxConstraints(maxHeight: context.height * 0.8),
            width: context.width,
            decoration: BoxDecoration(
              color: style.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                _buildAppBar(style, context),
                SizedBox(height: 24.h),
                _buildDesignersSearchBar(context, monitoringBloc),
                SizedBox(height: 24.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17.5.w),
                  child: SmartText(
                    APPStrings.selectDesigner.tr,
                    style: style.subTitleStyle,
                  ),
                ),
                SizedBox(height: 16.h),
                _buildDesignerList(context, monitoringBloc, style),
                SizedBox(height: 16.h),
                const Divider(),
                SizedBox(height: 24.h),
                _buildBottomNavigationBar(monitoringBloc, context, style),
              ],
            ),
          )),
    );
  }

  Widget _buildDesignersSearchBar(BuildContext context, MonitoringBloc bloc) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.5.w),
      child: SmartTextField(
          controller: bloc.searchDesignersController,
          labelText: APPStrings.enterDesignerName.tr,
          hintText: APPStrings.enterDesignerName.tr,
          suffixIcon: SmartImage(
            path: AppImages.icSearchThin,
            padding: EdgeInsets.all(12.w),
          ),
          keyboardType: TextInputType.visiblePassword,
          focusNode: bloc.searchDesignersFocusNode,
          textInputAction: TextInputAction.done),
    );
  }

  Widget _buildAppBar(MonitoringScreenStyle style, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SmartText(
            APPStrings.assignDesigner.tr,
            style: style.bottomSheetTitleStyle,
          ),
          InkWell(
            onTap: () {
              context.pop();
            },
            child: SmartImage(
              path: AppImages.icCross,
              height: 24.w,
              width: 24.w,
              color: style.closeColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesignerList(BuildContext context, MonitoringBloc bloc, MonitoringScreenStyle style) {
    return BlocBuilder<MonitoringBloc, MonitoringState>(
      buildWhen: (previous, current) => current is MonitoringSelectedDesignerState,
      builder: (context, state) {
        if (bloc.designerList.isEmpty) {
          return NoDataFoundWidget(text: APPStrings.noDesignerFound.tr); // Adjust text based on the selected tab if necessary
        }
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 17.5.w),
          constraints: BoxConstraints(maxHeight: 340.h),
          child: ListView.separated(
            itemCount: bloc.designerList.length,
            padding: EdgeInsets.zero,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  bloc.add(MonitoringSelectedDesignerEvent(designer: bloc.designerList[index]));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.w),
                  child: Row(
                    children: [
                      SmartImage(
                        path: bloc.designerList[index].image,
                        height: 40.w,
                        width: 40.w,
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      SmartText(
                        bloc.designerList[index].name,
                        style: style.designerNameStyle,
                      ),
                      const Spacer(),
                      if (bloc.designerList[index].isSelected)
                        SmartImage(
                          path: AppImages.icCheck,
                          height: 24.w,
                          width: 24.w,
                        ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(MonitoringBloc bloc, BuildContext context, MonitoringScreenStyle style) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17.5.w),
        child: Row(
          children: [
            Expanded(
              child: SmartButton(
                onTap: () {
                  context.pop();
                },
                title: APPStrings.cancel.tr,
                activeBackgroundColor: style.whiteColor,
                titleStyle: style.addressNameStyle,
                activeImageColor: style.primaryColor,
              ),
            ),
            Expanded(
              child: SmartButton(
                onTap: () {
                  context.pop();
                },
                title: APPStrings.save.tr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
