import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Auth Validation Unit Tests', () {
    test('Valid email regex validation passes correctly', () {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

      expect(emailRegex.hasMatch('test@leyu.ai'), isTrue);
      expect(emailRegex.hasMatch('invalid-email'), isFalse);
    });

    test('Non-empty string field validation', () {
      bool isNonEmpty(String? val) => val != null && val.trim().isNotEmpty;

      expect(isNonEmpty('secret_password'), isTrue);
      expect(isNonEmpty('   '), isFalse);
      expect(isNonEmpty(null), isFalse);
    });
  });
}
