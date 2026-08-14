import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:leyu_mobile/core/localization/localization_controller.dart';

/// Gets the current locale string for formatting
String _getLocaleString() {
  try {
    final localizationController = Get.find<LocalizationController>();
    return localizationController.locale.toString();
  } catch (e) {
    // Fallback to English if controller not found
    return 'en_US';
  }
}

/// Formats a date according to the current locale
String formatDate(DateTime date) {
  try {
    final localeString = _getLocaleString();
    final DateFormat formatter = DateFormat.yMMMd(localeString);
    return formatter.format(date);
  } catch (e) {
    // Fallback to simple format if locale formatting fails
    return DateFormat('MMM dd, yyyy').format(date);
  }
}

/// Formats a date with time according to the current locale
String formatDateTime(DateTime dateTime) {
  try {
    final localeString = _getLocaleString();
    final DateFormat formatter = DateFormat.yMMMd(localeString).add_jm();
    return formatter.format(dateTime);
  } catch (e) {
    // Fallback to simple format if locale formatting fails
    return DateFormat('MMM dd, yyyy, h:mm a').format(dateTime);
  }
}

/// Formats time according to the current locale
String formatTime(DateTime time) {
  try {
    final localeString = _getLocaleString();
    final DateFormat formatter = DateFormat.jm(localeString);
    return formatter.format(time);
  } catch (e) {
    // Fallback to simple format if locale formatting fails
    return DateFormat('h:mm a').format(time);
  }
}

/// Formats a number according to the current locale
String formatNumber(num number) {
  try {
    final localeString = _getLocaleString();
    final NumberFormat formatter = NumberFormat.decimalPattern(localeString);
    return formatter.format(number);
  } catch (e) {
    // Fallback to simple format if locale formatting fails
    return NumberFormat('#,##0.##').format(number);
  }
}

/// Formats a currency amount according to the current locale
/// [amount] - The amount to format
/// [currencySymbol] - Optional currency symbol (e.g., 'ETB', '$')
String formatCurrency(num amount, {String? currencySymbol}) {
  try {
    final localeString = _getLocaleString();
    final NumberFormat formatter = NumberFormat.currency(
      locale: localeString,
      symbol: currencySymbol ?? '',
      decimalDigits: 2,
    );
    return formatter.format(amount);
  } catch (e) {
    // Fallback to simple format if locale formatting fails
    final symbol = currencySymbol ?? '';
    return '$symbol${NumberFormat('#,##0.00').format(amount)}';
  }
}

/// Formats a percentage according to the current locale
String formatPercentage(num value) {
  try {
    final localeString = _getLocaleString();
    final NumberFormat formatter = NumberFormat.percentPattern(localeString);
    return formatter.format(value);
  } catch (e) {
    // Fallback to simple format if locale formatting fails
    return '${(value * 100).toStringAsFixed(0)}%';
  }
}
