import 'package:kgk/kgk.dart';

class OrderTimelineScreen extends StatelessWidget {
  const OrderTimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderTimelineStyle style = AppTheme.of(context).orderTimelineStyle;
    OrderTimelineBloc orderTimelineBloc = BlocProvider.of<OrderTimelineBloc>(context);
    return Scaffold(
      backgroundColor: style.whiteColor,
      appBar: SmartAppBar(title: APPStrings.orderTimeline.tr),
      body: Container(
        padding: EdgeInsetsDirectional.all(16.w),
        child: BlocBuilder<OrderTimelineBloc, OrderTimelineState>(
          buildWhen: (previous, current) => current is OrderTimelineLoadedState,
          builder: (context, state) {
            return ListView.separated(
              itemCount: orderTimelineBloc.timelineList.length,
              itemBuilder: (context, index) {
                final OrderTimelineDataModel timelineList = orderTimelineBloc.timelineList[index];
                (bool, String) isDisplayData = orderTimelineBloc.checkIfDisplayDate(index);
                Widget child = OrderTimeLineWidget(timelineData: timelineList);
                return isDisplayData.$1
                    ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22.r),
                            border: Border.all(color: style.dateTagBorderColor),
                          ),
                          child: SmartText(isDisplayData.$2, style: style.dateTagStyle, textAlign: TextAlign.center),
                        ),
                        SizedBox(height: 16.h),
                        child,
                      ],
                    )
                    : child;
              },
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
            );
          },
        ),
      ),
    );
  }
}

class OrderTimeLineWidget extends StatelessWidget {
  final OrderTimelineDataModel timelineData;

  const OrderTimeLineWidget({super.key, required this.timelineData});

  @override
  Widget build(BuildContext context) {
    final OrderTimelineStyle style = AppTheme.of(context).orderTimelineStyle;
    return Container(
      padding: EdgeInsetsDirectional.all(16.w),
      decoration: BoxDecoration(color: style.backgroundColor, borderRadius: BorderRadius.circular(6.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          SmartText(timelineData.title, style: style.titleStyle),
          SizedBox(height: 4.h),
          SmartText(timelineData.description, style: style.subTitleStyle),
          SizedBox(height: 16.h),
          SmartText(timelineData.time, style: style.timeStyle),
        ],
      ),
    );
  }
}
