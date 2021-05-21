import 'package:favorites_advanced_base/core.dart';
import 'package:flutter/material.dart';

class DesignSystemTypography {
  factory DesignSystemTypography.withColor(
      DesignSystemColor designSystemColor) {
    return DesignSystemTypography._create(designSystemColor);
  }

  DesignSystemTypography._create(DesignSystemColor designSystemColor) {
    _designSystemColor = designSystemColor;
  }

  late DesignSystemColor _designSystemColor;

  TextStyle get headline1 => TextStyle(
      fontWeight: FontWeight.w100,
      fontSize: 32,
      color: _designSystemColor.headline1);

  TextStyle get headline2 => TextStyle(
      fontWeight: FontWeight.w100,
      fontSize: 28,
      color: _designSystemColor.headline2);

  TextStyle get headline3 => TextStyle(
      fontWeight: FontWeight.w100,
      fontSize: 18,
      color: _designSystemColor.headline3);

  TextStyle get headline4 => TextStyle(
      fontWeight: FontWeight.w100,
      fontSize: 16,
      color: _designSystemColor.headline4);

  TextStyle get headline5 => TextStyle(
      fontWeight: FontWeight.w100,
      fontSize: 14,
      color: _designSystemColor.headline5);

  TextStyle get headline6 => TextStyle(
      fontWeight: FontWeight.w100,
      fontSize: 8,
      color: _designSystemColor.headline6);

  TextStyle get subtitle1 => TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 22,
      );

  TextStyle get subtitle2 => TextStyle(
        fontSize: 14,
        color: _designSystemColor.subtitleColor2,
      );

  TextStyle get bodyText1 => TextStyle(
        fontSize: 14,
        color: _designSystemColor.bodyTextColor1,
      );

  TextStyle get bodyText2 => TextStyle(
      fontWeight: FontWeight.w100,
      fontSize: 16,
      color: _designSystemColor.bodyTextColor2);

  TextStyle get buttonMain => TextStyle(
        color: _designSystemColor.secondaryColor,
        fontSize: 18,
      );

  TextStyle get appBarTitle => TextStyle(
        color: _designSystemColor.appTitleColor,
      );

  TextStyle get chipTitle => TextStyle(
        color: _designSystemColor.chipTitleColor,
      );

  TextStyle get alertPrimaryTitle => TextStyle(
        fontSize: 18,
        color: _designSystemColor.alertPrimaryTitleColor,
      );

  TextStyle get alertSecondaryTitle => TextStyle(
        fontSize: 18,
        color: _designSystemColor.alertSecondaryTitleColor,
      );

  TextStyle get counterTitle => TextStyle(
        fontSize: 12,
        color: _designSystemColor.secondaryIconColor,
      );
}