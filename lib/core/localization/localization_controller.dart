import 'dart:ui';
import 'package:get/get.dart';
import 'package:leyu_mobile/core/cache/cache_keys.dart';
import 'package:leyu_mobile/core/cache/cache_manager.dart';
import 'package:leyu_mobile/core/localization/models/locale_model.dart';

/// Controller for managing app localization and language preferences
class LocalizationController extends GetxController {
  // Reactive locale variable
  final Rx<Locale> _locale = const Locale('en', 'US').obs;

  /// Get current locale
  Locale get locale => _locale.value;

  /// Get list of supported locales
  static const List<LocaleModel> supportedLocales =
      LocaleModel.supportedLocales;

  /// Initialize localization controller
  /// Loads saved locale or uses device locale
  Future<void> init() async {
    try {
      // Try to get saved locale first
      final savedLocale = await getSavedLocale();
      if (savedLocale != null) {
        _locale.value = savedLocale;
        return;
      }

      // If no saved locale, try to use device locale
      final deviceLocale = Get.deviceLocale;
      if (deviceLocale != null && _isSupportedLocale(deviceLocale)) {
        _locale.value = deviceLocale;
        await saveLocale(deviceLocale);
        return;
      }

      // Default to English if device locale is not supported
      _locale.value = const Locale('en', 'US');
      await saveLocale(_locale.value);
    } catch (e) {
      // On any error, default to English
      _locale.value = const Locale('en', 'US');
    }
  }

  /// Change the app language
  Future<void> changeLanguage(String languageCode, String countryCode) async {
    try {
      final newLocale = Locale(languageCode, countryCode);

      // Verify it's a supported locale
      if (!_isSupportedLocale(newLocale)) {
        throw Exception('Unsupported locale: ${languageCode}_$countryCode');
      }

      // Update locale
      _locale.value = newLocale;

      // Persist to cache
      await saveLocale(newLocale);

      // Update GetX locale
      Get.updateLocale(newLocale);
    } catch (e) {
      print('Error changing language: $e');
      rethrow;
    }
  }

  /// Get saved locale from cache
  Future<Locale?> getSavedLocale() async {
    try {
      final localeString = CacheManager.getData(CacheKeys.appLocale);
      if (localeString != null && localeString is String) {
        return _parseLocale(localeString);
      }
    } catch (e) {
      print('Error getting saved locale: $e');
    }
    return null;
  }

  /// Save locale to cache
  Future<void> saveLocale(Locale locale) async {
    try {
      final localeString = '${locale.languageCode}_${locale.countryCode}';
      await CacheManager.saveData(CacheKeys.appLocale, localeString);
    } catch (e) {
      print('Error saving locale: $e');
    }
  }

  /// Parse locale string to Locale object
  Locale? _parseLocale(String localeString) {
    try {
      final parts = localeString.split('_');
      if (parts.length == 2) {
        final locale = Locale(parts[0], parts[1]);
        // Only return if it's a supported locale
        if (_isSupportedLocale(locale)) {
          return locale;
        }
      }
    } catch (e) {
      print('Error parsing locale: $e');
    }
    return null;
  }

  /// Check if a locale is supported
  bool _isSupportedLocale(Locale locale) {
    return supportedLocales.any(
      (localeModel) =>
          localeModel.languageCode == locale.languageCode &&
          localeModel.countryCode == locale.countryCode,
    );
  }

  /// Get current LocaleModel
  LocaleModel get currentLocaleModel {
    return supportedLocales.firstWhere(
      (localeModel) =>
          localeModel.languageCode == _locale.value.languageCode &&
          localeModel.countryCode == _locale.value.countryCode,
      orElse: () => supportedLocales.first,
    );
  }
}
