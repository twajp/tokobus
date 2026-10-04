import 'package:material_ui/material_ui.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/services.dart';

const wasedaColor = Color.fromRGBO(142, 23, 40, 1);

final lightTheme = FlexThemeData.light(
  surface: const Color.fromRGBO(243, 243, 243, 1), // 背景
  primary: const Color.fromRGBO(142, 23, 40, 0.25), // 早稲田色
  secondary: Colors.white, // Container,PopupMenuButton,AlertDialogの色
  tertiary: const Color.fromRGBO(190, 190, 190, 1), // 非アクティブなドット色
  onSurface: Colors.black, // 背景色の上に書く文字・アイコン色
  onSecondary: Colors.black, // secondary色の上に書く文字・アイコン色
  onTertiary: const Color.fromRGBO(107, 107, 107, 1), // アクティブなドット色
  // useMaterial3: false,
  surfaceTint: Colors.transparent, // Appbarの色が透けないようにする
  // applyElevationOverlayColor: false,
  textTheme: const TextTheme(
    headlineMedium: TextStyle(fontSize: 30.0, color: Colors.black), // 時刻表名
    bodyLarge: TextStyle(fontSize: 17.0, color: Colors.black), // これから来るバス
  ),
  primaryTextTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 17.0, color: Colors.grey), // 過ぎたバス
    bodyMedium: TextStyle(fontSize: 14.0, color: Colors.grey), // 時刻表Ver
  ),
).copyWith(
  appBarTheme: const AppBarTheme(
    // backgroundColor: Color.fromRGBO(243, 243, 243, 1),
    // shadowColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light, // for iOS
      statusBarIconBrightness: Brightness.dark, // for Android
      statusBarColor: Color.fromRGBO(243, 243, 243, 1),
      systemNavigationBarColor: Color.fromRGBO(243, 243, 243, 1),
    ),
    iconTheme: IconThemeData(color: Colors.black),
    centerTitle: true,
  ),
  dialogTheme: const DialogThemeData(
    backgroundColor: Colors.white,
  ),
);

final darkTheme = FlexThemeData.dark(
  // scheme: FlexScheme.hippieBlue,
  darkIsTrueBlack: true,
  surface: Colors.black, // 背景
  primary: wasedaColor,
  primaryLightRef: wasedaColor, // エラーが出るので追加
  secondary: const Color.fromRGBO(44, 44, 46, 1), // Container,PopupMenuButton,AlertDialogの色
  secondaryLightRef: const Color.fromRGBO(44, 44, 46, 1), // エラーが出るので追加
  tertiary: const Color.fromRGBO(107, 107, 107, 1), // 非アクティブなドット色
  tertiaryLightRef: const Color.fromRGBO(107, 107, 107, 1), // エラーが出るので追加
  onSurface: Colors.white, // 背景色の上に書く文字・アイコン色
  onSecondary: Colors.white, // secondary色の上に書く文字・アイコン色
  onTertiary: Colors.white, // アクティブなドット色
  // useMaterial3: false,
  surfaceTint: Colors.transparent, // Appbarの色が透けないようにする
  // applyElevationOverlayColor: false,
  textTheme: const TextTheme(
    headlineMedium: TextStyle(fontSize: 30.0, color: Colors.white), // 時刻表名
    bodyLarge: TextStyle(fontSize: 17.0, color: Colors.white), // これから来るバス
  ),
  primaryTextTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 17.0, color: Colors.grey), // 過ぎたバス
    bodyMedium: TextStyle(fontSize: 14.0, color: Colors.grey), // 時刻表Ver
  ),
).copyWith(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black, // ダークモードの方では指定しないとfull_timetable_pageで色がずれる
    // shadowColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark, // for iOS
      statusBarIconBrightness: Brightness.light, // for Android
      statusBarColor: Colors.black,
      systemNavigationBarColor: Colors.black,
    ),
    iconTheme: IconThemeData(color: Colors.white),
    centerTitle: true,
  ),
  dialogTheme: const DialogThemeData(
    backgroundColor: Color.fromRGBO(44, 44, 46, 1),
  ),
  // iconTheme: const IconThemeData(color: Colors.black),
  // radioTheme: RadioThemeData(
  //   fillColor: WidgetStateProperty.resolveWith<Color>(
  //     (Set<WidgetState> states) {
  //       if (states.contains(WidgetState.disabled)) {
  //         return Colors.black.withOpacity(.32);
  //       }
  //       return Colors.black;
  //     },
  //   ),
  // ),
);
