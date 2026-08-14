import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:leyu_mobile/core/theme/app_colors.dart';

class ValidatedTextInputWidget extends StatefulWidget {
  final String label;
  final String? placeHolder;
  final TextEditingController controller;
  final FocusNode? focus;
  final int? minCharacters;
  final int? maxCharacters;
  final int maxLines;
  final ValueChanged<bool>? onValidationChanged;
  final TextInputAction? textInputAction;
  final VoidCallback? onSubmitted;

  const ValidatedTextInputWidget({
    super.key,
    required this.label,
    required this.controller,
    this.placeHolder,
    this.focus,
    this.minCharacters,
    this.maxCharacters,
    this.maxLines = 10,
    this.onValidationChanged,
    this.textInputAction,
    this.onSubmitted,
  });

  @override
  State<ValidatedTextInputWidget> createState() =>
      _ValidatedTextInputWidgetState();
}

class _ValidatedTextInputWidgetState extends State<ValidatedTextInputWidget> {
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_validateText);
    _validateText();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_validateText);
    super.dispose();
  }

  void _validateText() {
    final currentLength = widget.controller.text.length;
    bool isValid = true;

    if (widget.minCharacters != null && currentLength < widget.minCharacters!) {
      isValid = false;
    }
    if (widget.maxCharacters != null && currentLength > widget.maxCharacters!) {
      isValid = false;
    }

    if (_isValid != isValid) {
      setState(() {
        _isValid = isValid;
      });
      widget.onValidationChanged?.call(isValid);
    }
  }

  Color _getTextColor(int currentLength) {
    if (widget.maxCharacters != null && currentLength > widget.maxCharacters!) {
      return AppColors.red;
    }
    if (widget.minCharacters != null && currentLength < widget.minCharacters!) {
      return Colors.orange;
    }
    if (widget.minCharacters != null &&
        currentLength >= widget.minCharacters!) {
      return Colors.green;
    }
    return Colors.grey[600]!;
  }

  String _getDisplayText(int currentLength) {
    final minChars = widget.minCharacters;
    final maxChars = widget.maxCharacters;

    String displayText = '$currentLength';
    if (minChars != null && maxChars != null) {
      displayText += ' / $minChars-$maxChars characters';
    } else if (minChars != null) {
      displayText += ' / min $minChars characters';
    } else if (maxChars != null) {
      displayText += ' / max $maxChars characters';
    }

    return displayText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focus,
          keyboardType: TextInputType.multiline,
          textInputAction: widget.textInputAction ?? TextInputAction.newline,
          onFieldSubmitted:
              widget.onSubmitted != null ? (_) => widget.onSubmitted!() : null,
          maxLines: widget.maxLines,
          style: const TextStyle(fontSize: 15),
          cursorColor: AppColors.primary,
          inputFormatters: widget.maxCharacters != null
              ? [LengthLimitingTextInputFormatter(widget.maxCharacters)]
              : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.inputBgColor,
            hintText: widget.placeHolder ??
                'validation.enter_field'.trParams({'field': widget.label}),
            hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: _isValid ? AppColors.primary : Colors.orange,
                width: _isValid ? 1 : 1.5,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.controller.text.isEmpty
                    ? Colors.transparent
                    : (_isValid
                        ? Colors.green.withValues(alpha: 0.3)
                        : Colors.orange.withValues(alpha: 0.3)),
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.red),
              borderRadius: BorderRadius.circular(18),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
        if (widget.minCharacters != null || widget.maxCharacters != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, right: 4),
            child: Align(
              alignment: Alignment.centerRight,
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: widget.controller,
                builder: (context, value, child) {
                  final currentLength = value.text.length;
                  return Text(
                    _getDisplayText(currentLength),
                    style: TextStyle(
                      fontSize: 11,
                      color: _getTextColor(currentLength),
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
