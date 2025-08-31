import 'dart:ui';

import 'package:step/app/core/extensions_and_so_on/extesions.dart';
import 'package:step/app/core/themes/colors.dart';
import 'package:step/app/modules/login/login_page.dart';
import 'package:step/global_providers/localization_provider.dart';
import 'package:step/global_providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../modules/register/create_account.dart';
import '../../utils/helper_funcs.dart';
import '../../utils/routing_utils.dart';
import '../../widgets/texts.dart';

class AppThemeModeWidget extends StatelessWidget {
  const AppThemeModeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: InkWell(
        onTap: () {
          Provider.of<AppThemeProvider>(
            context,
            listen: false,
          ).changeAppTheme();
        },
        child: Provider.of<AppThemeProvider>(
                  context,
                  listen: true,
                ).getAppThemeMode() !=
                ThemeMode.dark
            ? SvgPicture.asset(
                "assets/images/dark_button_ic.svg",
                height: 20,
              )
            : SvgPicture.asset(
                "assets/images/light_ic.svg",
                height: 20,
              ),
      ),
    );
  }
}

class AppLanguageChangeButton extends StatelessWidget {
  const AppLanguageChangeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<LocalizationProvider>(context, listen: false)
            .changeAppLocale();
      },
      child: Provider.of<LocalizationProvider>(context, listen: true)
                  .getAppLocale()
                  .languageCode !=
              "ar"
          ? SvgPicture.asset(
              "assets/images/ar_button_ic.svg",
              height: 20,
            )
          : SvgPicture.asset(
              "assets/images/en_ic.svg",
              height: 20,
            ),
    );
  }
}

displayYouNeedLogin(context) {
  showDialog(
    context: context,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 2.0,
        sigmaY: 1.5,
      ),
      child: AlertDialog(
        backgroundColor: getThemeData(context).colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            getNormalText(
              getL10(context).notes,
              context,
              color: getThemeData(context).colorScheme.onSurface,
              weight: FontWeight.bold,
              size: 22,
            ),
            const Spacer(),
            Container(
              child: SvgPicture.asset(
                "assets/images/close_ic.svg",
              ).onTap(() {
                Navigator.pop(context);
              }),
            )
          ],
        ),
        titlePadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        actionsAlignment: MainAxisAlignment.start,
        content: SizedBox(
          height: getScreenHeight(context) * 0.18,
          child: Column(
            children: [
              getNormalText(
                "You need to login ",
                context,
                // color: kOnPrimary,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 70,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(colors: [
                          kPrimary1Color,
                          kSecondary1Color,
                        ])),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            routeToPage(const LoginPage()), (c) => false);
                        Navigator.of(context)
                            .push(routeToPage(const RegisterPage()));
                      },
                      child: Text(
                        getL10(context).joinUs,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
                  ),

                  ///  لو معندكش اكونت login
                  Container(
                    width: 70,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                            colors: [Color(0xff002E94), Color(0xff00FFFF)])),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            routeToPage(const LoginPage()), (c) => false);
                      },
                      child: Text(
                        getL10(context).login,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
                  )

                  ///  لو معندكش اكونت join us
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: true,
    barrierColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.15),
  );
}
