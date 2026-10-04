import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeModeOption { light, dark, system }

class ThemeProvider with ChangeNotifier {
  ThemeModeOption _themeModeOption = ThemeModeOption.system;

  ThemeProvider() {
    _loadThemeFromPreferences();
  }

  ThemeModeOption get themeModeOption => _themeModeOption;

  ThemeMode get themeMode {
    switch (_themeModeOption) {
      case ThemeModeOption.light:
        return ThemeMode.light;
      case ThemeModeOption.dark:
        return ThemeMode.dark;
      case ThemeModeOption.system:
        return ThemeMode.system;
    }
  }

  void setThemeMode(ThemeModeOption mode) {
    _themeModeOption = mode;
    notifyListeners();
    _saveThemeToPreferences();
  }

  Future<void> _loadThemeFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt('themeMode') ?? 1; // デフォルトはダーク
    _themeModeOption = ThemeModeOption.values[themeIndex];
    notifyListeners();
  }

  Future<void> _saveThemeToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', _themeModeOption.index);
  }
}
