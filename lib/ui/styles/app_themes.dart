import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:sahayatri/ui/styles/style_x.dart';
import 'package:sahayatri/ui/styles/app_colors.dart';
import 'package:sahayatri/ui/styles/app_text_styles.dart';

class AppThemes {
  AppThemes._();

  static ThemeData get _base => ThemeData(
        fontFamily: AppConfig.fontFamily,
        primaryColor: AppColors.primary,
        primaryColorDark: AppColors.primaryDark,
        primaryColorLight: AppColors.primaryLight,
        accentColor: AppColors.secondary,
        splashColor: AppColors.primary,
        errorColor: AppColors.secondary,
        indicatorColor: AppColors.primary,
        visualDensity: VisualDensity.standard,
        accentColorBrightness: Brightness.dark,
        primaryColorBrightness: Brightness.light,
      );

  static ThemeData get light => _base.copyWith(
        brightness: Brightness.light,
        backgroundColor: AppColors.light,
        scaffoldBackgroundColor: AppColors.light,
        colorScheme: _lightColorScheme,
        iconTheme: _darkIconTheme,
        accentIconTheme: _darkIconTheme,
        primaryIconTheme: _darkIconTheme,
        cardTheme: _lightCardTheme,
        appBarTheme: _lightAppBarTheme,
        tabBarTheme: _lightTabBarTheme,
        dialogTheme: _lightDialogTheme,
        dividerTheme: _lightDividerTheme,
        popupMenuTheme: _lightPopupMenuTheme,
        bottomSheetTheme: _lightBottomSheetTheme,
        bottomAppBarTheme: _lightBottomAppBarTheme,
        inputDecorationTheme: _lightInputDecorationTheme,
        floatingActionButtonTheme: _lightFloatingActionButtonTheme,
      );

  static ThemeData get dark => _base.copyWith(
        brightness: Brightness.dark,
        backgroundColor: AppColors.dark,
        scaffoldBackgroundColor: AppColors.dark,
        applyElevationOverlayColor: true,
        colorScheme: _darkColorScheme,
        iconTheme: _lightIconTheme,
        accentIconTheme: _lightIconTheme,
        primaryIconTheme: _lightIconTheme,
        cardTheme: _darkCardTheme,
        appBarTheme: _darkAppBarTheme,
        tabBarTheme: _darkTabBarTheme,
        dialogTheme: _darkDialogTheme,
        dividerTheme: _darkDividerTheme,
        popupMenuTheme: _darkPopupMenuTheme,
        bottomSheetTheme: _darkBottomSheetTheme,
        bottomAppBarTheme: _darkBottomAppBarTheme,
        inputDecorationTheme: _darkInputDecorationTheme,
        floatingActionButtonTheme: _darkFloatingActionButtonTheme,
      );

  static ColorScheme get _lightColorScheme => const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.dark,
        primaryVariant: AppColors.primaryDark,
        secondary: AppColors.secondary,
        onSecondary: AppColors.light,
        secondaryVariant: AppColors.secondaryDark,
        error: AppColors.secondary,
        onError: AppColors.light,
        surface: AppColors.lightAccent,
        onSurface: AppColors.dark,
        background: AppColors.light,
        onBackground: AppColors.dark,
      );

  static ColorScheme get _darkColorScheme => _lightColorScheme.copyWith(
        brightness: Brightness.dark,
        surface: AppColors.darkAccent,
        onSurface: AppColors.light,
        background: AppColors.dark,
        onBackground: AppColors.light,
      );

  static IconThemeData get _lightIconTheme => const IconThemeData(
        size: 20.0,
        opacity: 1.0,
        color: AppColors.light,
      );

  static IconThemeData get _darkIconTheme => _lightIconTheme.copyWith(
        color: AppColors.dark,
      );

  static RoundedRectangleBorder get _circularBorderRadius => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      );

  static InputBorder get _inputBorder => OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(4.0),
      );

  static InputDecorationTheme get _lightInputDecorationTheme => InputDecorationTheme(
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

  static InputDecorationTheme get _darkInputDecorationTheme =>
      _lightInputDecorationTheme.copyWith(
        fillColor: AppColors.darkAccent,
        focusColor: AppColors.darkAccent,
        hintStyle: AppTextStyles.small.light,
        labelStyle: AppTextStyles.small.light,
        helperStyle: AppTextStyles.small.light,
        prefixStyle: AppTextStyles.small.light,
        suffixStyle: AppTextStyles.small.light,
        counterStyle: AppTextStyles.small.light,
        errorStyle: AppTextStyles.extraSmall.secondary,
      );

  static FloatingActionButtonThemeData get _lightFloatingActionButtonTheme =>
      const FloatingActionButtonThemeData(
        elevation: 8.0,
        disabledElevation: 0.0,
        backgroundColor: AppColors.dark,
        splashColor: AppColors.darkAccent,
        foregroundColor: AppColors.primary,
      );

  static FloatingActionButtonThemeData get _darkFloatingActionButtonTheme =>
      _lightFloatingActionButtonTheme.copyWith(
        backgroundColor: AppColors.darkAccent,
        splashColor: AppColors.dark,
      );

  static AppBarTheme get _lightAppBarTheme => AppBarTheme(
        elevation: 0.0,
        color: AppColors.light,
        brightness: Brightness.light,
        iconTheme: _darkIconTheme,
        actionsIconTheme: _darkIconTheme,
      );

  static AppBarTheme get _darkAppBarTheme => _lightAppBarTheme.copyWith(
        color: AppColors.dark,
        brightness: Brightness.dark,
        iconTheme: _lightIconTheme,
        actionsIconTheme: _lightIconTheme,
      );

  static BottomAppBarTheme get _lightBottomAppBarTheme => const BottomAppBarTheme(
        elevation: 0.0,
        color: AppColors.light,
        shape: CircularNotchedRectangle(),
      );

  static BottomAppBarTheme get _darkBottomAppBarTheme => _lightBottomAppBarTheme.copyWith(
        color: AppColors.dark,
      );

  static TabBarTheme get _lightTabBarTheme => TabBarTheme(
        labelColor: AppColors.dark,
        labelStyle: AppTextStyles.medium,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(32.0),
          gradient: LinearGradient(
            colors: [
              AppColors.accents[0],
              AppColors.accents[1],
            ],
          ),
        ),
      );

  static TabBarTheme get _darkTabBarTheme => _lightTabBarTheme.copyWith(
        labelColor: AppColors.light,
        labelStyle: AppTextStyles.medium.light,
      );

  static CardTheme get _lightCardTheme => CardTheme(
        elevation: 8.0,
        margin: EdgeInsets.zero,
        color: AppColors.lightAccent,
        clipBehavior: Clip.antiAlias,
        shape: _circularBorderRadius,
      );

  static CardTheme get _darkCardTheme => _lightCardTheme.copyWith(
        color: AppColors.darkAccent,
      );

  static DividerThemeData get _lightDividerTheme => DividerThemeData(
        space: 8.0,
        thickness: 0.5,
        color: AppColors.dark.withOpacity(0.3),
      );

  static DividerThemeData get _darkDividerTheme => _lightDividerTheme.copyWith(
        color: AppColors.light.withOpacity(0.3),
      );

  static BottomSheetThemeData get _lightBottomSheetTheme => const BottomSheetThemeData(
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
  static BottomSheetThemeData get _darkBottomSheetTheme =>
      _lightBottomSheetTheme.copyWith(
        backgroundColor: AppColors.darkAccent,
        modalBackgroundColor: AppColors.darkAccent,
      );

  static DialogTheme get _lightDialogTheme => DialogTheme(
        elevation: 16.0,
        shape: _circularBorderRadius,
        backgroundColor: AppColors.light,
        contentTextStyle: AppTextStyles.medium,
      );

  static DialogTheme get _darkDialogTheme => _lightDialogTheme.copyWith(
        backgroundColor: AppColors.dark,
        contentTextStyle: AppTextStyles.medium.light,
      );

  static PopupMenuThemeData get _lightPopupMenuTheme => PopupMenuThemeData(
        elevation: 8.0,
        shape: _circularBorderRadius,
        color: AppColors.lightAccent,
        textStyle: AppTextStyles.small,
      );

  static PopupMenuThemeData get _darkPopupMenuTheme => _lightPopupMenuTheme.copyWith(
        color: AppColors.darkAccent,
        textStyle: AppTextStyles.small.light,
      );
}
