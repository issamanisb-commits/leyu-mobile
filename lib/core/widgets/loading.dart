import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:leyu_mobile/core/theme/app_colors.dart';

import '../utils/screen_size.dart';

class LoadingPopupWidget extends StatelessWidget {
  final List<RxBool> isLoading;
  final RxString? reason;

  const LoadingPopupWidget({super.key, required this.isLoading, this.reason});

  @override
  Widget build(BuildContext context) {
    return Obx(() => isLoading.obs.any((value) => value.value)
        ? Container(
            color: Colors.black.withValues(alpha: 0.8),
            height: getScreenHeight(context),
            alignment: Alignment.center,
            child: Stack(
              children: [
                const ModalBarrier(
                  dismissible: false,
                  color: Colors.transparent,
                ),
                Center(
                  child: Container(
                    width: 220,
                    height: 110,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoadingAnimationWidget.threeArchedCircle(
                            color: AppColors.primary, size: 30),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          (reason == null || reason?.value == "")
                              ? ""
                              : "${reason?.value}...",
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              decoration: TextDecoration.none),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink());
  }
}

class LoadingOverlayWidget extends StatelessWidget {
  final Widget child;
  final List<RxBool> isLoading;
  final RxString? reason;

  const LoadingOverlayWidget(
      {super.key, required this.child, required this.isLoading, this.reason});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        LoadingPopupWidget(
          isLoading: isLoading,
          reason: reason,
        ),
      ],
    );
  }
}

class LoadingWidget extends StatelessWidget {
  final double height;
  final double? width;
  final double size;
  final String? reason;
  final bool isTransparent;
  final Color color;
  const LoadingWidget({
    super.key,
    this.width = 200,
    this.height = 100,
    this.size = 30,
    this.isTransparent = false,
    this.reason,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isTransparent ? Colors.transparent : Colors.white),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingAnimationWidget.threeArchedCircle(color: color, size: size),
          SizedBox(
            height: height > 80 ? 10 : 0,
          ),
          reason == null
              ? Container()
              : Text(
                  reason!,
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      decoration: TextDecoration.none),
                ),
        ],
      ),
    );
  }
}
