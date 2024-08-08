import 'package:kgk/kgk.dart';

const Duration _kExpand = Duration(milliseconds: 200);

class SmartExpansionTile extends StatefulWidget {
  const SmartExpansionTile({
    super.key,
    this.leading,
    required this.title,
    this.backgroundColor,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.trailing,
    this.initiallyExpanded = false,
    this.trailingCollapsedIconVisible = true,
  });

  final Widget? leading;
  final Widget title;
  final ValueChanged<bool>? onExpansionChanged;
  final List<Widget> children;
  final Color? backgroundColor;
  final Widget? trailing;
  final bool? initiallyExpanded;
  final bool trailingCollapsedIconVisible;

  @override
  SmartExpansionTileState createState() => SmartExpansionTileState();
}

class SmartExpansionTileState extends State<SmartExpansionTile> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  CurvedAnimation? _easeOutAnimation;
  CurvedAnimation? _easeInAnimation;
  ColorTween? _borderColor;
  ColorTween? _headerColor;
  ColorTween? _iconColor;
  ColorTween? _backgroundColor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _easeOutAnimation = CurvedAnimation(parent: _controller!, curve: Curves.easeOut);
    _easeInAnimation = CurvedAnimation(parent: _controller!, curve: Curves.easeIn);
    _borderColor = ColorTween();
    _headerColor = ColorTween();
    _iconColor = ColorTween();
    _backgroundColor = ColorTween();

    _isExpanded = PageStorage.of(context).readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) {
      _controller?.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void expand() {
    _setExpanded(true);
  }

  void collapse() {
    _setExpanded(false);
  }

  void toggle() {
    _setExpanded(!_isExpanded);
  }

  void _setExpanded(bool isExpanded) {
    if (_isExpanded != isExpanded) {
      setState(() {
        _isExpanded = isExpanded;
        if (_isExpanded) {
          _controller?.forward();
        } else {
          _controller?.reverse().then<void>((value) {
            setState(() {
              // Rebuild without widget.children.
            });
          });
        }
        PageStorage.of(context).writeState(context, _isExpanded);
      });
      widget.onExpansionChanged?.call(_isExpanded);
    }
  }

  Widget? _buildTrailing() {
    if (widget.trailing != null) {
      return widget.trailing;
    } else if (widget.trailingCollapsedIconVisible) {
      return _isExpanded ? const SmartImage(path: AppImages.icArrowUp) : const SmartImage(path: AppImages.icArrowDown);
    }
    return null;
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    final Color titleColor = _headerColor!.evaluate(_easeInAnimation!)!;
    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor?.evaluate(_easeOutAnimation!) ?? Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          IconTheme.merge(
            data: IconThemeData(color: _iconColor?.evaluate(_easeInAnimation!)),
            child: ListTile(
              onTap: toggle,
              contentPadding: EdgeInsets.zero,
              leading: widget.leading,
              title: DefaultTextStyle(
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: titleColor),
                child: widget.title,
              ),
              trailing: _buildTrailing(),
            ),
          ),
          ClipRect(
            child: Align(
              alignment: Alignment.centerLeft,
              heightFactor: _easeInAnimation?.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    _borderColor?.end = theme.dividerColor;
    _headerColor
      ?..begin = theme.textTheme.headlineMedium!.color
      ..end = theme.colorScheme.primary;
    _iconColor
      ?..begin = theme.unselectedWidgetColor
      ..end = theme.colorScheme.primary;
    _backgroundColor?.begin = widget.backgroundColor;
    _backgroundColor?.end = widget.backgroundColor;

    final bool closed = !_isExpanded && (_controller?.isDismissed == true);
    return AnimatedBuilder(
      animation: _controller!.view,
      builder: _buildChildren,
      child: closed ? null : Column(crossAxisAlignment: CrossAxisAlignment.start, children: widget.children),
    );
  }
}
