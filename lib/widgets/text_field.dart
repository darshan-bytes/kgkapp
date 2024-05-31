import 'package:kgk/kgk.dart';

class SmartTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextStyle? style;
  final String? hintText;
  final TextStyle? hintStyle;
  final EdgeInsets? padding;
  final String? labelStyle;
  final TextStyle? lableStyle;
  final String? errorText;
  final bool obscured;
  final bool readOnly;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final Iterable<String>? autofillHints;
  final Color? color;
  final EdgeInsets? contentPadding;
  final Function(String)? onValueChanges;
  final Function(String)? onFieldSubmitted;
  final Function(String)? validator;
  final List<TextInputFormatter>? textInputFormatter;
  final double? height;
  final int? maxLines;
  final int? maxLength;
  final bool? expand;
  final TextStyle? errorStyle;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final bool? isEnabled;
  final bool? isRequired;
  final double? enabledBorderRadius;
  final Color? enabledBorderColor;
  final Color? disabledBorderColor;
  final bool autofocus;
  final TapRegionCallback? onTapOutside;
  final VoidCallback? onEditingComplete;

  const SmartTextField({
    super.key,
    this.controller,
    this.hintText,
    this.obscured = false,
    this.readOnly = false,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.autofillHints,
    this.color,
    this.onValueChanges,
    this.onFieldSubmitted,
    this.validator,
    this.textInputFormatter,
    this.contentPadding,
    this.errorText,
    this.hintStyle,
    String? labelText,
    this.lableStyle,
    this.padding,
    this.maxLines,
    this.maxLength,
    this.expand,
    this.height,
    this.style,
    this.errorStyle,
    this.suffixIcon,
    this.focusNode,
    this.nextFocus,
    this.isEnabled,
    this.isRequired,
    this.prefixIcon,
    this.enabledBorderRadius,
    this.enabledBorderColor,
    this.disabledBorderColor,
    this.autofocus = false,
    this.onTapOutside,
    this.onEditingComplete,
  }) : labelStyle = labelText != null ? '$labelText${isRequired == true ? ' *' : ''}' : null;

  const SmartTextField.search({
    super.key,
    this.controller,
    this.hintText,
    this.obscured = false,
    this.readOnly = false,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.autofillHints,
    this.color,
    this.onValueChanges,
    this.onFieldSubmitted,
    this.validator,
    this.textInputFormatter,
    this.contentPadding,
    this.errorText,
    this.hintStyle,
    String? labelText,
    this.lableStyle,
    this.padding,
    this.maxLines,
    this.maxLength,
    this.expand,
    this.height,
    this.style,
    this.errorStyle,
    this.suffixIcon,
    this.focusNode,
    this.nextFocus,
    this.isEnabled,
    this.isRequired,
    this.enabledBorderRadius,
    this.enabledBorderColor,
    this.disabledBorderColor,
    this.autofocus = false,
    this.onTapOutside,
    this.onEditingComplete,
  })  : labelStyle = labelText != null ? '$labelText${isRequired == true ? ' *' : ''}' : null,
        prefixIcon = const FittedBox(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: SmartImage(
              path: AppImages.icSearch,
              height: 16,
              width: 16,
            ),
          ),
        );

  @override
  State<SmartTextField> createState() => SmartTextFieldState();
}

class SmartTextFieldState extends State<SmartTextField> {
  bool _passwordVisible = false;

  void _toggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).textFieldStyle;
    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.labelStyle != null) ...[
            SmartText(
              widget.labelStyle!,
              style: style.labelStyle.merge(widget.lableStyle),
            ),
            SizedBox(height: 8.h),
          ],
          SizedBox(
            height: widget.height ?? 48.h,
            child: TextFormField(
              autofocus: widget.autofocus,
              style: style.textStyle.merge(widget.style),
              onTapOutside: (p) {
                FocusScope.of(context).unfocus();
                if (widget.onTapOutside != null) {
                  widget.onTapOutside!(p);
                }
              },
              textCapitalization: widget.textCapitalization,
              maxLength: widget.maxLength,
              readOnly: widget.readOnly,
              maxLines: widget.maxLines ?? 1,
              focusNode: widget.focusNode,
              enabled: widget.isEnabled ?? true,
              cursorColor: style.blackColor,
              controller: widget.controller,
              decoration: InputDecoration(
                  errorMaxLines: 6,
                  counterText: '',
                  filled: true,
                  errorStyle: style.errorStyle.merge(widget.errorStyle),
                  fillColor: widget.color ?? style.textFillColor,
                  contentPadding: widget.contentPadding ?? EdgeInsets.all(16.w),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.r)),
                      borderSide: BorderSide(color: widget.disabledBorderColor ?? style.disabledTextFieldBorderColor)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(widget.enabledBorderRadius ?? 4.r)),
                    borderSide: BorderSide(
                      color: widget.enabledBorderColor ?? style.enabledTextFieldBorderColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: style.focusedTextFieldBorderColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(4.r))),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: style.errorBorderColor), borderRadius: BorderRadius.all(Radius.circular(4.r))),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: style.errorBorderColor), borderRadius: BorderRadius.all(Radius.circular(4.r))),
                  hintText: widget.hintText,
                  errorText: widget.errorText,
                  hintStyle: style.hintStyle.merge(widget.hintStyle),
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: widget.suffixIcon ??
                      (widget.obscured
                          ? IconButton(
                              icon: _passwordVisible
                                  ? const SmartImage(
                                      path: AppImages.icEyeOpen,
                                    )
                                  : SmartImage(
                                      path: AppImages.icEyeClose,
                                      width: 16.w,
                                      height: 16.w,
                                    ),
                              onPressed: _toggle,
                            )
                          : null)),
              obscureText: widget.obscured && _passwordVisible ? false : widget.obscured,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              autocorrect: false,
              autofillHints: widget.autofillHints,
              inputFormatters: widget.textInputFormatter ?? [],
              onChanged: (value) {
                if (widget.onValueChanges != null) {
                  widget.onValueChanges!(value);
                }
              },
              onFieldSubmitted: (value) {
                if (widget.nextFocus != null) {
                  FocusScope.of(context).requestFocus(widget.nextFocus);
                }
                if (widget.onFieldSubmitted != null) {
                  widget.onFieldSubmitted!(value);
                }
              },
              onEditingComplete: widget.onEditingComplete,
            ),
          ),
        ],
      ),
    );
  }
}
