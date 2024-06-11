import 'package:kgk/kgk.dart';

class SmartTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextStyle? style;
  final String? hintText;
  final TextStyle? hintStyle;
  final EdgeInsets? padding;
  final String? labelText;
  final TextStyle? labelStyle;
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
  final String? suffixText;
  final BorderRadius? borderRadius;
  final bool isSearch;
  final InputBorder? customEnabledBorder;
  final InputBorder? customDisabledBorder;
  final InputBorder? customFocusedBorder;
  final InputBorder? customErrorBorder;
  final InputBorder? customFocusedErrorBorder;

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
    this.labelStyle,
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
    this.borderRadius,
    this.customEnabledBorder,
    this.customDisabledBorder,
    this.customFocusedBorder,
    this.customErrorBorder,
    this.customFocusedErrorBorder,
    this.suffixText,
  })  : labelText = labelText != null
            ? '$labelText${isRequired == true ? ' *' : ''}'
            : null,
        isSearch = false;

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
    this.labelStyle,
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
    this.prefixIcon,
    this.borderRadius,
    this.customEnabledBorder,
    this.customDisabledBorder,
    this.customFocusedBorder,
    this.customErrorBorder,
    this.customFocusedErrorBorder,
    this.suffixText,
  })  : labelText = labelText != null
            ? '$labelText${isRequired == true ? ' *' : ''}'
            : null,
        isSearch = true;

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
          if (widget.labelText != null) ...[
            SmartText(
              widget.labelText!,
              style: style.labelStyle.merge(widget.labelStyle),
            ),
            SizedBox(height: 8.h),
          ],
          SizedBox(
            height: widget.height ?? (widget.isSearch ? 40.w : 48.w),
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
                  suffixText: widget.suffixText,
                  errorMaxLines: 6,
                  counterText: '',
                  filled: true,
                  errorStyle: style.errorStyle.merge(widget.errorStyle),
                  fillColor: widget.color ?? style.textFillColor,
                  contentPadding: widget.contentPadding ??
                      EdgeInsets.all(widget.isSearch ? 10.w : 16.w),
                  disabledBorder: widget.customDisabledBorder ??
                      OutlineInputBorder(
                        borderRadius: widget.borderRadius ??
                            BorderRadius.all(Radius.circular(4.r)),
                        borderSide: BorderSide(
                            color: widget.disabledBorderColor ??
                                style.disabledTextFieldBorderColor),
                      ),
                  enabledBorder: widget.customEnabledBorder ??
                      OutlineInputBorder(
                        borderRadius: widget.borderRadius ??
                            BorderRadius.all(Radius.circular(
                                widget.enabledBorderRadius ?? 4.r)),
                        borderSide: BorderSide(
                          color: widget.enabledBorderColor ??
                              style.enabledTextFieldBorderColor,
                        ),
                      ),
                  focusedBorder: widget.customFocusedBorder ??
                      OutlineInputBorder(
                        borderSide: BorderSide(
                          color: style.focusedTextFieldBorderColor,
                        ),
                        borderRadius: widget.borderRadius ??
                            BorderRadius.all(Radius.circular(4.r)),
                      ),
                  errorBorder: widget.customErrorBorder ??
                      OutlineInputBorder(
                        borderSide: BorderSide(color: style.errorBorderColor),
                        borderRadius: widget.borderRadius ??
                            BorderRadius.all(Radius.circular(4.r)),
                      ),
                  focusedErrorBorder: widget.customFocusedErrorBorder ??
                      OutlineInputBorder(
                        borderSide: BorderSide(color: style.errorBorderColor),
                        borderRadius: widget.borderRadius ??
                            BorderRadius.all(Radius.circular(4.r)),
                      ),
                  hintText: widget.hintText,
                  errorText: widget.errorText,
                  hintStyle: style.hintStyle.merge(widget.hintStyle),
                  prefixIcon: widget.isSearch
                      ? FittedBox(
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 4.w, top: 8.w, bottom: 8.w, right: 0.w),
                            padding: EdgeInsets.zero,
                            child: SmartImage(
                              path: AppImages.icSearch,
                              height: 16.w,
                              width: 16.w,
                            ),
                          ),
                        )
                      : widget.prefixIcon,
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
              obscureText:
                  widget.obscured && _passwordVisible ? false : widget.obscured,
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
