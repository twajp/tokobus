import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

void showDialogOnSpecialDate({required BuildContext context, required timetable}) {
  DateTime currentDate = DateTime.now();
  String url = timetable['url']['default_pdf'];
  if (timetable['url']['special_pdf'].containsKey(DateTime(currentDate.year, currentDate.month, currentDate.day))) {
    url = timetable['url']['special_pdf'][DateTime(currentDate.year, currentDate.month, currentDate.day)];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('本日は特別ダイヤです'),
          content: const Text('本日の特別ダイヤは未対応です。\n大学ウェブサイトのPDFを確認しますか？'),
          actions: [
            TextButton(
              child: Text(
                '閉じる',
                style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: () async {
                final navigator = Navigator.of(context);
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
          ],
        );
      },
    );
  }
}
