import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step/app/core/themes/colors.dart';
import 'package:step/app/widgets/texts.dart';

buildShowDialogAuth(context, {required String message, String? phone}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            getNormalText(
              'خطا',
              context,
              color: kPrimary1Color,
              weight: FontWeight.bold,
              size: 22.sp,
            ),
            const Spacer(),
            const Icon(
              Icons.close,
              color: kPrimary1Color,
            ),
          ],
        ),
        content: Text(message,
            style: const TextStyle(
              color: kPrimary1Color,
              fontWeight: FontWeight.w500,
              fontFamily: 'Cairo',
            )),
      );
    },
  );
}
