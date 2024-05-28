import 'package:kgk/kgk.dart';

class SmartRatingBar extends StatelessWidget {
  final double initialRating;
  final Axis? direction;
  final bool? allowHalfRating;
  final bool? ignoreGestures;
  final int? itemCount;
  final double itemSize;
  final EdgeInsets? itemPadding;
  final Color? fillStarColor;
  final Color? emptyStarColor;
  final Function(double) onRatingUpdate;

  const SmartRatingBar({
    super.key,
    required this.initialRating,
    this.direction,
    this.allowHalfRating,
    this.ignoreGestures,
    this.itemCount,
    required this.itemSize,
    this.itemPadding,
    this.fillStarColor,
    this.emptyStarColor,
    required this.onRatingUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).ratingbarStyle;
    return RatingBar.builder(
      initialRating: initialRating,
      ignoreGestures: ignoreGestures ?? false,
      direction: direction ?? Axis.horizontal,
      allowHalfRating: allowHalfRating ?? false,
      itemCount: itemCount ?? 5,
      itemSize: itemSize,
      itemPadding: itemPadding ?? EdgeInsets.zero,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: fillStarColor ?? style.fillStarColor,
      ),
      onRatingUpdate: onRatingUpdate,
    );
  }
}
