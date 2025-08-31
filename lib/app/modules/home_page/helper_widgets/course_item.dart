import 'package:flutter/material.dart';
import 'package:step/app/core/data/models/my_course.dart';
import 'package:step/app/core/themes/colors.dart';
import 'package:step/app/widgets/texts.dart';

import '../../../core/data/models/course.dart';
import '../../../utils/helper_funcs.dart';

class CourseItemHomePage extends StatelessWidget {
  const CourseItemHomePage({
    super.key,
    required this.course,
  });

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 150,
      margin: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Container(
            width: 150,
            height: 80,
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 8,
            ),
            decoration: BoxDecoration(
              color: getThemeData(context).colorScheme.surface,
              boxShadow: getBoxShadow(context),
            ),
            child: Image.network(course.imageUrl),
          ),
          Positioned(
            top: 80,
            left: 8,
            child: Container(
              height: 40,
              width: 152,
              alignment: Alignment.bottomCenter,
              child: SizedBox.expand(
                child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    // backgroundColor: kPrimaryColor,
                    disabledBackgroundColor: kPrimaryColor,
                  ),
                  child: getNormalText(
                    truncateString(course.fullName, 17),
                    context,
                    color: kOnPrimary,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CourseItemMyCourse extends StatelessWidget {
  const CourseItemMyCourse({
    super.key,
    required this.myCourse,
  });

  final MyCourse myCourse;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 150,
      margin: const EdgeInsets.all(8),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: 150,
            height: 100,
            decoration: BoxDecoration(
              color: getThemeData(context).colorScheme.surface,
              boxShadow: getBoxShadow(context),
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8), topLeft: Radius.circular(8)),
            ),
            child: Image.network(
              myCourse.imageUrl,
              height: 100,
              width: 150,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            bottom: 5,
            child: Container(
              height: 60,
              width: 150,
              alignment: Alignment.bottomCenter,
              child: SizedBox.expand(
                child: Container(
                  decoration: const BoxDecoration(
                      color: kPrimary1Color,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8))),
                  height: 50,
                  width: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Center(
                      child: Text(
                        myCourse.fullname,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    //  return SizedBox(
    // height: 110,
    // child: Container(
    //   // height: 2000,
    //   width: 150,
    //   // color: getRandomQuietColor(),
    //   margin: const EdgeInsets.all(8),
    //   child: Stack(
    //     children: [
    //       Container(
    //         width: 150,
    //         height: 100,
    //         padding: const EdgeInsets.symmetric(
    //             //vertical: 8,
    //             ),
    //         margin: const EdgeInsets.symmetric(
    //           vertical: 8,
    //           horizontal: 8,
    //         ),
    //         decoration: BoxDecoration(
    //           color: getThemeData(context).colorScheme.surface,
    //           boxShadow: getBoxShadow(context),
    //         ),
    //         child:
    // Image.network(
    //           myCourse.imageUrl,
    //           height: 100,
    //           width: 150,
    //           fit: BoxFit.fill,
    //         ),
    //       ),
    //       Positioned(
    //         top: 100,
    //         left: 8,
    //         child: Container(
    //           height: 40,
    //           width: 140,
    //           alignment: Alignment.bottomCenter,
    //           child: SizedBox.expand(
    //               child: Container(
    //             decoration: BoxDecoration(
    //               boxShadow: [
    //                 BoxShadow(
    //                   blurRadius: 10,
    //                   offset: const Offset(0, 2),
    //                   color: const Color(0xff000000).withOpacity(.25),
    //                 ),
    //               ],
    //               gradient: const LinearGradient(
    //                 colors: [
    //                   kPrimary1Color,
    //                   kSecondary1Color,
    //                 ],
    //               ),
    //               borderRadius: BorderRadius.circular(50.r),
    //               border: GradientBoxBorder(
    //                 width: 1,
    //                 gradient: LinearGradient(colors: [
    //                   kOnPrimary.withOpacity(0.7),
    //                   kOnPrimary.withOpacity(0.6),
    //                   kOnPrimary.withOpacity(0.5),
    //                   kOnPrimary.withOpacity(0.4),
    //                 ]),
    //               ),
    //             ),
    //             child: TextButton(
    //                 onPressed: null,
    //                 child: getNormalText(
    //                   truncateString(
    //                     myCourse.fullname,
    //                     18,
    //                   ),
    //                   maxLines: 1,
    //                   size: 14,
    //                   weight: FontWeight.bold,
    //                   color: kOnPrimary,
    //                   context,
    //                 )),
    //           )),
    //         ),
    //       )
    //     ],
    //   ),
    // ),
    // )
  }
}
