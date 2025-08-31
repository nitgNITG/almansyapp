import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step/app/core/data/models/category.dart';
import 'package:step/app/core/extensions_and_so_on/extesions.dart';
import 'package:step/app/core/global_used_widgets/general_use.dart';
import 'package:step/app/core/themes/colors.dart';
import 'package:step/app/modules/home_page/home_controller.dart';
import 'package:step/app/utils/helper_funcs.dart';
import 'package:step/app/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:step/main.dart';

import '../../core/data/models/course.dart';
import '../../utils/routing_utils.dart';
import '../course_profile/course_profile_page.dart';

class YearsOfStage extends StatelessWidget {
  const YearsOfStage({
    super.key,
    required this.courseCategory,
  });
  final AcademicStage courseCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWithTitle(
        context,
        title: "Academic years",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: GridView.builder(
          itemCount: courseCategory.years.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5.0,
            childAspectRatio: 15 / 12,
            // mainAxisSpacing: 8.0,
            mainAxisExtent: 150.0,
          ),
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.symmetric(
              vertical: 10.h,
            ),
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: courseCategory.years[index].categoryInstance.image,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  width: 90,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                ElevatedGradientButton(
                  title: courseCategory.years[index].categoryInstance.name,
                )
              ],
            ).onTap(() {
              if (getIt<HomeController>().getIsUserGuest()) {
                displayYouNeedLogin(context);
              } else {
                Navigator.of(context).push(
                  routeToPage(
                    CoursesOfYear(
                      courseCategory: courseCategory.years[index],
                    ),
                  ),
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}

class ElevatedGradientButton extends StatelessWidget {
  const ElevatedGradientButton({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: buildDecorationButton(),
      child:
          //  AutoSizeText(
          //   title,
          //   style: TextStyle(
          //     color: kOnPrimary,
          //     fontSize: 10.sp,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          getNormalText(
        truncateString(
          title,
          18,
        ),
        context,
        size: 14,
        weight: FontWeight.bold,
        color: kOnPrimary,
      ),
    );
  }
}

class CoursesOfYear extends StatelessWidget {
  const CoursesOfYear({
    super.key,
    required this.courseCategory,
  });
  final AcademicYear courseCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWithTitle(context, title: getL10(context).courses),
      body:
          // SizedBox(
          ///   height: getScreenHeight(context),
          ///   width: getScreenWidth(context),
          //  child: Column(
          //   children: [
          // NormalAppBar(
          //   title: getL10(context).courses,
          // ),
          // Expanded(
          //   child:
          GridView.builder(
              itemCount: courseCategory.courses.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                childAspectRatio: 9 / 10,
                //childAspectRatio: 15 / 11,
                // mainAxisSpacing: 8.0,
                // mainAxisExtent: 1.0,
              ),
              itemBuilder: (context, index) => CourseItemOfYear(
                    e: courseCategory.courses[index],
                  )),
      // ),
      // ],
      // ),
      // ),
    );
  }
}

class CourseItemOfYear extends StatelessWidget {
  const CourseItemOfYear({super.key, required this.e});
  final Course e;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 120,
      width: 150,
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          Column(
            children: [
              Container(
                width: 100,
                // height: 80,
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                margin: const EdgeInsets.symmetric(
                  vertical: 1,
                  horizontal: 8,
                ),
                child: CachedNetworkImage(
                  imageUrl: e.imageUrl,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  width: 150,
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                // Image.network(
                //   e.imageUrl,
                //   width: 150,
                //   fit: BoxFit.fill,
                // ),
              ),
              Container(
                decoration: buildDecorationButton(),
                //  BoxDecoration(
                //   borderRadius: BorderRadius.circular(8),
                //   color: Colors.cyan,
                // ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 5,
                ),
                child: getNormalText(
                  truncateString(e.fullName, 25),
                  context,
                  color: kOnPrimary,
                  weight: FontWeight.bold,
                ),
              ),
            ],
          ).onTap(() {
            Navigator.of(context).push(
              routeToPage(
                CourseProfilePage(
                  course: e,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
