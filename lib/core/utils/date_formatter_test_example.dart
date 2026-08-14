// Example usage of date_formatter functions
// This file demonstrates how to use the formatting functions
// and can be used for manual testing

import 'package:leyu_mobile/core/utils/date_formatter.dart';

void testDateFormatting() {
  final now = DateTime.now();

  print('=== Date Formatting Examples ===');
  print('formatDate: ${formatDate(now)}');
  print('formatDateTime: ${formatDateTime(now)}');
  print('formatTime: ${formatTime(now)}');

  print('\n=== Number Formatting Examples ===');
  print('formatNumber(1234567.89): ${formatNumber(1234567.89)}');
  print(
      'formatCurrency(1500.50, currencySymbol: "ETB"): ${formatCurrency(1500.50, currencySymbol: "ETB")}');
  print('formatPercentage(0.75): ${formatPercentage(0.75)}');

  print('\n=== Edge Cases ===');
  print('formatNumber(0): ${formatNumber(0)}');
  print('formatCurrency(0): ${formatCurrency(0)}');
  print('formatPercentage(0): ${formatPercentage(0)}');
  print('formatPercentage(1): ${formatPercentage(1)}');
}

// To test this, you can call testDateFormatting() from anywhere in your app
// For example, in a button's onPressed callback:
//
// ElevatedButton(
//   onPressed: () {
//     testDateFormatting();
//   },
//   child: Text('Test Formatting'),
// )
