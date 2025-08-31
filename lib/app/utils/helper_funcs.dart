import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:step/app/widgets/texts.dart';

import '../core/themes/colors.dart';

AppLocalizations getL10(context) {
  return AppLocalizations.of(context)!;
}

Size getScreenSize(context) {
  return MediaQuery.of(context).size;
}

double getScreenHeight(context) {
  return getScreenSize(context).height;
}

double getScreenWidth(context) {
  return getScreenSize(context).width;
}

SizedBox getHeightSpace(double height) {
  return SizedBox(
    height: height,
  );
}

getTopPadding(context) {
  return MediaQuery.paddingOf(context).top;
}

SizedBox getWidthSpace(double width) {
  return SizedBox(
    width: width,
  );
}

ThemeData getThemeData(context) => Theme.of(context);

List<BoxShadow> getBoxShadow(BuildContext context, {Color? color}) {
  color ??= getThemeData(context).colorScheme.onSurface.withOpacity(0.3);
  return [
    BoxShadow(
      color: color, //Colors.grey.withOpacity(0.5),
      spreadRadius: 2,
      blurRadius: 5,
      offset: const Offset(0, 3), // changes position of shadow
    ),
  ];
}

Color getRandomQuietColor() {
  // List of quiet colors
  List<Color> quietColors = [
    Colors.blueGrey,
    Colors.indigo,
    Colors.teal,
    Colors.amber,
    Colors.pink,
    Colors.brown,
    Colors.deepPurple,
    Colors.green,
  ];

  // Generate a random index
  int randomIndex = Random().nextInt(quietColors.length);

  // Return the selected color
  return quietColors[randomIndex];
}

bool isHTMLTag(String str) {
  final RegExp htmlTagRegex = RegExp(r'<[^>]*>');
  return htmlTagRegex.hasMatch(str);
}

String truncateString(String str, int maxLength) {
  if (str.length <= maxLength) {
    return str;
  } else {
    return '${str.substring(0, maxLength)}...';
  }
}

Row getTitle(BuildContext context, String title, double width) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      getWidthSpace(10),

      // about academy
      Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: getThemeData(context).colorScheme.onSurface,
              height: 1.8,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              decorationColor: kPrimaryColor,
              fontFamily: 'Cairo',
            ),
          ), // about academy
          // about academy
          Container(
            color: const Color(0xff001B52),
            height: 3,
            width: width,
          ),

          ///الخط اللي تحت ال about academy
        ],
      ),
    ],
  );
}

Decoration buildDecorationButton(
    {double? opacityBoxShadow,
    double? dyOffset,
    BoxBorder? borderButton,
    double? radius}) {
  return BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: const Color(0xff033871).withOpacity(opacityBoxShadow ?? .15),
        offset: Offset(0, dyOffset ?? 2),
        blurRadius: 5.5,
        spreadRadius: 0,
      ),
    ],
    border: borderButton ??
        GradientBoxBorder(
          width: 1.w,
          gradient: LinearGradient(colors: [
            kOnPrimary.withOpacity(.7),
            kOnPrimary.withOpacity(.6),
            kOnPrimary.withOpacity(.4),
            kOnPrimary.withOpacity(.5),
          ]),
        ),
    color: kPrimary1Color,
    borderRadius: BorderRadius.circular(
      radius ?? 50.r,
    ),
  );
}

PreferredSizeWidget buildAppBarWithLogo(context) {
  return AppBar(
    toolbarHeight: 60,
    leadingWidth: 90,
    centerTitle: true,
    backgroundColor: kPrimary1Color,
    actions: const [
      Padding(
        padding: EdgeInsets.all(15),
        child: Text(
          'المنسي',
          style: TextStyle(
            color: kOnPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
        ),
      ),
    ],
  );
}

PreferredSizeWidget buildAppBarWithTitle(context,
    {required String title, String? subTitle, double? size}) {
  return AppBar(
    centerTitle: true,
    backgroundColor: kPrimary1Color,
    actions: [
      InkWell(
        onTap: () => Navigator.pop(context),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SvgPicture.asset(
            'assets/images/arrow_back_icon.svg',
          ),
        ),
      ),
    ],
    title: Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getTitleText(
          title,
          context,
          weight: FontWeight.w700,
          size: subTitle != null ? 14.sp : 20.sp,
          color: kOnPrimary,
        ),
        if (subTitle != null)
          Text(
            subTitle,
            style: getThemeData(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: kOnPrimary.withOpacity(0.7),
                  fontSize: 12,
                  height: 1.5,
                  fontFamily: 'Cairo',
                ),
          ),
      ],
    ),
  );
}

String getResourceIdFromUrl(String url) {
  Uri uri = Uri.parse(url);
  return uri.queryParameters['id'] ?? '';
}
