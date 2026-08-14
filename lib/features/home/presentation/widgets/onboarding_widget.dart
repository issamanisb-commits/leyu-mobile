import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/screen_size.dart';

class OnBoardingWidget extends StatelessWidget {
  final RxBool showOverLay;
  final Widget? overlay;

  const OnBoardingWidget({super.key, required this.showOverLay, this.overlay});

  @override
  Widget build(BuildContext context) {
    return Obx(() => showOverLay.value
        ? Container(
            color: Colors.black.withValues(alpha: 0.8),
            height: getScreenHeight(context) * 0.75,
            alignment: Alignment.center,
            child: Stack(
              children: [
                const ModalBarrier(
                  dismissible: false,
                  color: Colors.transparent,
                ),
                overlay ?? const SizedBox.shrink(),
              ],
            ),
          )
        : const SizedBox.shrink());
  }
}

class OnBoardingOverlayWidget extends StatelessWidget {
  final Widget child;
  final RxBool showOverlay;
  final Widget overlay;

  const OnBoardingOverlayWidget(
      {super.key,
      required this.child,
      required this.showOverlay,
      required this.overlay});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        OnBoardingWidget(showOverLay: showOverlay, overlay: overlay),
      ],
    );
  }
}
