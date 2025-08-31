import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step/app/core/extensions_and_so_on/extesions.dart';
import 'package:step/app/core/themes/colors.dart';
import 'package:step/app/modules/change_password/change_password_controller.dart';
import 'package:step/app/utils/helper_funcs.dart';
import 'package:step/app/widgets/custom_button.dart';
import 'package:step/app/widgets/custom_divider.dart';
import 'package:step/app/widgets/form_fields.dart';
import 'package:step/app/widgets/texts.dart';

import '../../../widgets/custom_copy_right_text.dart';

class FormBodyChangePassword extends StatefulWidget {
  const FormBodyChangePassword({super.key, required this.controller});
  final ChangePasswordController controller;

  @override
  State<FormBodyChangePassword> createState() => _FormBodyChangePasswordState();
}

class _FormBodyChangePasswordState extends State<FormBodyChangePassword> {
  bool isPasswordVisibleOldPassword = false;
  bool isPasswordVisibleNewPassword = false;
  bool isPasswordVisibleConfirmPassword = false;
  @override
  void initState() {
    super.initState();
    debugPrint("Navigating to Change Password Page");
  }

  @override
  void dispose() {
    widget.controller.oldPaasswordController.dispose();
    widget.controller.newPasswordController.dispose();
    widget.controller.confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
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
                const Spacer(
                  flex: 3,
                ),
                getTitleText(
                  'تغيير كلمة المرور',
                  weight: FontWeight.w700,
                  size: 35,
                  color: Colors.black,
                  context,
                ),
                const Spacer(
                  flex: 2,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 46.w),
                  child: getNormalText(
                    align: TextAlign.center,
                    "الآن يمكنك تغيير كلمة المرور القديمة الخاصة بك",
                    weight: FontWeight.w500,
                    size: 14,
                    color: Colors.black,
                    context,
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
                const CustomDivider(text: 'تغيير كلمة المرور'),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 34.w,
                  ),
                  child: TextFormFieldWidget(
                    title: 'كلمة المرور القديمة',
                    controller: widget.controller.oldPaasswordController,
                    titleColor: Colors.black,
                    heightOfBoty: 60,
                    showCounter: false,
                    obscureText: !isPasswordVisibleOldPassword,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordVisibleOldPassword =
                                !isPasswordVisibleOldPassword;
                          });
                        },
                        icon: Icon(
                          !isPasswordVisibleOldPassword
                              ? Icons.remove_red_eye
                              : Icons.visibility_off,
                          color: kPrimary1Color,
                        )),
                    textInputType: TextInputType.emailAddress,
                    formatters: [
                      NoSpaceFormatter(),
                    ],
                  ),
                ),
                const Spacer(
                  flex: 3,
                ),
                const CustomDivider(text: 'كلمة المرور الجديدة'),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 34.w,
                  ),
                  child: TextFormFieldWidget(
                    title: 'كلمة المرور الجديدة',
                    controller: widget.controller.newPasswordController,
                    titleColor: Colors.black,
                    heightOfBoty: 60,
                    showCounter: false,
                    obscureText: !isPasswordVisibleNewPassword,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordVisibleNewPassword =
                                !isPasswordVisibleNewPassword;
                          });
                        },
                        icon: Icon(
                          !isPasswordVisibleNewPassword
                              ? Icons.remove_red_eye
                              : Icons.visibility_off,
                          color: kPrimary1Color,
                        )),
                    // maxLength: 14,
                    textInputType: TextInputType.emailAddress,
                    formatters: [
                      NoSpaceFormatter(),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 34.w,
                  ),
                  child: TextFormFieldWidget(
                    heightOfBoty: 60,
                    title: 'تاكيد كلمة المرور الجديدة',
                    controller: widget.controller.confirmPasswordController,
                    titleColor: Colors.black,
                    obscureText: !isPasswordVisibleConfirmPassword,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordVisibleConfirmPassword =
                                !isPasswordVisibleConfirmPassword;
                          });
                        },
                        icon: Icon(
                          !isPasswordVisibleConfirmPassword
                              ? Icons.remove_red_eye
                              : Icons.visibility_off,
                          color: kPrimary1Color,
                        )),
                    showCounter: false,
                    textInputType: TextInputType.emailAddress,
                    formatters: [
                      NoSpaceFormatter(),
                    ],
                  ),
                ),
                // getHeightSpace(10.h),
                const Spacer(
                  flex: 5,
                ),
                CustomButton(
                  text: 'تاكيد',
                  onPressed: () {
                    widget.controller.changePassword(context);
                  },
                  controller: widget.controller,
                ),
                const Spacer(),
                getNormalText(
                  getL10(context).cancel,
                  context,
                  weight: FontWeight.w700,
                  color: kOnPrimary,
                  decoration: TextDecoration.underline,
                  decorationColor: kOnPrimary,
                  //decorationColor:
                  size: 14.sp,
                ).onTap(() {
                  Navigator.pop(context);
                }),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 68.w),
                  child: const CustomCopyRightText(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
