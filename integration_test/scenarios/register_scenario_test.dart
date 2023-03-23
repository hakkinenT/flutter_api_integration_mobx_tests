import 'package:flutter_test/flutter_test.dart';

import 'package:integration_test/integration_test.dart';

import 'package:flutter_test_widget_integration_unit/main.dart' as app;

import 'robots/home_robot.dart';
import 'robots/register_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late HomeRobot homeRobot;
  late RegisterRobot registerRobot;

  setUpAll(() {
    homeRobot = const HomeRobot();
    registerRobot = const RegisterRobot();
  });

  Future<void> initializingTest(WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
  }

  group('end-to-end test', () {
    testWidgets('should register a album', (tester) async {
      await initializingTest(tester);
      await homeRobot.checkHomePageIsOpen(tester);
      await homeRobot.navigateToRegisterPage(tester);
      await registerRobot.enterAlbumName(tester, "novo album");
      await registerRobot.tapRegisterButton(tester);
      await registerRobot.checkSuccessMessageIsShown(tester, "novo album");
    });

    testWidgets('should not register a album if the field album name is empty',
        (tester) async {
      await initializingTest(tester);
      await homeRobot.checkHomePageIsOpen(tester);
      await homeRobot.navigateToRegisterPage(tester);
      await registerRobot.enterAlbumName(tester, "");
      await registerRobot.tapRegisterButton(tester);
      await registerRobot.checkRequiredFieldMessageIsShown(tester);
    });

    testWidgets(
        'should not register a album if the field album name is invalid',
        (tester) async {
      await initializingTest(tester);
      await homeRobot.checkHomePageIsOpen(tester);
      await homeRobot.navigateToRegisterPage(tester);
      await registerRobot.enterAlbumName(tester, "n");
      await registerRobot.tapRegisterButton(tester);
      await registerRobot.checkInvalidFieldMessageIsShown(tester);
    });
  });
}
