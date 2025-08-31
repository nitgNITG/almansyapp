import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step/app/core/constants_and_enums/enums.dart';
import 'package:step/app/core/extensions_and_so_on/extesions.dart';
import 'package:step/app/core/themes/colors.dart';
import 'package:step/app/modules/base/base_view.dart';
import 'package:step/app/modules/course_profile/course_profile_page.dart';
import 'package:step/app/modules/my_class/my_courses_controller.dart';
import 'package:step/app/utils/helper_funcs.dart';
import 'package:step/app/utils/routing_utils.dart';
import 'package:step/app/widgets/texts.dart';

import '../../../main.dart';
import '../../core/data/models/course.dart';
import '../../core/data/models/my_course.dart';
import '../../core/global_used_widgets/general_use.dart';
import '../home_page/home_controller.dart';

class MyCoursesPage extends StatefulWidget {
  const MyCoursesPage({super.key});

  @override
  State<MyCoursesPage> createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage> {
  late final MyCoursesController controller;

  getPageHeight(BuildContext context) {
    return getScreenSize(context).height - getTopPadding(context);
  }

  @override
  void initState() {
    controller = MyCoursesController();
    runGetCourses();
    super.initState();
  }

  runGetCourses() {
    controller.getEnrollCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: buildAppBarWithLogo(context),
      backgroundColor: Colors.white.withOpacity(0),
      body: BaseView<MyCoursesController>(
        injectedObject: controller,
        child: SizedBox(
          height: getPageHeight(context),
          width: getScreenSize(context).width,
          child:
              // Column(
              //   children: [
              // NormalAppBar(
              //   title: getL10(context).myClass,
              //   icon: "assets/images/my_class.svg",
              // ),
              ValueListenableBuilder(
            valueListenable: controller.state,
            builder: (BuildContext context, AppViewState value, Widget? child) {
              if (value == AppViewState.busy) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.myCourses.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: getNormalText(
                        align: TextAlign.center,
                        "أنت غير مسجل في دورات تعليمية تواصل مع الدعم على الواتساب للتسجيل",
                        context,
                        color: kPrimary1Color),
                  ),
                );
              }

              return GridView.builder(
                itemCount: controller.myCourses.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  //crossAxisSpacing: 0,
                  mainAxisExtent: 180,
                  //childAspectRatio: 1 / 10,
                  // childAspectRatio: 15 / 11
                  // mainAxisSpacing: 8.0,
                  // mainAxisExtent: 1.0,
                ),
                itemBuilder: (context, index) => Container(
                  height: 250,
                  width: 200,
                  margin: const EdgeInsets.all(8),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        width: 200,
                        height: 110,
                        // padding: const EdgeInsets.symmetric(
                        //   vertical: 8,
                        // ),
                        decoration: BoxDecoration(
                          color: getThemeData(context).colorScheme.surface,
                          boxShadow: getBoxShadow(context),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(8),
                              topLeft: Radius.circular(8)),
                          image: DecorationImage(
                              image: NetworkImage(
                                controller.myCourses[index].imageUrl,
                              ),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        //right: 8,
                        child: Container(
                          height: 60,
                          width: 200,
                          alignment: Alignment.bottomCenter,
                          child: SizedBox.expand(
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: kPrimary1Color,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8))),
                              child: Center(
                                child: Text(
                                  controller.myCourses[index].fullname,
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
                    ],
                  ),
                ).onTap(() {
                  if (getIt<HomeController>().getIsUserGuest()) {
                    displayYouNeedLogin(context);
                  } else {
                    Navigator.of(context).push(
                      routeToPage(
                        CourseProfilePage(
                          myCourse: controller.myCourses[index],
                        ),
                      ),
                    );
                  }
                }),
              );
            },
          ),
        ),
      ),
    );
  }

  getCourse(int index) {
    return controller.myCourses[index];
  }
}

class CourseOrMyCourseItemFromCoursesPage extends StatelessWidget {
  const CourseOrMyCourseItemFromCoursesPage(
    this.controller, {
    super.key,
    this.course,
    this.myCourse,
  });

  final MyCoursesController controller;
  final Course? course;
  final MyCourse? myCourse;

  String getImageUrl() {
    if (course != null) {
      return course!.imageUrl;
    } else {
      return myCourse!.overviewfiles.firstOrNull == null
          ? ""
          : "${myCourse!.overviewfiles.first.fileurl}?token=${controller.getLoggedUser().token!}";
    }
  }

  String getCourseTitle() {
    if (course != null) {
      return course!.fullName;
    }
    return myCourse!.fullname;
  }

  String getCourseSubTitle() {
    if (course != null) {
      return course!.description!;
    }
    return myCourse!.summary;
  }

  getIsCourse() => course == null;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(
            getImageUrl(),
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getCourseTitle(),
            style: getThemeData(context).textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
                color: kOnPrimary,
                fontSize: 18,
                height: 1.4,
                backgroundColor: kSecondaryColor.withOpacity(0.3),
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.7),
                    offset: const Offset(2.0, 2.0),
                    blurRadius: 3.0,
                  ),
                ]),
            textAlign: TextAlign.start,
          ),
          Builder(builder: (context) {
            final summery = getCourseSubTitle();
            return Text(
              summery.substring(0, summery.length > 40 ? 40 : summery.length),
              style: getThemeData(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  color: kOnPrimary,
                  fontSize: 18,
                  height: 1.4,
                  backgroundColor: kSecondaryColor.withOpacity(0.3),
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.7),
                      offset: const Offset(2.0, 2.0),
                      blurRadius: 3.0,
                    ),
                  ]),
              textAlign: TextAlign.start,
            );
          }),
          ElevatedButton(onPressed: () {}, child: const Text("المزيد")),
          const Spacer(),

          /// progress visible if not guest
          if (getIsCourse())
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: getScreenSize(context).width * 0.72,
                  child: LinearProgressIndicator(
                    value: (myCourse!.progress / 100),
                    minHeight: 12,
                    color: kSecondaryColor,
                    backgroundColor: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                getWidthSpace(10),
                Container(
                  color: kSecondaryColor.withOpacity(0.3),
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    ("${myCourse!.progress.floorToDouble()}%"),
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
