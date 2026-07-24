import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import '../services/theme.dart';
import '../services/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final settingsTheme = SettingsThemeData(
      settingsListBackground: Theme.of(context).colorScheme.surface,
      settingsSectionBackground: Theme.of(context).colorScheme.secondary,
      titleTextColor: Theme.of(context).colorScheme.onSurface, // 外観
      leadingIconsColor: Theme.of(context).colorScheme.onSecondary, // アイコン
      settingsTileTextColor: Theme.of(context).colorScheme.onSecondary, // テーマ
      // tileDescriptionTextColor: Colors.yellow,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '設定',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        // centerTitle: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SettingsList(
        lightTheme: settingsTheme,
        darkTheme: settingsTheme,
        sections: [
          SettingsSection(
            title: const Text('外観'),
            tiles: [
              SettingsTile.navigation(
                leading: const Icon(Icons.brightness_6),
                title: const Text('テーマ'),
                value: Text(_themeModeToString(themeProvider.themeModeOption)),
                onPressed: (context) {
                  _showThemeSelectionDialog(context, themeProvider);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _themeModeToString(ThemeModeOption mode) {
    switch (mode) {
      case ThemeModeOption.light:
        return 'ライト';
      case ThemeModeOption.dark:
        return 'ダーク';
      case ThemeModeOption.system:
        return '端末の設定';
    }
  }

  void _showThemeSelectionDialog(BuildContext context, ThemeProvider themeProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'テーマ',
            style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
          ),
          actionsPadding: const EdgeInsets.only(bottom: 15, right: 15),
          content: RadioGroup<ThemeModeOption>(
            groupValue: themeProvider.themeModeOption,
            onChanged: (value) {
              if (value != null) {
                themeProvider.setThemeMode(value);
                Navigator.of(context).pop();
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: ThemeModeOption.values.map((mode) {
                return RadioListTile<ThemeModeOption>(
                  title: Text(_themeModeToString(mode)),
                  activeColor: wasedaColor,
                  value: mode,
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'キャンセル',
                style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
