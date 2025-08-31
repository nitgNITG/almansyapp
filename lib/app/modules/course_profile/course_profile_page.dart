import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:step/app/core/constants_and_enums/enums.dart';
import 'package:step/app/core/data/models/course.dart';
import 'package:step/app/core/extensions_and_so_on/extesions.dart';
import 'package:step/app/modules/base/base_view.dart';
import 'package:step/app/modules/course_profile/course_profile_controller.dart';
import 'package:step/app/modules/course_profile/items/course_drawer.dart';
import 'package:step/app/modules/home/home.dart';
import 'package:step/app/utils/routing_utils.dart';
import 'package:step/app/widgets/status_widgets.dart';
import 'package:step/app/widgets/texts.dart';
import '../../core/data/models/my_course.dart';
import '../../core/data/shared_preferences/helper_funcs.dart';
import '../../utils/helper_funcs.dart';
import '../home/main_app_controller.dart';

class CourseProfilePage extends StatefulWidget {
  const CourseProfilePage({super.key, this.myCourse, this.course});

  final MyCourse? myCourse;
  final Course? course;

  @override
  State<CourseProfilePage> createState() => _CourseProfilePageState();
}

class _CourseProfilePageState extends State<CourseProfilePage>
    with TickerProviderStateMixin {
  late final CourseProfileController controller;
  final MainAppController controller1 = MainAppController();

  @override
  void initState() {
    controller = CourseProfileController();
    controller.getCourseDetails(getCourseId());

    controller.isEnrolledToCourse.addListener(() {
      if (!controller.isEnrolledToCourse.value) {
        showMyDialog();
      }
    });
    // controller1.getWhatsAppPhone();
    super.initState();
  }

  showMyDialog() {
    showDialog(
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          Navigator.pushAndRemoveUntil(
            context,
            routeToPage(const HomeMainParentPage()),
            (route) => false,
          );
          return false;
        },
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 2.0,
            sigmaY: 1.5,
          ),
          child: AlertDialog(
            backgroundColor: getThemeData(context).colorScheme.surface,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                getNormalText(
                  getL10(context).notes,
                  context,
                  color: getThemeData(context).colorScheme.onSurface,
                  weight: FontWeight.bold,
                  size: 22,
                ),
                const Spacer(),
                Container(
                  child: SvgPicture.asset(
                    "assets/images/close_ic.svg",
                  ).onTap(() {
                    //Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(context,
                        routeToPage(const HomeMainParentPage()), (c) => false);
                  }),
                )
              ],
            ),
            titlePadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            actionsAlignment: MainAxisAlignment.start,
            content: SizedBox(
              height: getScreenHeight(context) * 0.15,
              child: Column(
                children: [
                  getNormalText(
                    "أنت غير مسجل في هذه الدورة تواصل مع الدعم على الواتساب للتسجيل",
                    context,
                    // color: kOnPrimary,
                    align: TextAlign.center,
                  ),
                  const Spacer(),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      height: getScreenHeight(context) * 0.05,
                      child: SvgPicture.asset("assets/images/whatsapp_ic.svg"),
                    ),
                  ).onTap(() {
                    /// فانكشن الواتساب
                    contactUsWhatsapp(controller1.phone);
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
      barrierColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.15),
    );
  }

  String getCourseId() {
    return widget.course == null ? widget.myCourse!.id : widget.course!.id;
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CourseProfileController>(
        injectedObject: controller,
        child: Scaffold(
          appBar: buildAppBarWithTitle(context,
              title: getTitle(), subTitle: getSubTitle(), size: 20),
          drawer: ValueListenableBuilder(
              valueListenable: controller.state,
              builder: (context, state, widget) {
                if (state == AppViewState.idle &&
                    controller.isUserTeacherOfThisCourseOrAdmin()) {
                  return CourseDrawer(controller,
                      title: getTitle(),
                      subtitle: getSubTitle(),
                      image: getImage());
                }
                return const SizedBox();
              }),
          body: ValueListenableBuilder<AppViewState>(
            valueListenable: controller.state,
            builder: (context, state, widget) =>
                getWidgetDependsInAppViewState(state, onClick: () {
              controller.getCourseDetails(getCourseId());
            },
                    PageView.builder(
                      controller: controller.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.getPages(context).length,
                      itemBuilder: (context, index) => controller
                          .getPages(context)
                          .elementAt(index)['widget'],
                    )),
          ),
        ));
  }

  String getSubTitle() {
    if (widget.course != null) {
      return widget.course!.fullName;
    }
    return widget.myCourse!.fullname;
  }

  String getImage() {
    if (widget.course != null) {
      return widget.course!.imageUrl;
    }
    return widget.myCourse!.imageUrl;
  }

  String getTitle() {
    if (widget.course != null) {
      return widget.course!.shortName;
    }
    return widget.myCourse!.shortname;
  }
}
