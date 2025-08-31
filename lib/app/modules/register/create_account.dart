import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:step/app/core/extensions_and_so_on/extesions.dart';
import 'package:step/app/core/themes/colors.dart';
import 'package:step/app/modules/base/base_view.dart';
import 'package:step/app/modules/home/main_app_controller.dart';
import 'package:step/app/modules/login/login_page.dart';
import 'package:step/app/modules/register/create_account_controller.dart';
import 'package:step/app/utils/helper_funcs.dart';
import 'package:step/app/utils/routing_utils.dart';
import 'package:step/app/widgets/custom_copy_right_text.dart';
import 'package:step/app/widgets/form_fields.dart';
import 'package:step/app/widgets/texts.dart';

import '../../core/constants_and_enums/enums.dart';
import '../../utils/validators.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/status_widgets.dart';
import 'widgets/build_show_dialog.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final RegisterController controller;
  final MainAppController controller1 = MainAppController();

  @override
  void initState() {
    controller = RegisterController();
//    controller1.getWhatsAppPhone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterController>(
        injectedObject: controller,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'إنشاء حساب',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: 'Cairo',
              ),
            ),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 34.w),
                        child: Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              getHeightSpace(13.h),
                              TextFormFieldWidget(
                                titleColor: Colors.black,
                                heightOfBoty: 60,
                                title: 'الاسم الاول',
                                controller: controller.studentName_1,
                                validatetor: Validators(context).validateName,
                              ),
                              getHeightSpace(5.h),
                              TextFormFieldWidget(
                                titleColor: Colors.black,
                                heightOfBoty: 60,
                                title: 'الاسم الاخير',
                                controller: controller.studentName_4,
                                validatetor: Validators(context).validateName,
                              ),
                              getHeightSpace(5.h),
                              TextFormFieldWidget(
                                titleColor: Colors.black,
                                heightOfBoty: 60,
                                title: 'البريد الالكتروني',
                                controller: controller.studentEmail,
                                textInputType: TextInputType.emailAddress,
                                validatetor: Validators(context).validateEmail,
                              ),

                              /// حقل الايميل
                              getHeightSpace(5.h),
                              TextFormFieldWidget(
                                heightOfBoty: 60,
                                titleColor: Colors.black,
                                getwith: 5,
                                suffixIcon: SizedBox(
                                  width: 95,
                                  height: 10,
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return BuildShowDialog(
                                            controller: controller,
                                          );
                                        },
                                      );
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 10),
                                          child: ValueListenableBuilder<
                                              TextEditingValue>(
                                            valueListenable:
                                                controller.studentPhoneNumber_2,
                                            builder: (context, value, child) {
                                              return Text(
                                                value.text,
                                                style: getThemeData(context)
                                                    .textTheme
                                                    .displayMedium!
                                                    .copyWith(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontFamily: 'Cairo',
                                                    ),
                                              );
                                            },
                                          ),
                                        ),
                                        const Icon(
                                          size: 19,
                                          Icons.arrow_drop_down,
                                          color: kOnPrimary,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                title: getL10(context).phone,
                                controller: controller.studentPhoneNumber_1,
                                textInputType: TextInputType.phone,
                                validatetor: (value) {
                                  return Validators(context).validatePhone1(
                                    controller.studentPhoneNumber_2.text,
                                    controller.studentPhoneNumber_1.text,
                                  );
                                },
                              ),
                              getHeightSpace(5.h),

                              PasswordFormField(
                                bodyHeight: 60,
                                titleColor: Colors.black,
                                getwith: 5,
                                title: 'كلمة المرور',
                                controller: controller.studentPassword,
                                validatetor: (value) {
                                  if ((value?.isNotEmpty ?? false) &&
                                      value!.length > 4) {
                                    return null;
                                  }
                                  return getL10(context)
                                      .pleaseEnterValidPaswordLengthMustBeMoreThan4;
                                },
                              ),

                              /// حقل الباسوورد
                            ],
                          ),
                        ),
                      ),
                      getHeightSpace(26.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 34.w),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                  text: 'بالنقر على إنشاء حساب فإنك توافق علي ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    fontFamily: 'Cairo',
                                  )),
                              TextSpan(
                                text: 'الشروط وسياسة الخصوصية',
                                style: const TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  fontFamily: 'Cairo',
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    controller.getTermsAndConditions();
                                    buildShowDialogTermsAndConditions(context);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      getHeightSpace(13.h),
                      CustomButton(
                          text: 'إنشاء حساب',
                          onPressed: () {
                            controller.register(context, controller1.phone);
                          },
                          controller: controller),
                      getHeightSpace(9.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 34.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            getNormalText(
                              ' لديك حساب  بالفعل؟',
                              context,
                              color: kPrimary1Color,
                              weight: FontWeight.w700,
                              size: 14.sp,
                            ),
                            getWidthSpace(5),
                            getNormalText(
                              'تسجيل دخول',
                              context,
                              weight: FontWeight.w700,
                              color: kPrimary1Color,
                              decoration: TextDecoration.underline,
                              decorationColor: kPrimary1Color,
                              //decorationColor:
                              size: 14.sp,
                            ).onTap(() {
                              Navigator.of(context)
                                  .push(routeToPage(const LoginPage()));
                            }),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 68.w),
                        child: const CustomCopyRightText(),
                      ),
                      getHeightSpace(20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  void buildShowDialogTermsAndConditions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 2.0,
          sigmaY: 1.5,
        ),
        child: AlertDialog(
          backgroundColor: getThemeData(context).colorScheme.surface,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              getNormalText(
                "الشروط وسياسة الخصوصية",
                context,
                color: getThemeData(context).colorScheme.onSurface,
                weight: FontWeight.bold,
                size: 15.sp,
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
            horizontal: 12,
            vertical: 20,
          ),
          actionsAlignment: MainAxisAlignment.start,
          content: SizedBox(
            height: getScreenHeight(context) * 0.7,
            child: ValueListenableBuilder(
                valueListenable: controller.termsAndConditionsState,
                builder: (context, state, child) {
                  if (state == AppViewState.error) {
                    return TryAgainErrorWidget(onclickTryAgain: () {
                      controller.getTermsAndConditions();
                    });
                  } else if (state == AppViewState.busy) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          HtmlWidget(
                            controller.termsAndConditions.value,
                            renderMode: const ColumnMode(),
                            textStyle: const TextStyle(color: kPrimary1Color),
                          ),
                        ],
                      ),
                    );
                  }
                }),
          ),
        ),
      ),
      //barrierDismissible: false,
      barrierColor: const Color.fromARGB(0, 0, 0, 0).withOpacity(0.15),
    );
  }
}
