import 'package:kgk/kgk.dart';

class SmartRefreshIndicator extends StatefulWidget {
  final Widget child;
  final RefreshCallback onRefresh;
  final Color? color;
  final Color? backgroundColor;
  final double strokeWidth;
  final String? semanticsLabel;
  final String? semanticsValue;

  const SmartRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.color,
    this.backgroundColor,
    this.strokeWidth = 2.0,
    this.semanticsLabel,
    this.semanticsValue,
  });

  @override
  SmartRefreshIndicatorState createState() => SmartRefreshIndicatorState();
}

class SmartRefreshIndicatorState extends State<SmartRefreshIndicator> {
  bool _isIndicatorAtTop = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollStartNotification) {
          _isIndicatorAtTop = notification.metrics.pixels == 0;
        }
        return false;
      },
      child: RefreshIndicator.adaptive(
        onRefresh: widget.onRefresh,
        color: widget.color,
        backgroundColor: widget.backgroundColor,
        strokeWidth: widget.strokeWidth,
        semanticsLabel: widget.semanticsLabel,
        semanticsValue: widget.semanticsValue,
        child: widget.child,
      ),
    );
  }

  Widget buildRefreshIndicator(
      BuildContext context,
      RefreshIndicatorMode refreshState,
      double pulledExtent,
      double refreshTriggerPullDistance,
      double refreshIndicatorExtent,
      AxisDirection axisDirection,
      bool float,
      Duration completeDuration,
      bool isDone) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.only(top: _isIndicatorAtTop ? pulledExtent : 0.0),
              child: refreshState == RefreshIndicatorMode.refresh
                  ? const CircularProgressIndicator.adaptive()
                  : Icon(
                      refreshState == RefreshIndicatorMode.drag ? Icons.refresh : Icons.done,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
