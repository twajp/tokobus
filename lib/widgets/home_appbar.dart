import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

AppBar homeAppBar({required BuildContext context, required timetable}) {
  return AppBar(
    title: Image.asset('assets/icon/icon_transparent.png', height: kToolbarHeight),
    actions: [
      PopupMenuButton(
        icon: Icon(
          Icons.more_vert,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        color: Theme.of(context).colorScheme.secondary,
        itemBuilder: (context) {
          return [
            const PopupMenuItem<int>(
              value: 0,
              child: Text('大学公式サイトを開く'),
            ),
            const PopupMenuItem<int>(
              value: 1,
              child: Text('大学公式PDFを開く'),
            ),
            const PopupMenuItem<int>(
              value: 2,
              child: Text('問い合わせ / 不具合報告'),
            ),
            const PopupMenuItem<int>(
              value: 3,
              child: Text('TokoBusについて'),
            ),
          ];
        },
        onSelected: (value) {
          if (value == 0) {
            myLaunchUrl(timetable['url']['waseda_bus_page']);
          } else if (value == 1) {
            myLaunchUrl(timetable['url']['default_pdf']);
          } else if (value == 2) {
            myLaunchUrl('https://twajp.github.io/tokobus/support');
          } else if (value == 3) {
            myLaunchUrl('https://twajp.github.io/tokobus/');
          }
        },
      ),
    ],
  );
}

Future<void> myLaunchUrl(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw Exception('Could not launch $url');
  }
}
