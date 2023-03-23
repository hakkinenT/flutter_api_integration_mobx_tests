import 'package:flutter_test/flutter_test.dart';

import 'package:integration_test/integration_test.dart';

import 'package:flutter_test_widget_integration_unit/main.dart' as app;

import 'robots/home_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late HomeRobot homeRobot;

  setUpAll(() {
    homeRobot = const HomeRobot();
  });

  Future<void> initializingTest(WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
  }

  group('end-to-end test', () {
    testWidgets('should check if api response is successfuly', (tester) async {
      await initializingTest(tester);
      await homeRobot.checkHomePageIsOpen(tester);
      await homeRobot.checkApiResponse(tester);
    });
  });
}
