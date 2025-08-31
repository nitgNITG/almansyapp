import 'dart:io';
import 'dart:ui';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:step/app/core/constants_and_enums/enums.dart';
import 'package:step/app/core/extensions_and_so_on/extesions.dart';
import 'package:step/app/core/themes/colors.dart';
import 'package:step/app/modules/base/base_view.dart';
import 'package:step/app/modules/global_used_widgets/app_bottom_navigation.dart';
import 'package:step/app/modules/global_used_widgets/widget_methods.dart';
import 'package:step/app/modules/home/main_app_controller.dart';
import 'package:step/app/modules/home/widgets/build_speed_Dial_social_media.dart';
import 'package:step/app/utils/helper_funcs.dart';
import 'package:step/app/widgets/status_widgets.dart';

import '../../widgets/texts.dart';

class HomeMainParentPage extends StatefulWidget {
  const HomeMainParentPage({super.key, this.connectivityResult});

  final ConnectivityResult? connectivityResult;

  @override
  State<HomeMainParentPage> createState() => _HomeMainParentPageState();
}

class _HomeMainParentPageState extends State<HomeMainParentPage> {
  final MainAppController controller = MainAppController();
  @override
  void initState() {
    super.initState();

    // controller.getWhatsAppPhone();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (popInvoked) {
        // debugPrint("invodes");
        showDialog(
          context: context,
          builder: (context) => BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 2.0,
              sigmaY: 1.5,
            ),
            child: AlertDialog(
              backgroundColor: getThemeData(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
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
                height: getScreenHeight(context) * 0.12,
                child: Column(
                  children: [
                    getNormalText(
                      'هل تريد الخروج من التطبيق؟',
                      context,
                      // color: kOnPrimary,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 80,
                          height: 40,
                          decoration: BoxDecoration(
                              color: kPrimary1Color,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                            onPressed: () {
                              exit(0);
                            },
                            child: const Text(
                              'نعم',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 40,
                          decoration: BoxDecoration(
                              color: kPrimary1Color,
                              // gradient: const LinearGradient(colors: [
                              //   kPrimary1Color,
                              //   kSecondary1Color,
                              // ]),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'الغاء',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            /// اخر حاجه خالص هل تريد الخروج ام لا
          ),
          barrierDismissible: true,
          barrierColor: const Color.fromARGB(0, 0, 0, 0).withOpacity(0.15),
        );
      },
      canPop: false,
      child: BaseView<MainAppController>(
        injectedObject: controller,
        connectivityResult: widget.connectivityResult,
        child: Container(
          color: getThemeData(context).colorScheme.surface,
          child: Stack(
            children: [
              getAppPostionedBackground(context),
              Scaffold(
                appBar: buildAppBarWithLogo(context),
                backgroundColor: Colors.white.withOpacity(0),
                // floatingActionButton: ValueListenableBuilder(
                //   valueListenable: controller.currentPageIndex,
                //   builder: (context, index, ch) {
                //     if (index == 0) {
                //       return ValueListenableBuilder(
                //         valueListenable: controller.socialMediaState,
                //         builder: (context, state, child) {
                //           if (state == AppViewState.error) {
                //             return TryAgainErrorWidget(onclickTryAgain: () {
                //               // controller.getAboutAcademy();
                //               controller.getWhatsAppPhone();
                //             });
                //           } else {
                //             return BuildSpeedDialSocialMedia(
                //                 controller: controller);
                //             // return SvgPicture.asset("assets/images/whatsapp_ic.svg")
                //             //     .onTap(
                //             //   () {
                //             //     contactUsWhatsapp(controller.phone);
                //             //   },
                //             // );
                //           }
                //         },
                //       );
                //     } else {
                //       return const SizedBox();
                //     }
                //   },
                // ),
                body: PageView.builder(
                  controller: controller.pageViewController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.getIsUserGuest()
                      ? controller.pagesForPageViewForGuest.length
                      : controller.pagesForPageView.length,
                  itemBuilder: (context, index) => controller.getIsUserGuest()
                      ? controller.pagesForPageViewForGuest[index]
                      : controller.pagesForPageView[index],
                ),
                bottomNavigationBar: !controller.getIsUserGuest()
                    ? const AppBottomNavigationBar()
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
