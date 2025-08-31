import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:step/app/modules/course_categories/course_categories_page.dart';
import 'package:step/app/modules/home/model/social_model.dart';
import 'package:step/app/modules/home_page/home_page.dart';
import 'package:step/app/modules/my_class/my_courses_page.dart';
import 'package:step/app/modules/student_profile/profile_page.dart';
import 'package:step/app/utils/helper_funcs.dart';

import '../../core/constants_and_enums/enums.dart';
import '../../core/constants_and_enums/static_data.dart';
import '../../core/data/api/ApiCall.dart';
import '../base/base_controller.dart';

class MainAppController extends BaseController {
  List<Widget> pagesForPageView = [
    const HomePage(),
    const MyCoursesPage(),
    const StudentProfile()
  ];

  List<Widget> pagesForPageViewForGuest = [
    const HomePage(),
    const CourseCategoriesPage(),
  ];

  PageController pageViewController = PageController();
  String phone = "";
  SocialMediaModel? socialMediaModel;
  var socialMediaState = ValueNotifier(AppViewState.busy);

  setPage(index) {
    currentPageIndex.value = index;
    pageViewController.jumpToPage(
      index,
      // duration: const Duration(milliseconds: 100),
      // curve: Curves.bounceIn,
    );
  }

  List<Map<String, Object>> bottomBarList() => [
        Map.of({
          "icon": "assets/images/profile_bottom_bar_ic.svg",
          "index": 2,
          "name": 'الصفحة الشخصية',
        }),
        Map.of({
          "icon": "assets/images/home_ic.svg",
          "index": 0,
          "name": "الصفحة الرئيسية",
        }),
        Map.of({
          "icon": "assets/images/my_class.svg",
          "index": 1,
          "name": "   مقرراتي   ",
        }),
      ];

  /// ليسته ال bottom navigation bar العاديه

  // List<Map<String, Object>> bottomBarListForGuest() => [
  //       Map.of({
  //         "icon": "assets/images/home_ic.svg",
  //         "index": 0,
  //         "name": getL10(context!).home,
  //       }),
  //       Map.of({
  //         "icon": "assets/images/my_class.svg",
  //         "index": 1,
  //         "name": getL10(context!).myClass,
  //       }),
  //     ];

  /// ليسته ال bottom navigation bar بتاعه ال guest

  ValueNotifier<int> currentPageIndex = ValueNotifier(0);

  // Future<void> getWhatsAppPhone() async {
  //   try {
  //     socialMediaState.value = AppViewState.busy;
  //     changeViewState(AppViewState.busy);
  //     final response = await CallApi.getRequest(
  //       "${StaticData.baseUrl}/signleteacher/apis3.php?function=get_social",
  //     );
  //     // log("response: $response");
  //     socialMediaModel = SocialMediaModel.fromJson(response["data"]);
  //     phone = response["data"]["cocoon_whatsapp_url"];
  //     socialMediaState.value = AppViewState.idle;
  //     changeViewState(AppViewState.idle);
  //   } catch (e) {
  //     //showSnackBar(context!, e.toString());
  //     log("error: $e");
  //     debugPrint(e.toString());
  //     socialMediaState.value = AppViewState.error;

  //     changeViewState(AppViewState.error);
  //   }
  // }
}
