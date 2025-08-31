import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomCopyRightText extends StatelessWidget {
  const CustomCopyRightText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'كل الحقوق محفوظة.2024 © الشركة الوطنية ',
            style: TextStyle(
              color: const Color(0xff000000),
              // height: 1.8.h,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Cairo',
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: Baseline(
              baseline: 11.sp, // نفس الـ fontSize تقريبًا
              baselineType: TextBaseline.alphabetic,
              child: GestureDetector(
                onTap: () {
                  launchURL("https://nitg-eg.com/en");
                },
                child: Text(
                  'N.I.T',
                  style: TextStyle(
                    color: const Color(0xff000000),
                    // height: 1.8.h,
                    fontSize: 10.sp,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: const Color(0xff000000),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
