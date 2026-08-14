import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:leyu_mobile/core/localization/localization_controller.dart';
import 'package:leyu_mobile/main.dart';

void main() {
  setUpAll(() {
    dotenv.testLoad(fileInput: 'API_BASE_URL=https://api.example.com');
  });

  testWidgets('App initialization smoke test', (WidgetTester tester) async {
    Get.put(LocalizationController());

    await tester.pumpWidget(const MyApp());
    expect(find.byType(MyApp), findsOneWidget);
  });
}
