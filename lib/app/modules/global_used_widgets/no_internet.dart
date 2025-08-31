import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:step/app/core/themes/colors.dart';
import 'package:step/app/widgets/texts.dart';

import '../../utils/helper_funcs.dart';
import '../../widgets/custom_container_button.dart';

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  extendBody: true,
      // This allows the body to extend behind the AppBar
      // extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,

      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash_background.png'),
            fit: BoxFit.fill,
          ),
        ),
        // fit: StackFit.expand,
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const Spacer(
                      flex: 2,
                    ),

                    /// صوره الخلفيه بتاعه الصفحه
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image.asset(
                        //   "assets/images/app_logo.png",
                        //   // height: getScreenSize(context).height * 0.15,
                        //   width: 191.w,
                        // ),
                      ],
                    ),
                    const Spacer(),

                    /// تحت الزرار في صوره
                    SizedBox(
                      height: .4.sh,
                      width: double.infinity,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Positioned(
                              //      right: 30.w,
                              //  bottom: 100.h,
                              top: 0.h,
                              left: 150.w,
                              child: SvgPicture.asset(
                                'assets/images/Union.svg',
                                height: 214.h,
                                width: 214.w,
                              )),
                          Container(
                            // height: 263.h,
                            width: 263.w,
                            padding: const EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0xff000000)
                                        .withOpacity(.25),
                                    blurRadius: 4,
                                    spreadRadius: -2,
                                    offset: const Offset(0, 2)),
                              ],
                              image: const DecorationImage(
                                // fit: BoxFit.fill,
                                image: AssetImage(
                                  "assets/images/no_internet_icon.png",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// صوره النت مفصول
                    getTitleText(
                      /// كلمه please confirm
                      'No internet connection',
                      context,
                      size: 24.sp,
                      weight: FontWeight.w700,
                      color: kOnPrimary,
                    ),
                    getHeightSpace(11),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 33.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: getTitleText(
                              align: TextAlign.center,
                              'Please check your internet connectivity and try again later',
                              context,
                              size: 20.sp,
                              weight: FontWeight.w700,
                              color: kOnPrimary,
                            ),
                          ),

                          /// كلمه مفيش اتصال بالانترنت
                        ],
                      ),
                    ),
                    const Spacer(),

                    CustomContainerButton(
                      backgroundcolor: kOnPrimary,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff033871).withOpacity(.25),
                          spreadRadius: 0,
                          blurRadius: 5.5,
                          offset:
                              const Offset(0, 4), // changes position of shadow
                        ),
                      ],
                      text: getL10(context).tryAgain,
                      textColor: kOnPrimary,
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            kPrimary1Color,
                            kSecondary1Color,
                          ]),
                      border: GradientBoxBorder(
                        width: 1,
                        gradient: LinearGradient(colors: [
                          kOnPrimary.withOpacity(.7),
                          kOnPrimary.withOpacity(.6),
                          kOnPrimary.withOpacity(.4),
                          kOnPrimary.withOpacity(.5),
                        ]),
                      ),
                      onPressed: () {},
                    ),
                    // Container(

                    /// زرار try again
                    const Spacer(
                      flex: 2,
                    ),

                    /// عناصر الصفحه نفسها
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
