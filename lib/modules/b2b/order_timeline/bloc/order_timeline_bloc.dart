import 'package:kgk/kgk.dart';

part 'order_timeline_event.dart';

part 'order_timeline_state.dart';

class OrderTimelineBloc extends Bloc<OrderTimelineEvent, OrderTimelineState> {
  List<OrderTimelineDataModel> timelineList = [];

  OrderTimelineBloc() : super(OrderTimelineInitialState()) {
    on<InitialOrderTimelineEvent>(_onInitialOrderTimelineEvent);
  }

  void _onInitialOrderTimelineEvent(InitialOrderTimelineEvent event, Emitter<OrderTimelineState> emit) {
    timelineList.addAll(
      List.generate(
        10,
        (index) => OrderTimelineDataModel(
          title: 'Pulvinar sollicitudin nibh',
          description:
              'Lorem ipsum dolor sit amet consectetur. Pulvinar sollicitudin nibh eget interdum sit accumsan ornare. Lorem ipsum dolor',
          time: '9:30PM',
          dateTime: index < 2 ? "2024-06-13 19:20:52.394" : "2024-06-${(13 - index) > 9 ? (13 - index) : "0${13 - index}"} 19:20:52.394",
        ),
      ),
    );
    emit(OrderTimelineLoadedState(timelineList));
  }

  /// Checks if the date should be displayed for a given timeline item.
  ///
  /// This function is used to determine whether the date should be displayed for a timeline item at a given index.
  /// The date is displayed if the timeline item is the first item or if its date is after the date of the previous item.
  /// If the date should be displayed, it is formatted as "Today", "Yesterday", or a specific date with a suffix.
  ///
  /// Parameters:
  /// - `index`: the index of the timeline item to check.
  ///
  /// Returns:
  /// - A tuple where the first item is a boolean indicating whether the date should be displayed,
  ///   and the second item is the formatted date string (or an empty string if the date should not be displayed).
  (bool, String) checkIfDisplayDate(int index) {
    bool isDisplayData = index == 0 || (timelineList[index - 1].dateTimeObject.isAfter(timelineList[index].dateTimeObject));
    String date = '';
    if (isDisplayData) {
      timelineList[index].dateTimeObject.isToday
          ? date = APPStrings.today.tr
          : ((timelineList[index].dateTimeObject.isYesterday)
              ? date = APPStrings.yesterday.tr
              : date = timelineList[index].dateTimeObject.formatDateWithSuffix);
    }

    return (isDisplayData, date);
  }
}
