import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leyu_mobile/core/localization/localization_controller.dart';
import 'package:leyu_mobile/core/theme/app_colors.dart';
import 'package:leyu_mobile/core/widgets/image.dart';
import 'package:leyu_mobile/core/widgets/language_selection_dialog.dart';

class LanguageChanger extends StatelessWidget {
  final bool isShortForm;

  const LanguageChanger({this.isShortForm = false, super.key});

  @override
  Widget build(BuildContext context) {
    final localizationController = Get.find<LocalizationController>();

    return Obx(() {
      // Find the current locale model
      final currentLocaleModel =
          LocalizationController.supportedLocales.firstWhere(
        (locale) =>
            locale.languageCode == localizationController.locale.languageCode &&
            locale.countryCode == localizationController.locale.countryCode,
        orElse: () => LocalizationController.supportedLocales.first,
      );

      // Get display text based on form type
      final displayText = isShortForm
          ? _getShortLanguageCode(currentLocaleModel.languageCode)
          : currentLocaleModel.nativeName;

      return InkWell(
        onTap: () => _showLanguageDialog(context),
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: AppColors.primary,
              width: 0.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              assetSvgImageWidget(
                "language.svg",
                width: isShortForm ? 17 : 20,
                height: isShortForm ? 17 : 20,
              ),
              SizedBox(width: isShortForm ? 5 : 10),
              Text(
                displayText,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const LanguageSelectionDialog(),
    );
  }

  String _getShortLanguageCode(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'En';
      case 'am':
        return 'አማ';
      case 'om':
        return 'Om';
      default:
        return 'En';
    }
  }
}
