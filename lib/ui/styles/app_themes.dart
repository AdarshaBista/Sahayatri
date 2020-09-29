import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:sahayatri/ui/styles/style_x.dart';
import 'package:sahayatri/ui/styles/app_colors.dart';
import 'package:sahayatri/ui/styles/app_text_styles.dart';

class AppThemes {
  AppThemes._();

  static ThemeData get light => ThemeData(
        fontFamily: AppConfig.kFontFamily,
        brightness: Brightness.light,
        accentColorBrightness: Brightness.light,
        visualDensity: VisualDensity.standard,
        primaryColor: AppColors.primary,
        accentColor: AppColors.secondary,
        splashColor: AppColors.primary,
        disabledColor: AppColors.disabled,
        backgroundColor: AppColors.light,
        scaffoldBackgroundColor: AppColors.light,
        dialogBackgroundColor: AppColors.lightAccent,
        canvasColor: AppColors.light,
        dividerColor: AppColors.barrier,
        buttonColor: AppColors.secondary,
        cardColor: AppColors.lightAccent,
        bottomAppBarColor: AppColors.light,
        hintColor: AppColors.primary,
        errorColor: AppColors.secondary,
        indicatorColor: AppColors.primary,
        iconTheme: darkIconTheme,
        accentIconTheme: darkIconTheme,
        primaryIconTheme: darkIconTheme,
        bottomAppBarTheme: _bottomAppBarTheme,
        appBarTheme: _appBarTheme,
        tabBarTheme: _tabBarTheme,
        cardTheme: _cardTheme,
        buttonTheme: _buttonTheme,
        dialogTheme: _dialogTheme,
        dividerTheme: _dividerTheme,
        snackBarTheme: _snackBarTheme,
        popupMenuTheme: _popupMenuTheme,
        bottomSheetTheme: _bottomSheetTheme,
        inputDecorationTheme: _inputDecorationTheme,
        floatingActionButtonTheme: _floatingActionButtonTheme,
      );

  static IconThemeData get darkIconTheme => const IconThemeData(
        size: 20.0,
        opacity: 1.0,
        color: AppColors.dark,
      );

  static IconThemeData get lightIconTheme => darkIconTheme.copyWith(
        color: AppColors.light,
      );

  static RoundedRectangleBorder get _circularBorderRadius => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      );

  static InputBorder get _inputBorder => OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(4.0),
      );

  static InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(
        filled: true,
        isDense: true,
        errorMaxLines: 2,
        helperMaxLines: 2,
        alignLabelWithHint: true,
        contentPadding: const EdgeInsets.all(12.0),
        fillColor: AppColors.lightAccent,
        focusColor: AppColors.lightAccent,
        hintStyle: AppTextStyles.small,
        labelStyle: AppTextStyles.small,
        helperStyle: AppTextStyles.small,
        prefixStyle: AppTextStyles.small,
        suffixStyle: AppTextStyles.small,
        counterStyle: AppTextStyles.small,
        errorStyle: AppTextStyles.extraSmall.secondary,
        border: _inputBorder,
        errorBorder: _inputBorder,
        enabledBorder: _inputBorder,
        focusedBorder: _inputBorder,
        disabledBorder: _inputBorder,
        focusedErrorBorder: _inputBorder,
      );

  static FloatingActionButtonThemeData get _floatingActionButtonTheme =>
      const FloatingActionButtonThemeData(
        elevation: 8.0,
        disabledElevation: 0.0,
        backgroundColor: AppColors.dark,
        splashColor: AppColors.secondary,
        foregroundColor: AppColors.primary,
      );

  static AppBarTheme get _appBarTheme => AppBarTheme(
        elevation: 0.0,
        color: AppColors.light,
        brightness: Brightness.light,
        iconTheme: darkIconTheme,
        actionsIconTheme: darkIconTheme,
      );

  static BottomAppBarTheme get _bottomAppBarTheme => const BottomAppBarTheme(
        elevation: 0.0,
        color: AppColors.light,
        shape: CircularNotchedRectangle(),
      );

  static TabBarTheme get _tabBarTheme => TabBarTheme(
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

  static ButtonThemeData get _buttonTheme => ButtonThemeData(
        alignedDropdown: true,
        shape: _circularBorderRadius,
        buttonColor: AppColors.primary,
        splashColor: AppColors.secondary,
      );

  static CardTheme get _cardTheme => CardTheme(
        elevation: 8.0,
        margin: EdgeInsets.zero,
        color: AppColors.lightAccent,
        shadowColor: AppColors.darkAccent,
        clipBehavior: Clip.antiAlias,
        shape: _circularBorderRadius,
      );

  static DividerThemeData get _dividerTheme => DividerThemeData(
        space: 8.0,
        thickness: 0.5,
        color: AppColors.dark.withOpacity(0.3),
      );

  static BottomSheetThemeData get _bottomSheetTheme => const BottomSheetThemeData(
        elevation: 12.0,
        modalElevation: 12.0,
        clipBehavior: Clip.antiAlias,
        backgroundColor: AppColors.lightAccent,
        modalBackgroundColor: AppColors.lightAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
        ),
      );

  static DialogTheme get _dialogTheme => DialogTheme(
        elevation: 16.0,
        shape: _circularBorderRadius,
        backgroundColor: AppColors.lightAccent,
        contentTextStyle: AppTextStyles.medium,
      );

  static PopupMenuThemeData get _popupMenuTheme => PopupMenuThemeData(
        elevation: 8.0,
        shape: _circularBorderRadius,
        color: AppColors.lightAccent,
        textStyle: AppTextStyles.small,
      );

  static SnackBarThemeData get _snackBarTheme => SnackBarThemeData(
        elevation: 8.0,
        shape: _circularBorderRadius,
        backgroundColor: AppColors.dark,
        actionTextColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        contentTextStyle: AppTextStyles.small.light,
      );
}
