import 'package:step/app/core/constants_and_enums/static_data.dart';
import 'package:step/app/core/data/models/my_course.dart';
import 'package:step/app/modules/base/profile_controller.dart';

import '../../core/constants_and_enums/enums.dart';
import '../../core/data/api/ApiCall.dart';

class ProfileController extends BaseProfileController {
  List<MyCourse> myCoursesList = [];

  Future getAllCourses() async {
    try {
      changeViewState(AppViewState.busy);
      final response = await CallApi.getRequest(
        "${StaticData.baseUrl}/academyApi/json.php?function=get_enrol_courses&token=${getLoggedUser().token}",
      );

      if (response['status'] != 'fail') {
        myCoursesList = (response['courses'] as List)
            .map((e) {
              return MyCourse.fromJson(e);
            })
            .cast<MyCourse>()
            .toList();
        changeViewState(AppViewState.idle);
      }
    } catch (e) {
      changeViewState(AppViewState.error);
      print(e.toString());
    }
  }

}

