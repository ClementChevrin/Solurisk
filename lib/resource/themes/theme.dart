import 'package:flutter/material.dart';

class ThemeApp {
  /// Retourne le theme de l'app
  static ThemeData lightTheme = ThemeData()
    ..addThemeExtension(
      ThemeExtensionApp(
        colorPrimary: const Color(0Xff505050),
        colorSecondary: const Color(0XffF85D19),
        scaffoldBackground: const Color.fromARGB(255, 245, 245, 245),
        cardBackground: const Color.fromARGB(255, 255, 255, 255),
        statusFalse: const Color.fromARGB(255, 211, 47, 47),
        statusNeutral: const Color.fromARGB(255, 238, 216, 20),
        statusTrue: const Color.fromARGB(255, 102, 192, 107),
        iconFalse: Icons.close_outlined,
        iconNeutral: Icons.block_outlined,
        iconTrue: Icons.done_outlined,
        topAppBar: const ThemeColor(
          backgroundEnable: Color(0XFF505050),
          backgroundDisable: Color(0XFF505050),
          foregroundEnable: Color(0XFFFEFEFE),
          foregroundDisable: Color(0XFFFEFEFE),
          focused: Color.fromARGB(255, 255, 255, 255),
        ),
        bottomAppBar: const ThemeColor(
          backgroundEnable: Color(0XFF505050),
          backgroundDisable: Color(0XFF505050),
          foregroundEnable: Color(0XFFFEFEFE),
          foregroundDisable: Color(0XFFFEFEFE),
          focused: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  static ThemeData darkTheme = ThemeData()..addThemeExtension(ThemeExtensionApp());
  static ThemeData currentTheme = lightTheme;
}

/// Theme d'extension au [ThemeData] pour des éléments modifiés
class ThemeExtensionApp {
  Color? colorPrimary;
  Color? colorSecondary;
  Color? scaffoldBackground;
  Color? cardBackground;
  Color statusFalse;
  Color statusNeutral;
  Color statusTrue;
  final IconData? iconFalse;
  final IconData? iconNeutral;
  final IconData? iconTrue;
  final ThemeColor? topAppBar;
  final ThemeColor? bottomAppBar;
  final ThemeColor? tabs;
  final ThemeColor? toggleItem;
  final ThemeColor? textField;
  final ThemeColor? button;
  final ThemeColor? chips;
  ThemeExtensionApp(
      {this.colorPrimary = Colors.blue,
      this.colorSecondary = Colors.blue,
      this.scaffoldBackground = const Color.fromARGB(255, 233, 233, 233),
      this.cardBackground = Colors.white,
      this.statusFalse = Colors.red,
      this.statusNeutral = Colors.yellow,
      this.statusTrue = Colors.green,
      this.iconFalse,
      this.iconNeutral,
      this.iconTrue,
      this.topAppBar,
      this.bottomAppBar,
      this.tabs,
      this.toggleItem,
      this.textField,
      this.button,
      this.chips});
  factory ThemeExtensionApp.empty() {
    return ThemeExtensionApp(statusFalse: Colors.black, statusNeutral: Colors.black, statusTrue: Colors.black);
  }
}

/// Implémente l'extension de nouveaux thèmes de couleur à [ThemeData]
extension ThemeDataExtensions on ThemeData {
  static final Map<InputDecorationTheme, ThemeExtensionApp> _own = {};

  void addThemeExtension(ThemeExtensionApp own) {
    _own[inputDecorationTheme] = own;
  }

  static ThemeExtensionApp? empty;

  ThemeExtensionApp themeExtension() {
    var o = _own[inputDecorationTheme];
    if (o == null) {
      if (empty == null) empty = ThemeExtensionApp.empty();
      o = empty;
    }
    return o!;
  }
}

/// Liste de [Color] pour un [Widget] défini, comprend la couleur de fond, de premier plan, l'ombre ,...
class ThemeColor {
  final Color? backgroundEnable;
  final Color? backgroundDisable;
  final Color? foregroundEnable;
  final Color? foregroundDisable;
  final Color? borderEnable;
  final Color? borderDisable;
  final Color? shadow;
  final Color? hovered;
  final Color? focused;
  final Color? pressed;
  const ThemeColor({this.backgroundEnable, this.backgroundDisable, this.foregroundEnable, this.foregroundDisable, this.borderEnable, this.borderDisable, this.shadow, this.hovered, this.focused, this.pressed});
}



/*Gris foncé 505050       080 , 080 , 080
Gris moyen 3F3F3F         063 , 063 , 063
Gris clair 9D9690         157 , 150 , 144
Blanc FCFCFC              252 , 252 , 252
Orange F85D19             248 , 093 , 025
Vert 77b255
Rouge EC4430              236 , 068 , 048
Jaune ECCA30*/
 