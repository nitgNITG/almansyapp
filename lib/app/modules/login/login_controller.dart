import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:step/app/core/constants_and_enums/enums.dart';
import 'package:step/app/core/data/api/ApiCall.dart';
import 'package:step/app/core/data/shared_preferences/shared_preferences_keys.dart';
import 'package:step/app/core/data/shared_preferences/sharedpreference_service.dart';
import 'package:step/app/modules/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:step/app/utils/auth_service.dart';

import '../../core/constants_and_enums/static_data.dart';
import '../../core/data/shared_preferences/helper_funcs.dart';
import '../../utils/build_show_dialog_auth.dart';
import '../../utils/routing_utils.dart';
import '../home/home.dart';

class LoginController extends BaseController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // var isPasswordVisible = false.obs;
  var rememberMy = true;
  var email = '';
  var password = '';
  ValueNotifier<String> allRightsText = ValueNotifier("");
  String allRightsCompanyName = "";
  String allRightsYear = "";
  String allRightsCompanyNameEnglish = "";
  String allRightsLink = "";

  void login(String phone) async {
    changeViewState(AppViewState.busy);

    try {
      final respose = await CallApi.getRequest(
          "${StaticData.baseUrl}/signleteacher/apis3.php?device_id=${StaticData.deviceId}&function=login&password=${passwordController.text.toString()}&email=${emailController.text.toString()}");
      log("response login: $respose");
      if (respose["status"] == "success") {
        String userId = respose["data"]['id'].toString();
        final dio = Dio();
        final formData = FormData.fromMap({
          'Function': 'checkDeviceMatch',
          'userid': userId,
          'deviceid': StaticData.deviceId,
        });
        final result = await dio.post(
          'https://almansy.net/custom_SubSytem/apis_to_flutter/apis_of_reset_device_of_student_for_flutter/checkDeviceMatch.php',
          data: formData,
        );
        log("result : $result");
        if (result.data['status'] == "error") {
          if (result.data['message01'] == "0") {
            AuthService.addDeviceToUser(userId.toString(), context!);
            SharedPreferencesService.instance
                .setBool(SharedPreferencesKeys.userTypeIsGust, false);
            await saveToSharedPref(respose["data"]);
            changeViewState(AppViewState.idle);
            await Future.delayed(const Duration(milliseconds: 200));
            Navigator.of(context!).pushAndRemoveUntil(
              routeToPage(
                const HomeMainParentPage(),
              ),
              (c) => false,
            );
          } else {
            changeViewState(AppViewState.idle);
            //showSnackBar(context!, result.data["message"]);
            buildShowDialogAuth(context,
                message:
                    result.data["message01"] + "\n" + result.data["message02"],
                phone: phone);
          }
        } else if (result.data['status'] == "success") {
          SharedPreferencesService.instance
              .setBool(SharedPreferencesKeys.userTypeIsGust, false);
          await saveToSharedPref(respose["data"]);
          changeViewState(AppViewState.idle);
          await Future.delayed(const Duration(milliseconds: 200));
          Navigator.of(context!).pushAndRemoveUntil(
            routeToPage(
              const HomeMainParentPage(),
            ),
            (c) => false,
          );
        } else {
          changeViewState(AppViewState.idle);
          //showSnackBar(context!, result.data["message"]);
          buildShowDialogAuth(context, message: result.data["message"]);
        }
      } else {
        changeViewState(AppViewState.idle);
        //showSnackBar(context!, respose["error"]);
        buildShowDialogAuth(context, message: respose["error"]);
      }
    } catch (e) {
      changeViewState(AppViewState.idle);
      onError(e, context);
      buildShowDialogAuth(context, message: e.toString());
    }

    // (_)=>false
    // (route) => false,
  }

  // getAllRightReserverved() async {
  //   try {
  //     final response = await CallApi.getRequest(
  //         "https://step2english.com/stepapis/signleteacher/apis.php?function=property_rights");

  //     if (response["data"] != null) {
  //       allRightsText.value = (response['data'].first['text']);
  //       allRightsCompanyName = (response['data'].first['company']);
  //       allRightsYear = (response['data'].first['year']);
  //       allRightsCompanyNameEnglish = (response['data'].first['text2']);
  //       allRightsLink = (response['data'].first['link']);
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // void loginAsGuest(context) {
  //   SharedPreferencesService.instance.clear();

  //   SharedPreferencesService.instance
  //       .setBool(SharedPreferencesKeys.userTypeIsGust, true);

  //   Navigator.of(context).push(
  //     routeToPage(const HomeMainParentPage()),
  //     // (route) => false,
  //   );
  // }

  // void loginWithGoogle(context, String phone) async {
  //   try {
  //     changeViewState(AppViewState.busy);
  //     final userCredential = await AuthService.signInWithGoogle(context);
  //     final user = userCredential?.user;
  //     if (user != null) {
  //       final response = await AuthService.sendUserDataToServer(user);
  //       log("state user: ${response['state']}");
  //       log("response login with google: $response");
  //       if (response['state'] == "newRegister") {
  //         await AuthService.handleNewUser(context, response, 'login');
  //       } else if (response['state'] == "alreadyExist") {
  //         String status = await AuthService.handleExistingUser(
  //           context,
  //           response,
  //           'login',
  //           phone,
  //         );
  //         if (status == 'error') {
  //           changeViewState(AppViewState.idle);
  //         }
  //       }
  //     } else {
  //       changeViewState(AppViewState.idle);
  //       // buildShowDialogAuth(context, message: 'Error in login with Google');
  //     }
  //   } catch (e) {
  //     changeViewState(AppViewState.idle);
  //     log(e.toString());
  //   }
  // }
}
