// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:step/app/core/extensions_and_so_on/extesions.dart';
// import 'package:step/app/modules/forget_password/forget_password_page.dart';
// import 'package:step/app/utils/helper_funcs.dart';
// import 'package:step/app/utils/routing_utils.dart';
// import 'package:step/app/widgets/texts.dart';

// import '../../../core/themes/colors.dart';

// class BuildForgetPassword extends StatelessWidget {
//   const BuildForgetPassword({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         //   Padding(
//         //     padding: EdgeInsets.only(left: 23.w),
//         //     child: Row(
//         //       children: [
//         //         Radio(
//         //           value: 0,
//         //           groupValue: 0,
//         //           onChanged: (value) {},
//         //           activeColor: kOnPrimary,
//         //         ),
//         //         getWidthSpace(3.w),
//         //         getNormalText(
//         //             'Remember Me',
//         //             weight: FontWeight.w700,
//         //             color: kOnPrimary,
//         //             size: 12.sp,
//         //             context)
//         //       ],
//         //     ),
//         //   ),
//         Padding(
//           padding: EdgeInsets.only(right: 32.w),
//           child: getNormalText(
//                   'Forgot Password?',
//                   weight: FontWeight.w700,
//                   color: kOnPrimary,
//                   size: 12.sp,
//                   decoration: TextDecoration.underline,
//                   decorationColor: kOnPrimary,
//                   context)
//               .onTap(
//             () {
//               Navigator.push(
//                 context,
//                 routeToPage(const ForgetPasswordPage()),
//               );
//             },
//           ),
//         )
//       ],
//     );
//   }
// }
