import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../pages/intro_screen.dart';

// 再度イントロ画面を全員に表示させたい場合はこれを配信予定のビルド番号に変更
const int requiredBuild = 131;

// イントロ画面を表示すべきかどうかをチェックする関数
Future<void> showIntroIfRequired(BuildContext context) async {
  // SharedPreferencesインスタンスの取得
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // 現在のアプリのビルド番号を取得
  // int currentBuild = 131; // テスト用
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  int currentBuild = int.parse(packageInfo.buildNumber);

  // 最後にイントロ画面を完了した時のビルド番号を取得
  int? lastShownBuild = prefs.getInt('lastShownBuild');

  // イントロ画面を表示すべきかどうかを判定
  bool shouldShowIntro = lastShownBuild == null || (lastShownBuild < currentBuild && currentBuild <= requiredBuild);

  // print('$lastShownBuild < $currentBuild && $currentBuild <= $requiredBuild');
  // print('shouldShowIntro: $shouldShowIntro');

  if (shouldShowIntro) {
    if (!context.mounted) return;
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => const IntroScreenPage()));

    // イントロ画面を表示した後、現在のビルド番号をSharedPreferencesに保存
    await prefs.setInt('lastShownBuild', currentBuild);
  }
}
