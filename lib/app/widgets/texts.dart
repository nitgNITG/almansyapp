import 'package:step/app/core/themes/colors.dart';
import 'package:flutter/material.dart';

import '../utils/helper_funcs.dart';

Text getTitleText(
  String text,
  BuildContext context, {
  Color color = kPrimaryColor,
  double? size,
  FontWeight weight = FontWeight.bold,
  TextAlign? align,
  TextDecoration? decoration,
  Color? decorationColor,
}) {
  return Text(
    text,
    style: getThemeData(context).textTheme.displayLarge!.copyWith(
          height: 1.2,
          color: color,
          fontSize: size,
          fontWeight: weight,
          decoration: decoration,
          decorationColor: decorationColor,
          fontFamily: 'Cairo',
        ),
    textAlign: align,
  );
}

Text getNormalText(
  String? text,
  BuildContext context, {
  Color? color,
  FontWeight? weight,
  double? size,
  TextAlign? align,
  TextDecoration? decoration,
  Color? decorationColor,
  TextOverflow? overflow,
  int? maxLines,
}) {
  return Text(
    text ?? "",
    style: getThemeData(context).textTheme.displayMedium!.copyWith(
          height: 1.5,
          color: color ?? getThemeData(context).colorScheme.onSurface,
          fontWeight: weight ?? FontWeight.normal,
          fontSize: size,
          decoration: decoration,
          decorationColor: decorationColor,
          overflow: overflow,
          fontFamily: 'Cairo',
        ),
    maxLines: maxLines,
    textAlign: align,
  );
}
