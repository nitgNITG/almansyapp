import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:step/app/core/constants_and_enums/enums.dart';
import 'package:step/app/core/constants_and_enums/static_data.dart';
import 'package:step/app/core/data/api/ApiCall.dart';
import 'package:step/app/modules/base/base_controller.dart';
import 'package:step/app/widgets/messages.dart';

class ChangePasswordController extends BaseController {
  final oldPaasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void changePassword(context) async {
    log("oldPaasswordController.text : ${oldPaasswordController.text}");
    log("newPasswordController.text : ${newPasswordController.text}");
    log("token : ${getLoggedUser().token}");
    if (oldPaasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      {
        showToast(context, "جميع الحقول مطلوبة");
        return;
      }
    }
    if (newPasswordController.text != confirmPasswordController.text) {
      showToast(context, "كلمة المرور الجديدة وتأكيد كلمة المرور لا يتطابقان");
      return;
    }
    if (newPasswordController.text.length <= 6) {
      showToast(context, "ينبغي ان يكون كلمة المرور على الاقل 6 حروف");
      return;
    }

    try {
      changeViewState(AppViewState.busy);
      final response = await CallApi.postRequest(
          "${StaticData.baseUrl}/signleteacher/apis3.php?", {
        "function": "change_pas",
        "oldpassword": oldPaasswordController.text,
        "newpassword": newPasswordController.text,
        "token": getLoggedUser().token,
      });
      log("response change password: $response");
      if (response["status"] == "success") {
        changeViewState(AppViewState.idle);
        showToast(context!, "تم تغيير كلمة المرور بنجاح", color: Colors.blue);
        Navigator.pop(context);
      } else {
        changeViewState(AppViewState.idle);
        showToast(context!, response["error"]);
      }
    } catch (e) {
      changeViewState(AppViewState.idle);
      showToast(context!, e.toString());
    }
  }
}
