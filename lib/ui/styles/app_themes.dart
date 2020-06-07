import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/values.dart';

import 'package:sahayatri/ui/styles/app_colors.dart';
import 'package:sahayatri/ui/styles/app_text_styles.dart';

class AppThemes {
  AppThemes._();

  static final ThemeData light = ThemeData(
    fontFamily: Values.kFontFamily,
    brightness: Brightness.light,
    accentColorBrightness: Brightness.light,
    primaryColor: AppColors.primary,
    accentColor: AppColors.secondary,
    disabledColor: AppColors.disabled,
    splashColor: AppColors.secondary,
    backgroundColor: AppColors.background,
    scaffoldBackgroundColor: AppColors.background,
    bottomAppBarColor: AppColors.background,
    cardColor: AppColors.light,
    buttonColor: AppColors.secondary,
    dialogBackgroundColor: AppColors.light,
    dividerColor: AppColors.dark.withOpacity(0.7),
    canvasColor: AppColors.background,
    hintColor: AppColors.primary,
    errorColor: Colors.red,
    indicatorColor: AppColors.primary,
    iconTheme: darkIconTheme,
    accentIconTheme: darkIconTheme,
    primaryIconTheme: darkIconTheme,
    tabBarTheme: _tabBarTheme,
    appBarTheme: _appBarTheme,
    bottomAppBarTheme: _bottomAppBarTheme,
    floatingActionButtonTheme: _floatingActionButtonTheme,
    cardTheme: _cardTheme,
    buttonTheme: _buttonTheme,
    dividerTheme: _dividerTheme,
    dialogTheme: _dialogTheme,
    snackBarTheme: _snackBarTheme,
    popupMenuTheme: _popupMenuTheme,
    bottomSheetTheme: _bottomSheetTheme,
    inputDecorationTheme: _inputDecorationTheme,
  );

  static const IconThemeData darkIconTheme = IconThemeData(
    size: 20.0,
    color: AppColors.dark,
    opacity: 1.0,
  );

  static const IconThemeData lightIconTheme = IconThemeData(
    size: 20.0,
    color: AppColors.light,
    opacity: 1.0,
  );

  static final _circularBorderRadius = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
  );

  static final InputBorder _inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: BorderSide.none,
  );

  static final InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
    filled: true,
    isDense: true,
    alignLabelWithHint: true,
    errorMaxLines: 2,
    helperMaxLines: 2,
    contentPadding: const EdgeInsets.all(16.0),
    focusColor: AppColors.light,
    fillColor: AppColors.light,
    hintStyle: AppTextStyles.small,
    labelStyle: AppTextStyles.small,
    helperStyle: AppTextStyles.small,
    prefixStyle: AppTextStyles.small,
    suffixStyle: AppTextStyles.small,
    counterStyle: AppTextStyles.small,
    errorStyle: AppTextStyles.small.copyWith(color: Colors.red),
    border: _inputBorder,
    enabledBorder: _inputBorder,
    errorBorder: _inputBorder,
    disabledBorder: _inputBorder,
    focusedBorder: _inputBorder,
    focusedErrorBorder: _inputBorder,
  );

  static const FloatingActionButtonThemeData _floatingActionButtonTheme =
      FloatingActionButtonThemeData(
    elevation: 8.0,
    disabledElevation: 0.0,
    splashColor: AppColors.secondary,
    foregroundColor: AppColors.primary,
    backgroundColor: AppColors.dark,
  );

  static const AppBarTheme _appBarTheme = AppBarTheme(
    elevation: 0.0,
    color: AppColors.background,
    brightness: Brightness.light,
    iconTheme: darkIconTheme,
    actionsIconTheme: darkIconTheme,
  );

  static const BottomAppBarTheme _bottomAppBarTheme = BottomAppBarTheme(
    elevation: 0.0,
    color: AppColors.background,
    shape: CircularNotchedRectangle(),
  );

  static final TabBarTheme _tabBarTheme = TabBarTheme(
    labelColor: AppColors.dark,
    labelStyle: AppTextStyles.medium,
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: BoxDecoration(
      borderRadius: BorderRadius.circular(32.0),
      gradient: LinearGradient(
        colors: [
          AppColors.accentColors[0],
          AppColors.accentColors[1],
        ],
      ),
    ),
  );

  static final ButtonThemeData _buttonTheme = ButtonThemeData(
    alignedDropdown: true,
    buttonColor: AppColors.primary,
    splashColor: AppColors.secondary,
    shape: _circularBorderRadius,
  );

  static final CardTheme _cardTheme = CardTheme(
    elevation: 8.0,
    color: AppColors.light,
    shadowColor: AppColors.dark,
    margin: EdgeInsets.zero,
    clipBehavior: Clip.antiAlias,
    shape: _circularBorderRadius,
  );

  static final DividerThemeData _dividerTheme = DividerThemeData(
    space: 8.0,
    thickness: 0.5,
    color: AppColors.dark.withOpacity(0.3),
  );

  static const BottomSheetThemeData _bottomSheetTheme = BottomSheetThemeData(
    clipBehavior: Clip.antiAlias,
    elevation: 12.0,
    backgroundColor: AppColors.light,
    modalElevation: 12.0,
    modalBackgroundColor: AppColors.light,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12.0),
        topRight: Radius.circular(12.0),
      ),
    ),
  );

  static final DialogTheme _dialogTheme = DialogTheme(
    elevation: 16.0,
    backgroundColor: AppColors.light,
    contentTextStyle: AppTextStyles.medium,
    shape: _circularBorderRadius,
  );

  static final PopupMenuThemeData _popupMenuTheme = PopupMenuThemeData(
    color: AppColors.light,
    elevation: 8.0,
    textStyle: AppTextStyles.small,
    shape: _circularBorderRadius,
  );

  static final SnackBarThemeData _snackBarTheme = SnackBarThemeData(
    elevation: 8.0,
    backgroundColor: AppColors.dark,
    actionTextColor: AppColors.primary,
    shape: _circularBorderRadius,
    behavior: SnackBarBehavior.floating,
    contentTextStyle: AppTextStyles.small.light,
  );
}
