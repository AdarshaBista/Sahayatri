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
        cardColor: AppColors.light,
        dividerColor: AppColors.darkFaded,
        textTheme: _darkTextTheme,
        colorScheme: _lightColorScheme,
        iconTheme: _darkIconTheme,
        accentIconTheme: _darkIconTheme,
        primaryIconTheme: _darkIconTheme,
        cardTheme: _lightCardTheme,
        chipTheme: _lightChipTheme,
        dividerTheme: _dividerTheme,
        appBarTheme: _lightAppBarTheme,
        tabBarTheme: _lightTabBarTheme,
        dialogTheme: _lightDialogTheme,
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
        cardColor: AppColors.darkSurface,
        dividerColor: AppColors.lightFaded,
        applyElevationOverlayColor: false,
        textTheme: _lightTextTheme,
        colorScheme: _darkColorScheme,
        iconTheme: _lightIconTheme,
        accentIconTheme: _lightIconTheme,
        primaryIconTheme: _lightIconTheme,
        cardTheme: _darkCardTheme,
        chipTheme: _darkChipTheme,
        dividerTheme: _dividerTheme,
        appBarTheme: _darkAppBarTheme,
        tabBarTheme: _darkTabBarTheme,
        dialogTheme: _darkDialogTheme,
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
        onSurface: AppColors.darkAccent,
        background: AppColors.light,
        onBackground: AppColors.dark,
      );

  static ColorScheme get _darkColorScheme => _lightColorScheme.copyWith(
        primaryVariant: AppColors.light,
        secondaryVariant: AppColors.light,
        brightness: Brightness.dark,
        surface: AppColors.darkAccent,
        onSurface: AppColors.lightAccent,
        background: AppColors.dark,
        onBackground: AppColors.light,
      );

  static TextTheme get _lightTextTheme => TextTheme(
        headline1: AppTextStyles.headline1.light,
        headline2: AppTextStyles.headline2.light,
        headline3: AppTextStyles.headline3.light,
        headline4: AppTextStyles.headline4.light,
        headline5: AppTextStyles.headline5.lightAccent,
        headline6: AppTextStyles.headline6.lightFaded,
      );

  static TextTheme get _darkTextTheme => TextTheme(
        headline1: AppTextStyles.headline1,
        headline2: AppTextStyles.headline2,
        headline3: AppTextStyles.headline3,
        headline4: AppTextStyles.headline4,
        headline5: AppTextStyles.headline5,
        headline6: AppTextStyles.headline6,
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
        borderRadius: BorderRadius.circular(6.0),
      );

  static InputBorder get _inputBorder => OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(6.0),
      );

  static InputDecorationTheme get _lightInputDecorationTheme => InputDecorationTheme(
        filled: true,
        isDense: true,
        errorMaxLines: 2,
        helperMaxLines: 2,
        alignLabelWithHint: true,
        contentPadding: const EdgeInsets.all(14.0),
        fillColor: AppColors.lightAccent,
        focusColor: AppColors.lightAccent,
        hintStyle: AppTextStyles.headline5,
        labelStyle: AppTextStyles.headline5,
        helperStyle: AppTextStyles.headline5,
        prefixStyle: AppTextStyles.headline5,
        suffixStyle: AppTextStyles.headline5,
        counterStyle: AppTextStyles.headline5,
        errorStyle: AppTextStyles.headline6.secondary,
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
        hintStyle: AppTextStyles.headline5.lightAccent,
        labelStyle: AppTextStyles.headline5.lightAccent,
        helperStyle: AppTextStyles.headline5.lightAccent,
        prefixStyle: AppTextStyles.headline5.lightAccent,
        suffixStyle: AppTextStyles.headline5.lightAccent,
        counterStyle: AppTextStyles.headline5.lightAccent,
        errorStyle: AppTextStyles.headline6.secondary,
      );

  static FloatingActionButtonThemeData get _lightFloatingActionButtonTheme =>
      const FloatingActionButtonThemeData(
        elevation: 4.0,
        hoverElevation: 4.0,
        focusElevation: 4.0,
        disabledElevation: 0.0,
        highlightElevation: 4.0,
        backgroundColor: AppColors.dark,
        splashColor: AppColors.darkSurface,
        foregroundColor: AppColors.primary,
      );

  static FloatingActionButtonThemeData get _darkFloatingActionButtonTheme =>
      _lightFloatingActionButtonTheme.copyWith(
        backgroundColor: AppColors.primary,
        splashColor: AppColors.primaryDark,
        foregroundColor: AppColors.dark,
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
        labelStyle: AppTextStyles.headline4,
        indicatorSize: TabBarIndicatorSize.label,
      );

  static TabBarTheme get _darkTabBarTheme => _lightTabBarTheme.copyWith(
        labelColor: AppColors.light,
        labelStyle: AppTextStyles.headline4.light,
      );

  static CardTheme get _lightCardTheme => CardTheme(
        elevation: 8.0,
        margin: EdgeInsets.zero,
        color: AppColors.lightAccent,
        clipBehavior: Clip.antiAlias,
        shape: _circularBorderRadius,
      );

  static CardTheme get _darkCardTheme => _lightCardTheme.copyWith(
        color: AppColors.darkSurface,
      );

  static DividerThemeData get _dividerTheme => const DividerThemeData(
        space: 8.0,
        thickness: 0.25,
      );

  static BottomSheetThemeData get _lightBottomSheetTheme => const BottomSheetThemeData(
        elevation: 12.0,
        modalElevation: 12.0,
        clipBehavior: Clip.antiAlias,
        backgroundColor: AppColors.light,
        modalBackgroundColor: AppColors.light,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
        ),
      );

  static BottomSheetThemeData get _darkBottomSheetTheme =>
      _lightBottomSheetTheme.copyWith(
        backgroundColor: AppColors.darkSurface,
        modalBackgroundColor: AppColors.darkSurface,
      );

  static DialogTheme get _lightDialogTheme => DialogTheme(
        elevation: 16.0,
        shape: _circularBorderRadius,
        backgroundColor: AppColors.light,
        contentTextStyle: AppTextStyles.headline4,
      );

  static DialogTheme get _darkDialogTheme => _lightDialogTheme.copyWith(
        backgroundColor: AppColors.darkSurface,
        contentTextStyle: AppTextStyles.headline4.light,
      );

  static PopupMenuThemeData get _lightPopupMenuTheme => PopupMenuThemeData(
        elevation: 8.0,
        shape: _circularBorderRadius,
        color: AppColors.light,
        textStyle: AppTextStyles.headline5,
      );

  static PopupMenuThemeData get _darkPopupMenuTheme => _lightPopupMenuTheme.copyWith(
        color: AppColors.darkSurface,
        textStyle: AppTextStyles.headline5.lightAccent,
      );

  static ChipThemeData get _lightChipTheme => ChipThemeData(
        padding: EdgeInsets.zero,
        brightness: Brightness.light,
        selectedColor: AppColors.primaryDark,
        secondarySelectedColor: AppColors.primaryDark,
        disabledColor: AppColors.lightFaded,
        backgroundColor: AppColors.lightAccent,
        labelStyle: AppTextStyles.headline6,
        secondaryLabelStyle: AppTextStyles.headline6,
      );

  static ChipThemeData get _darkChipTheme => _lightChipTheme.copyWith(
        brightness: Brightness.dark,
        disabledColor: AppColors.darkFaded,
        backgroundColor: AppColors.darkAccent,
        labelStyle: AppTextStyles.headline6.darkFaded,
        secondaryLabelStyle: AppTextStyles.headline6.darkFaded,
      );
}
