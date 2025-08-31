import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:step/app/core/themes/colors.dart';
import 'package:step/app/modules/base/profile_controller.dart';
import 'package:step/app/widgets/custom_container_button.dart';
import 'package:step/app/modules/register/widgets/build_show_dialog.dart';
import 'package:step/app/utils/validators.dart';
import 'package:step/app/widgets/texts.dart';
import '../../../utils/helper_funcs.dart';
import '../../../widgets/form_fields.dart';

class EditProfileBottomSheet extends StatelessWidget {
  const EditProfileBottomSheet({
    super.key,
    required this.controller,
  });

  final BaseProfileController controller;

  @override
  Widget build(BuildContext context) {
    log("Edit Profile is lastNameController: ${controller.lastNameController.text}");
    log("Edit Profile is firstNameController: ${controller.firstNameController.text}");
    log("Edit Profile is phoneController: ${controller.phoneController.text}");

    // controller.studentPhoneNumber_2.text =
    //     SharedPreferencesService.instance.getString('code') ?? '+966';
    return Scaffold(
      appBar: buildAppBarWithTitle(
        context,
        title: getL10(
          context,
        ).editProfile,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 33.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getHeightSpace(28.h),
                getTitleText(
                  'تعديل الملف الشخصي',
                  context,
                  color: const Color(0xff000000),
                ),
                getHeightSpace(31.h),
                Container(
                  // (MediaQuery.of(context).padding.top) -
                  // kToolbarHeight -

                  width: getScreenWidth(context),
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: getThemeData(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(24),
                  ),

                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: TextFormFieldWidget(
                                cursorColor: kPrimaryColor,
                                heightOfBoty: 60,
                                textStyleColor: kTextFeildColor,
                                title: 'الاسم الاول',
                                // fillColor: Colors.grey.shade400,
                                controller: controller.firstNameController,
                                validatetor: Validators(context).validateName,
                                titleColor: kTextFeildColor,

                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: kTextFeildColor)),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: kTextFeildColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            getWidthSpace(27.w),
                            Expanded(
                              child: TextFormFieldWidget(
                                cursorColor: kPrimaryColor,
                                heightOfBoty: 60,
                                //heightOfBoty: 35,
                                textStyleColor: kTextFeildColor,
                                title: 'الاسم الاخير',
                                //  fillColor: Colors.grey.shade400,
                                validatetor: Validators(context).validateName,
                                controller: controller.lastNameController,
                                titleColor: kTextFeildColor,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: kTextFeildColor)),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: kTextFeildColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        getHeightSpace(10),
                        TextFormFieldWidget(
                          getwith: 5,
                          cursorColor: kPrimaryColor,
                          textStyleColor: kTextFeildColor,
                          title: "رقم الهاتف",
                          // title: getL10(context).phone,
                          controller: controller.phoneController,
                          textInputType: TextInputType.phone,
                          titleColor: kTextFeildColor,
                          validatetor: (value) {
                            return Validators(context).validatePhone1(
                              controller.studentPhoneNumber_2.text,
                              controller.phoneController.text,
                            );
                          },
                          decoration: InputDecoration(
                            disabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: kTextFeildColor)),
                            border: const UnderlineInputBorder(
                                borderSide: BorderSide(color: kTextFeildColor)),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: kTextFeildColor)),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: kTextFeildColor,
                              ),
                            ),
                            prefixIcon: SizedBox(
                              width: 95,
                              // height: 10,
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return BuildShowDialog(
                                          controller: controller);
                                    },
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 0),
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
                                                  fontWeight: FontWeight.w300,
                                                  color: kTextFeildColor,
                                                ),
                                          );
                                        },
                                      ),
                                    ),
                                    const Icon(
                                      size: 19,
                                      Icons.arrow_drop_down,
                                      color: kTextFeildColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        getHeightSpace(10),
                      ],
                    ),
                  ),
                ),
                // const Spacer(),
                getHeightSpace(20),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CustomContainerButton(
                    width: double.infinity,
                    size: 18.sp,
                    text: 'Save',
                    textColor: kOnPrimary,
                    onPressed: () {
                      controller.updateUserData(context);
                    },
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff033871).withOpacity(.25),
                        offset: const Offset(0, 4),
                        spreadRadius: 0,
                        blurRadius: 5.5,
                      ),
                    ],
                    border: GradientBoxBorder(
                      width: 1,
                      gradient: LinearGradient(colors: [
                        kOnPrimary.withOpacity(0.7),
                        kOnPrimary.withOpacity(0.6),
                        kOnPrimary.withOpacity(0.5),
                        kOnPrimary.withOpacity(0.4),
                      ]),
                    ),
                    gradient: const LinearGradient(
                      colors: [
                        kPrimary1Color,
                        kSecondary1Color,
                      ],
                    ),
                  ),
                ),
                getWidthSpace(10),
                Expanded(
                  child: CustomContainerButton(
                    width: double.infinity,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff033871).withOpacity(.25),
                        blurRadius: 5.5,
                        spreadRadius: 0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    size: 18.sp,
                    text: 'Cancel',
                    textColor: kPrimary1Color,
                    backgroundcolor: kOnPrimary,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    border: GradientBoxBorder(
                      width: 1.w,
                      gradient: LinearGradient(
                        colors: [
                          kOnPrimary.withOpacity(0.7),
                          kOnPrimary.withOpacity(0.6),
                          kOnPrimary.withOpacity(0.5),
                          kOnPrimary.withOpacity(0.4),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // getHeightSpace(10)
        ],
      ),
    );
  }
}
