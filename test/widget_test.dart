import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:tokobus/main.dart';
import 'package:tokobus/services/theme_provider.dart';

void main() {
  setUp(() async {
    // SharedPreferencesのモック設定
    SharedPreferences.setMockInitialValues({
      'lastShownBuild': 9999, // イントロ画面をスキップするために大きな値を設定
    });
    // PackageInfoのモック設定
    PackageInfo.setMockInitialValues(
      appName: 'TokoBus',
      packageName: 'jp.twa.tokobus',
      version: '1.0.0',
      buildNumber: '9999',
      buildSignature: '',
    );
  });

  testWidgets('App smoke test', (WidgetTester tester) async {
    // ネットワークリクエストのモック化
    final mockClient = MockClient((request) async {
      return http.Response(
        '{"id": 0, "flag": false, "title": "Test", "content": "Test content", "url": ""}',
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      );
    });

    // アプリをビルドしてフレームをトリガーする
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: MyApp(httpClient: mockClient),
      ),
    );

    // 非同期の初期化処理（SharedPreferencesなど）を待つ
    await tester.pump();
    // タイマーや非同期処理が進むのを待つ
    await tester.pump(const Duration(milliseconds: 500));

    // 「時刻表Ver:」というテキストが含まれるウィジェットが存在することを確認
    expect(find.textContaining('時刻表Ver:'), findsOneWidget);

    // AppBarのメニューボタン（Icons.more_vert）が存在することを確認
    expect(find.byIcon(Icons.more_vert), findsOneWidget);
  });
}
