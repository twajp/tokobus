import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:material_ui/material_ui.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokobus/main.dart';
import 'package:tokobus/pages/intro_screen.dart';
import 'package:tokobus/pages/settings_page.dart';
import 'package:tokobus/services/theme.dart';
import 'package:tokobus/services/theme_provider.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({
      'lastShownBuild': 9999,
      'themeMode': ThemeModeOption.light.index,
    });
    PackageInfo.setMockInitialValues(
      appName: 'TokoBus',
      packageName: 'jp.twa.tokobus',
      version: '1.0.0',
      buildNumber: '9999',
      buildSignature: '',
    );
  });

  testWidgets('Portrait dots navigate with the light and dark app themes', (tester) async {
    await _pumpApp(tester);

    final homeContext = tester.element(find.byType(MyHomePage));
    _expectTimetableTheme(tester, Brightness.light);

    final dots = find.descendant(
      of: find.byType(DotsIndicator),
      matching: find.byType(InkWell),
    );
    expect(dots, findsNWidgets(2));
    await tester.tap(dots.last);
    await tester.pumpAndSettle();
    expect(tester.widget<PageView>(find.byType(PageView)).controller!.page, 1);
    expect(tester.widget<DotsIndicator>(find.byType(DotsIndicator)).position, 1);

    Provider.of<ThemeProvider>(homeContext, listen: false).setThemeMode(ThemeModeOption.dark);
    await tester.pumpAndSettle();
    _expectTimetableTheme(tester, Brightness.dark);

    await tester.tap(dots.first);
    await tester.pumpAndSettle();
    expect(tester.widget<PageView>(find.byType(PageView)).controller!.page, 0);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('Settings theme selection updates the app and saved preference', (tester) async {
    await _pumpApp(tester);

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('設定'));
    await tester.pumpAndSettle();
    expect(find.byType(SettingsPage), findsOneWidget);

    await tester.tap(find.text('テーマ'));
    await tester.pumpAndSettle();
    final dialog = find.byType(AlertDialog);
    expect(dialog, findsOneWidget);
    await tester.tap(find.descendant(of: dialog, matching: find.text('ダーク')));
    await tester.pumpAndSettle();

    expect(dialog, findsNothing);
    expect(find.text('ダーク'), findsOneWidget);
    final settingsContext = tester.element(find.byType(SettingsPage));
    expect(Theme.of(settingsContext).brightness, Brightness.dark);
    expect(Provider.of<ThemeProvider>(settingsContext, listen: false).themeMode, ThemeMode.dark);
    final preferences = await SharedPreferences.getInstance();
    expect(preferences.getInt('themeMode'), ThemeModeOption.dark.index);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('Introduction pages advance and the done button closes the route', (tester) async {
    _usePortraitView(tester);
    await tester.pumpWidget(MaterialApp(
      theme: lightTheme,
      home: Builder(builder: (context) {
        return Scaffold(
          body: TextButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (_) => const IntroScreenPage(),
            )),
            child: const Text('Open introduction'),
          ),
        );
      }),
    ));
    await tester.tap(find.text('Open introduction'));
    await tester.pumpAndSettle();
    expect(find.text('TokoBusへようこそ').hitTestable(), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_forward));
    await tester.pumpAndSettle();
    expect(find.text('ご注意').hitTestable(), findsOneWidget);
    await tester.tap(find.byIcon(Icons.arrow_forward));
    await tester.pumpAndSettle();
    expect(find.text('お願い').hitTestable(), findsOneWidget);
    await tester.tap(find.byIcon(Icons.done));
    await tester.pumpAndSettle();

    expect(find.byType(IntroScreenPage), findsNothing);
    expect(find.text('Open introduction'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}

Future<void> _pumpApp(WidgetTester tester) async {
  _usePortraitView(tester);
  final client = MockClient((_) async => http.Response(
        '{"id": 0, "flag": false, "title": "", "content": "", "url": ""}',
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      ));
  addTearDown(client.close);
  await tester.pumpWidget(ChangeNotifierProvider(
    create: (_) => ThemeProvider(),
    child: MyApp(httpClient: client),
  ));
  await tester.pumpAndSettle();
  // The live timetable can show this notice on special service dates.
  if (find.text('本日は特別ダイヤです').evaluate().isNotEmpty) {
    await tester.tap(find.text('閉じる'));
    await tester.pumpAndSettle();
  }
}

void _usePortraitView(WidgetTester tester) {
  tester.view.physicalSize = const Size(400, 800);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void _expectTimetableTheme(WidgetTester tester, Brightness brightness) {
  final theme = Theme.of(tester.element(find.byType(MyHomePage)));
  final foreground = brightness == Brightness.light ? Colors.black : Colors.white;
  expect(theme.brightness, brightness);
  expect(theme.textTheme.headlineMedium!.fontSize, 30);
  expect(theme.textTheme.headlineMedium!.color, foreground);
  expect(theme.textTheme.bodyLarge!.fontSize, 17);
  expect(theme.textTheme.bodyLarge!.color, foreground);
  expect(theme.primaryTextTheme.bodyLarge!.fontSize, 17);
  expect(theme.primaryTextTheme.bodyLarge!.color, Colors.grey);
  final version = tester.widget<Text>(find.textContaining('時刻表Ver:'));
  expect(version.style!.fontSize, 14);
  expect(version.style!.color, Colors.grey);
}
