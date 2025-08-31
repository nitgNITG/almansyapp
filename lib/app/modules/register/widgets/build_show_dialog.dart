import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step/app/core/themes/colors.dart';
import 'package:step/app/widgets/texts.dart';

import '../../../utils/helper_funcs.dart';

class BuildShowDialog extends StatelessWidget {
  const BuildShowDialog({
    super.key,
    required this.controller,
  });

  final dynamic controller;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: controller.countries.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 9.h),
              child: InkWell(
                onTap: () async {
                  controller.studentPhoneNumber_2.text =
                      controller.countries[index].code;
                  // await SharedPreferencesService.instance
                  //     .setString('code', controller.countries[index].code);
                  Navigator.of(context).pop();
                },
                child: Row(
                  children: [
                    Image.asset(
                      controller.countries[index].image,
                      width: 23.w,
                      height: 23.h,
                    ),
                    getWidthSpace(8.w),
                    getNormalText(
                        controller.countries[index].code,
                        size: 16.sp,
                        weight: FontWeight.w700,
                        color: kPrimary1Color,
                        context),
                    getWidthSpace(5.w),
                    getNormalText(
                      controller.countries[index].name,
                      size: 16.sp,
                      weight: FontWeight.w700,
                      color: kPrimary1Color,
                      context,
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(
            color: kPrimary1Color,
          ),
        ),
      ),
    );
  }
}
