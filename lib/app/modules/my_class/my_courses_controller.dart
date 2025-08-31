import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:step/app/core/constants_and_enums/enums.dart';
import 'package:step/app/core/data/models/my_course.dart';
import 'package:step/app/modules/base/base_controller.dart';

import '../../core/constants_and_enums/static_data.dart';
import '../../core/data/api/ApiCall.dart';

class MyCoursesController extends BaseController {
  List<MyCourse> myCourses = [];
  Future<void> getEnrollCourses() async {
    try {
      changeViewState(AppViewState.busy);
      log("token: ${getLoggedUser().token}");
      final response = await CallApi.getRequest(
        "${StaticData.baseUrl}/academyApi/json.php?function=get_enrol_courses&token=${getLoggedUser().token}",
      );
      //log("response my courses(EnrollCourses): $response");
      if (response['status'] != 'fail') {
        myCourses = (response['courses'] as List)
            .map((e) {
              return MyCourse.fromJson(e);
            })
            .cast<MyCourse>()
            .toList();

        changeViewState(AppViewState.idle);
      }
    } catch (e) {
      debugPrint(e.toString());
      changeViewState(AppViewState.error);
    }
  }

  List<MyCourse> myCoursesFiltered = [];
  filter(String str) {
    {
      myCoursesFiltered = myCourses
          .where((element) =>
              element.fullname.contains(str) || element.shortname.contains(str))
          .toList();
    }
  }
}
