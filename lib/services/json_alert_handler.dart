import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> jsonAlertHandler({required BuildContext context, http.Client? client}) async {
  // リリース時は GitHub を参照
  // デバッグ時はローカルサーバー (Web/iOS: localhost, Android: 10.0.2.2) を参照
  // デバッグ時のローカルサーバー起動コマンド: npx http-server --cors -p 8000
  const prodUrl = 'https://raw.githubusercontent.com/twajp/tokobus/master/data/dialog.json';
  final debugUrl = kIsWeb || Platform.isIOS ? 'http://localhost:8000/data/dialog.json' : 'http://10.0.2.2:8000/data/dialog.json';
  final url = Uri.parse(kDebugMode ? debugUrl : prodUrl);

  // client が提供されている場合はそれを使用し、そうでない場合は http.get (内部でデフォルトクライアントを使用) を使用
  final response = await (client?.get(url) ?? http.get(url));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final prefs = await SharedPreferences.getInstance();
    final int? ignoredId = prefs.getInt('ignored_alert_id');

    if (jsonData['flag'] && jsonData['id'] != ignoredId) {
      // State が存在する（つまりウィジェットがまだツリーにある）ことを確認してから実行
      if (!context.mounted) return;
      _showJsonAlert(context: context, jsonData: jsonData, prefs: prefs);
    }
  } else {
    throw Exception('Failed to load JSON data: ${response.statusCode}');
  }
}

void _showJsonAlert({required BuildContext context, required Map<String, dynamic> jsonData, required SharedPreferences prefs}) {
  bool doNotShowAgain = jsonData['defaultCheckbox'] ?? false;
  bool allowDoNotShowAgain = jsonData['allowDoNotShowAgain'] ?? false;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(jsonData['title']),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                Text(jsonData['content']),
                if (allowDoNotShowAgain)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        doNotShowAgain = !doNotShowAgain;
                      });
                    },
                    child: Row(
                      children: [
                        Checkbox(
                          value: doNotShowAgain,
                          onChanged: (bool? value) {
                            setState(() {
                              doNotShowAgain = value ?? false;
                            });
                          },
                        ),
                        Text('このメッセージを再表示しない'),
                      ],
                    ),
                  ),
              ],
            ),
            actions: [
              TextButton(
                child: Text(
                  '閉じる',
                  style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
                ),
                onPressed: () {
                  if (allowDoNotShowAgain && doNotShowAgain) {
                    prefs.setInt('ignored_alert_id', jsonData['id']);
                  }
                  Navigator.of(context).pop();
                },
              ),
              if (jsonData['url'] != '') ...{
                TextButton(
                  onPressed: () async {
                    final navigator = Navigator.of(context);
                    final url = jsonData['url'];
                    final uri = Uri.parse(url);
                    if (!await launchUrl(uri)) {
                      throw Exception('Could not launch $url');
                    }
                    if (navigator.canPop()) {
                      navigator.pop();
                    }
                  },
                  child: Text(
                    '開く',
                    style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
                  ),
                ),
              },
            ],
          );
        },
      );
    },
  );
}
