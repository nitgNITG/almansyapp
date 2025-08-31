import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:step/app/core/constants_and_enums/enums.dart';
import 'package:step/app/core/data/api/ApiCall.dart';
import 'package:step/app/modules/base/base_controller.dart';
import 'package:step/app/modules/home_page/model/image_gallery_model.dart';
import 'package:step/app/widgets/messages.dart';

import '../../core/constants_and_enums/static_data.dart';
import '../../core/data/models/category.dart';
import '../../core/data/models/my_course.dart';

class HomeController extends BaseController {
  List<AcademicStage> categoriesList = [];

  // List<MyCourse> myCoursesList = [];
  //List<String> aboutAcademyVideos = [];
  List<String> aboutAcademyTeachers = [];
  List<String> aboutAcademyFreeLessons = [];
  List<MyCourse> myCourses = [];
  ImageGalleryModel? imageGalleryModel;
  var imageGalleryState = ValueNotifier(AppViewState.busy);
  var aboutAcademyState = ValueNotifier(AppViewState.busy);
  var aboutAcademyTeachersState = ValueNotifier(AppViewState.busy);
  var aboutAcademyFreeLessonsState = ValueNotifier(AppViewState.busy);
  var categoriesState = ValueNotifier(AppViewState.busy);

  String aboutAcademyDescription = "";
  // phone is return get settings not ready
  String phone = "";
  Future<void> getCategories() async {
    try {
      categoriesState.value = AppViewState.busy;
      changeViewState(AppViewState.busy);
      final response = await CallApi.getRequest(
        "${StaticData.baseUrl}/academyApi/json.php?function=getCategoriesWithSubcategories",
      );
      //log("response categories: $response");
      if (response['status'] != 'fail') {
        categoriesList = (response['data'] as List)
            .map((e) {
              return AcademicStage.fromJson(e);
            })
            .cast<AcademicStage>()
            .toList();
        changeViewState(AppViewState.idle);
        categoriesState.value = AppViewState.idle;
        log("Success categories");
      }
    } catch (e) {
      debugPrint(e.toString());
      changeViewState(AppViewState.error);
      categoriesState.value = AppViewState.error;
    }
  }

  Future<void> getEnrollCourses() async {
    try {
      changeViewState(AppViewState.busy);
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
        log("Success my courses(EnrollCourses)");
      }
    } catch (e) {
      debugPrint(e.toString());
      showSnackBar(context!, e.toString());
      changeViewState(AppViewState.error);
    }
  }

  Future<void> getAboutAcademy() async {
    try {
      aboutAcademyState.value = AppViewState.busy;
      changeViewState(AppViewState.busy);
      final response = await CallApi.getRequest(
        "${StaticData.baseUrl}/academyApi/json.php?function=aboutInfo",
      );
      aboutAcademyDescription = response['about_1_block']['text'];
      //phone = response['phonenumber'];
      changeViewState(AppViewState.idle);
      aboutAcademyState.value = AppViewState.idle;
    } catch (e) {
      // showSnackBar(context!, e.toString());
      debugPrint(e.toString());
      changeViewState(AppViewState.error);
      aboutAcademyState.value = AppViewState.error;
    }
  }

  Future<void> getAboutAcademyTeachers() async {
    try {
      aboutAcademyTeachersState.value = AppViewState.busy;
      changeViewState(AppViewState.busy);
      final response = await CallApi.getRequest(
        "${StaticData.baseUrl}/academyApi/json.php?function=our_teachers",
      );

      aboutAcademyTeachers = (response['data'] as List)
          .map((e) {
            return e['filename'];
          })
          .cast<String>()
          .toList();

      changeViewState(AppViewState.idle);
      aboutAcademyTeachersState.value = AppViewState.idle;
    } catch (e) {
      // showSnackBar(context!, e.toString());
      debugPrint(e.toString());
      changeViewState(AppViewState.error);
      aboutAcademyTeachersState.value = AppViewState.error;
    }
  }

  Future<void> getAboutAcademyFreeLessons() async {
    try {
      aboutAcademyFreeLessonsState.value = AppViewState.busy;
      changeViewState(AppViewState.busy);
      final response = await CallApi.getRequest(
        "${StaticData.baseUrl}/academyApi/json.php?function=our_teachers2",
      );

      aboutAcademyFreeLessons = (response['data'] as List)
          .map((e) {
            return e['filename'];
          })
          .cast<String>()
          .toList();

      changeViewState(AppViewState.idle);
      aboutAcademyFreeLessonsState.value = AppViewState.idle;
    } catch (e) {
      // showSnackBar(context!, e.toString());
      debugPrint(e.toString());
      changeViewState(AppViewState.error);
      aboutAcademyFreeLessonsState.value = AppViewState.error;
    }
  }

  Future<void> getImageGallery() async {
    try {
      imageGalleryState.value = AppViewState.busy;
      changeViewState(AppViewState.busy);
      final response = await CallApi.getRequest(
        "${StaticData.baseUrl}/academyApi/json.php?function=image_gallery",
      );
      //log("response image gallery: $response");
      imageGalleryModel = ImageGalleryModel.fromJson(response);
      changeViewState(AppViewState.idle);
      imageGalleryState.value = AppViewState.idle;
    } catch (e) {
      //showSnackBar(context!, e.toString());
      debugPrint(e.toString());
      changeViewState(AppViewState.error);
      imageGalleryState.value = AppViewState.error;
    }
  }
  // Future<void> loadData() async {
  //   try {
  //     final String response =
  //         await rootBundle.loadString('assets/others/test.json');
  //     final data = await json.decode(response);
  //     dataModel.value = DataModel.fromJson(data);
  //     // update();
  //     // log(dataModel.value!.data[2].content[2].imageUrl.toString());
  //     // log(dataModel.value!.phonenumber.toString());

  //     changeViewState(AppViewState.idle);
  //     // dataModel = AppViewState.idle; // Notify listeners to update the UI
  //   } catch (e) {
  //     log('errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
  //     print("Error loading data: $e");
  //     changeViewState(AppViewState.error);
  //   }
  // }
}
