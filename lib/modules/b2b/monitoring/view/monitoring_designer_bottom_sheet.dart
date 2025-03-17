import 'package:kgk/kgk.dart';

class MonitoringDesignerBottomSheet extends StatelessWidget {
  final MonitoringBloc monitoringBloc;

  const MonitoringDesignerBottomSheet({super.key, required this.monitoringBloc});

  @override
  Widget build(BuildContext context) {
    MonitoringScreenStyle style = AppTheme.of(context).monitoringScreenStyle;
    return SmartSingleChildScrollView(
        padding: EdgeInsetsDirectional.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: context.height * 0.8,
          width: context.width,
          decoration: BoxDecoration(
            color: style.whiteColor,
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(12.r),
              topEnd: Radius.circular(12.r),
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
                padding: EdgeInsetsDirectional.symmetric(horizontal: 17.0.w),
                child: SmartText(
                  APPStrings.selectDesigner.tr,
                  style: style.subTitleStyle,
                ),
              ),
              SizedBox(height: 16.h),
              _buildDesignerList(context, monitoringBloc, style),
              SizedBox(height: 16.h),
              const Divider(),
              _buildBottomNavigationBar(monitoringBloc, context, style),
            ],
          ),
        ));
  }

  Widget _buildDesignersSearchBar(BuildContext context, MonitoringBloc bloc) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 17.5.w),
      child: SmartTextField(
          controller: bloc.searchDesignersController,
          labelText: APPStrings.enterDesignerName.tr,
          hintText: APPStrings.enterDesignerName.tr,
          onTapOutside: (p) {},
          suffixIcon: SmartImage(
            path: AppImages.icSearchThin,
            padding: EdgeInsetsDirectional.all(14.w),
          ),
          focusNode: bloc.searchDesignersFocusNode,
          textInputAction: TextInputAction.done),
    );
  }

  Widget _buildAppBar(MonitoringScreenStyle style, BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 17.5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SmartText(
            APPStrings.assignDesigner.tr,
            style: style.bottomSheetTitleStyle,
          ),
          SmartImage(
            path: AppImages.icCross,
            height: 24.w,
            width: 24.w,
            color: style.closeColor,
            onTap: () {
              context.pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDesignerList(BuildContext context, MonitoringBloc bloc, MonitoringScreenStyle style) {
    return BlocBuilder<MonitoringBloc, MonitoringState>(
      buildWhen: (previous, current) =>
          current is MonitoringSelectedDesignerState ||
          current is MonitoringDesignerLoadMoreState ||
          current is MonitoringDesignerListLoadedState,
      builder: (context, state) {
        if (bloc.designerList.isEmpty) {
          return NoDataFoundWidget(text: APPStrings.noDesignerFound.tr); // Adjust text based on the selected tab if necessary
        }
        return Expanded(
            child: ListView.separated(
          itemCount: bloc.designerList.length,
          controller: bloc.designerScrollController.scrollController,
          padding: EdgeInsetsDirectional.symmetric(horizontal: 17.5.w),
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    bloc.add(MonitoringSelectedDesignerEvent(designer: bloc.designerList[index]));
                  },
                  child: Padding(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 12.w),
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
                        SmartCheckbox(
                            value: bloc.designerList[index].isSelected,
                            onChanged: (value) {
                              bloc.add(MonitoringSelectedDesignerEvent(designer: bloc.designerList[index]));
                            })
                      ],
                    ),
                  ),
                ),
                if (state is MonitoringDesignerLoadMoreState && index == monitoringBloc.designerList.length - 1)
                  const SmartCircularProgressIndicator(),
              ],
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        ));
      },
    );
  }

  Widget _buildBottomNavigationBar(MonitoringBloc bloc, BuildContext context, MonitoringScreenStyle style) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 17.5.w, vertical: 24.h),
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
          SizedBox(
            width: 16.w,
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
    );
  }
}
