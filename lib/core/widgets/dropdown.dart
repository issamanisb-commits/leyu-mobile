import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leyu_mobile/core/theme/app_colors.dart';
import 'package:leyu_mobile/core/widgets/image.dart';
import 'package:leyu_mobile/core/widgets/loading.dart';

class DropdownWidget extends StatelessWidget {
  final String label;
  final String? content;
  final Widget icon;
  final VoidCallback onTap;
  final double height;
  final double radius;
  final bool isRequired;

  const DropdownWidget(
      {super.key,
      required this.label,
      this.content,
      required this.icon,
      required this.onTap,
      this.height = 50,
      this.radius = 7,
      this.isRequired = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(bottom: 5, left: 3),
              child: Row(
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  isRequired
                      ? const Text(
                          "*",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: AppColors.red),
                        )
                      : Container(),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(radius)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          icon,
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                              content ??
                                  'validation.choose_field'
                                      .trParams({'field': label.toLowerCase()}),
                              style: TextStyle(
                                  fontSize: content == null ? 13 : 14,
                                  color: content == null
                                      ? Colors.grey
                                      : Colors.black))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(left: BorderSide(color: Colors.black)),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: AppColors.gray),
                    child: Center(
                        child: assetSvgImageWidget("dropdown.svg",
                            width: 25, height: 25)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DropdownBoxWidget<T> extends StatefulWidget {
  final String label;
  final List<T> items;
  final bool isItemsLoading;
  final T? selectedItem;
  final String? placeHolder;
  final ValueChanged<T?>? onChanged;
  final FocusNode? focus;
  final FocusNode? focusNext;
  final EdgeInsets? padding;
  final bool showLabel;
  final bool isOptional;
  final double borderRadius;
  final String Function(T) displayText;
  final VoidCallback? reFetch;

  const DropdownBoxWidget({
    super.key,
    required this.label,
    required this.items,
    this.isItemsLoading = false,
    this.selectedItem,
    this.placeHolder,
    this.onChanged,
    this.focus,
    this.focusNext,
    this.padding,
    this.showLabel = false,
    this.isOptional = false,
    this.borderRadius = 18.0,
    required this.displayText,
    this.reFetch,
  });

  @override
  State<DropdownBoxWidget> createState() => _DropdownBoxWidgetState<T>();
}

class _DropdownBoxWidgetState<T> extends State<DropdownBoxWidget<T>> {
  String? errorText;

  void _updateErrorText(String? newError) {
    if (errorText != newError) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          errorText = newError;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.showLabel)
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 3.0),
              child: Row(
                children: [
                  Text(
                    widget.label,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  if (!widget.isOptional)
                    const Text(
                      " *",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: AppColors.red,
                      ),
                    ),
                ],
              ),
            ),
          DropdownButtonFormField2<T>(
            value: widget.selectedItem,
            focusNode: widget.focus,
            iconStyleData: IconStyleData(
              icon: widget.isItemsLoading || widget.items.isEmpty
                  ? const SizedBox.shrink()
                  : const Icon(Icons.keyboard_arrow_down,
                      color: Colors.grey, size: 28),
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                color: AppColors.inputBgColor,
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.inputBgColor,
              contentPadding: const EdgeInsets.only(left: 4, right: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: const BorderSide(color: AppColors.red, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide:
                    const BorderSide(color: AppColors.primary, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: const BorderSide(color: AppColors.red, width: 1),
              ),
              errorStyle: const TextStyle(fontSize: 0, color: AppColors.red),
              suffixIcon: widget.isItemsLoading
                  ? const Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: LoadingWidget(
                        width: 20,
                        height: 20,
                        size: 20,
                        isTransparent: true,
                      ),
                    )
                  : widget.items.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: InkWell(
                            onTap: widget.reFetch,
                            child: const Icon(
                              Icons.refresh,
                              color: Colors.grey,
                              size: 24,
                            ),
                          ),
                        )
                      : null,
            ),
            hint: Text(
              widget.placeHolder ??
                  'validation.select_field'.trParams({'field': widget.label}),
              style: const TextStyle(
                  fontSize: 13, color: Colors.grey, fontFamily: 'openSans'),
            ),
            style: const TextStyle(fontSize: 15, color: Colors.black),
            items: widget.items.map((T item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(widget.displayText(item)),
              );
            }).toList(),
            onChanged: (T? newValue) {
              widget.onChanged?.call(newValue);
              _updateErrorText(null);
              if (widget.focusNext != null) {
                FocusScope.of(context).requestFocus(widget.focusNext);
                Scrollable.ensureVisible(widget.focusNext!.context!,
                    alignment: 0.5);
              }
            },
            validator: (T? value) {
              if (!widget.isOptional && value == null) {
                _updateErrorText('validation.field_required'
                    .trParams({'field': widget.label}));
                return '';
              }
              _updateErrorText(null);
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                errorText!,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.red,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
