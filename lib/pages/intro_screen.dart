import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreenPage extends StatelessWidget {
  const IntroScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pageDecoration = PageDecoration(
      titleTextStyle: Theme.of(context).textTheme.headlineMedium!,
      bodyTextStyle: Theme.of(context).textTheme.bodyLarge!,
      titlePadding: const EdgeInsets.only(top: 80.0, bottom: 30.0),
      bodyPadding: const EdgeInsets.symmetric(horizontal: 12.0),
      imagePadding: const EdgeInsets.all(16.0),
      // contentMargin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
    );

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/icon/icon_transparent.png', height: kToolbarHeight),
        automaticallyImplyLeading: false, // 戻るボタンを削除
      ),
      body: SafeArea(
        child: IntroductionScreen(
          globalBackgroundColor: Theme.of(context).colorScheme.surface,
          pages: [
            PageViewModel(
              title: 'TokoBusへようこそ',
              bodyWidget: _buildBulletList(context, [
                '早稲田大学所沢キャンパスの非公式スクールバス時刻表アプリです。',
                // '時刻表と発車までの残り時間を共に表示するため、乗車可能なバスが簡単に確認できます。',
                '曜日や祝日に応じた適切なダイヤを自動で表示します。',
                '授業を行う祝日と臨時の休業日にも対応しています。',
                '特別ダイヤ運行時には画面上に通知します。',
                'フロンティアリサーチセンターへのシャトルバスにも対応しています。',
              ]),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: 'ご注意',
              bodyWidget: _buildBulletList(context, [
                '本アプリは、卒業生が趣味で開発・運営する非公式アプリです。',
                '時刻表データはAIを用いてPDFから変換しているため、誤りを含む可能性があります。',
                '特に試験日等の重要な日には、公式サイトを併用することを強く推奨いたします。',
                '本アプリの不具合等によるいかなる損害についても、一切の責任を負いかねます。',
              ]),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: 'お願い',
              bodyWidget: _buildBulletList(context, [
                '時刻表の誤りやアプリの不具合にお気づきの際は、右上のメニューよりご報告いただけますと幸いです。',
              ]),
              decoration: pageDecoration,
            ),
          ],
          onDone: () async {
            final navigator = Navigator.of(context);
            // SharedPreferences prefs = await SharedPreferences.getInstance();
            // await prefs.setBool('haveSeenIntro', true);
            navigator.pop();
          },
          showBackButton: true,
          back: _buildCircularButton(
            context,
            Icons.arrow_back,
            Theme.of(context).colorScheme.secondary,
          ),
          next: _buildCircularButton(
            context,
            Icons.arrow_forward,
            Theme.of(context).colorScheme.primary,
          ),
          done: _buildCircularButton(
            context,
            Icons.done,
            Theme.of(context).colorScheme.primary,
          ),
          dotsDecorator: DotsDecorator(
            activeColor: Theme.of(context).colorScheme.onTertiary,
            color: Theme.of(context).colorScheme.tertiary,
            activeSize: const Size(12.0, 12.0),
            size: const Size(8.0, 8.0),
            spacing: const EdgeInsets.all(4.0),
          ),
        ),
      ),
    );
  }

  Widget _buildCircularButton(BuildContext context, IconData icon, Color bgColor) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor,
      ),
      padding: const EdgeInsets.all(14.0),
      child: Icon(
        icon,
        color: Theme.of(context).colorScheme.onSecondary,
        size: 28,
      ),
    );
  }

  Widget _buildBulletList(BuildContext context, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: items.map((item) => _buildBulletPoint(context, item)).toList(),
    );
  }

  Widget _buildBulletPoint(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('・', style: TextStyle(fontSize: 20)),
          Flexible(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
