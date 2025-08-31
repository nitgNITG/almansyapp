import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step/app/core/extensions_and_so_on/extesions.dart';
import 'package:step/app/core/themes/colors.dart';
import 'package:step/app/modules/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:step/app/modules/register/create_account.dart';
import 'package:step/app/utils/routing_utils.dart';
import 'package:step/app/widgets/custom_button.dart';
import 'package:step/app/widgets/custom_copy_right_text.dart';
import 'package:step/app/widgets/texts.dart';
import '../../utils/helper_funcs.dart';
import '../../widgets/form_fields.dart';
import '../base/base_view.dart';
import '../home/main_app_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    //this.connectivityResult
  });
//  final ConnectivityResult? connectivityResult;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginController controller;
  final MainAppController controller1 = MainAppController();

  @override
  void initState() {
    controller = LoginController();
    //controller1.getWhatsAppPhone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  using to check internet connection
    return BaseView<LoginController>(
      injectedObject: controller,
      //connectivityResult: widget.connectivityResult,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                    Image.asset(
                      'assets/images/splash/login.png',
                    ),
                    const Spacer(),
                    // getHeightSpace(13.h),
                    const Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 34.w,
                      ),
                      child: TextFormFieldWidget(
                        title: 'البريد الالكتروني',
                        controller: controller.emailController,
                        titleColor: Colors.black,
                        heightOfBoty: 40,
                        showCounter: false,
                        // maxLength: 14,
                        textInputType: TextInputType.emailAddress,
                        formatters: [
                          NoSpaceFormatter(),
                        ],
                      ),
                    ),
                    getHeightSpace(10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 34.w,
                      ),
                      child: PasswordFormField(
                        title: 'كلمة المرور',
                        controller: controller.passwordController,
                        titleColor: Colors.black,
                        bodyHeight: 40,
                      ),
                    ),
                    getHeightSpace(26.h),
                    CustomButton(
                        text: getL10(context).login,
                        onPressed: () async {
                          controller.login(controller1.phone);
                        },
                        controller: controller),
                    getHeightSpace(9.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        getNormalText(
                          'ليس لديك حساب ؟ ',
                          context,
                          weight: FontWeight.w500,
                          color: Colors.black,
                          size: 14.sp,
                        ),
                        getWidthSpace(5.w),
                        getNormalText(
                          'إنشاء حساب ',
                          context,
                          weight: FontWeight.bold,
                          color: kPrimaryColor,
                          size: 14.sp,
                          decoration: TextDecoration.underline,
                          decorationColor: kPrimary1Color,
                        ).onTap(() {
                          Navigator.of(context)
                              .push(routeToPage(const RegisterPage()));
                        }),
                      ],
                    ),
                    const Spacer(
                      flex: 2,
                    ),
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
      ),
    );
  }
}
