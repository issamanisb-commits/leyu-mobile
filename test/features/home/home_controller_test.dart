import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  group('HomeController Logic Tests', () {
    test('RxInt reactive variable updates correctly', () {
      final pendingCount = 0.obs;
      expect(pendingCount.value, equals(0));

      pendingCount.value = 3;
      expect(pendingCount.value, equals(3));
    });

    test('Greeting parameter interpolation formatting', () {
      final userFirstName = 'issam'.obs;
      final capitalized = userFirstName.value.capitalizeFirst;

      expect(capitalized, equals('Issam'));
    });
  });
}
