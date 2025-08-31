import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:step/app/core/constants_and_enums/static_data.dart';
import 'package:step/app/core/data/api/ApiCall.dart';
import 'package:step/app/core/data/shared_preferences/helper_funcs.dart';
import 'package:step/app/core/data/shared_preferences/shared_preferences_keys.dart';
import 'package:step/app/core/data/shared_preferences/sharedpreference_service.dart';
import 'package:step/app/modules/home/home.dart';
import 'package:step/app/utils/build_show_dialog_auth.dart';
import 'package:step/app/utils/routing_utils.dart';

class AuthService {
  AuthService._();

  static Future<void> handleNewUser(
      BuildContext context, Map<String, dynamic> response, String value) async {
    final userData = response["userData"];

    if (userData['status'] == "success") {
      await persistUserData(userData['data']);
      addDeviceToUser(userData['data']['id'].toString(), context);
      await navigateToHome(context);
    } else {
      //showSnackBar(context, 'Error in $value with Google (new register)');
      log('Error in $value with Google (new register)');
      // buildShowDialogAuth(context,
      //     message: 'Error in $value with Google (new register)');
    }
  }

  static Future<String> handleExistingUser(BuildContext context,
      Map<String, dynamic> response, String? value, String phone) async {
    final userData = response["userData"];
    log("deviceExists: ${response["deviceExists"]["status"]}");
    if (response["deviceExists"]["status"] == "success") {
      if (userData['status'] == "success") {
        await persistUserData(userData['data']);
        await navigateToHome(context);
        return 'success';
      } else {
        // buildShowDialogAuth(context,
        //     message: 'Error in $value with Google (existing user)');
        log('Error in $value with Google (existing user)');
        return 'error';
        //showSnackBar(context, 'Error in $value with Google (existing user)');
      }
    } else if (response["deviceExists"]["status"] == "error") {
      if (response["deviceExists"]["message01"] == "0") {
        addDeviceToUser(userData['data']['id'].toString(), context);
        await persistUserData(userData['data']);
        await navigateToHome(context);
        return 'success';
      } else {
        buildShowDialogAuth(context,
            message: response["deviceExists"]["status"] == "error"
                ? response["deviceExists"]["message01"] +
                    "\n" +
                    response["deviceExists"]["message02"]
                : '',
            phone: phone);
        return 'error';
        //showSnackBar(context, 'Please $value your device first');
      }
    } else {
      log('Error in $value with Google (device check)');
      return 'error';
    }
  }

  static Future<void> persistUserData(Map<String, dynamic> data) async {
    SharedPreferencesService.instance.remove(SharedPreferencesKeys.loggedUser);
    SharedPreferencesService.instance
        .setBool(SharedPreferencesKeys.userTypeIsGust, false);

    log("data : $data");
    log('Token: ${data['token']}');

    await saveToSharedPref(data);
  }

  static Future<void> navigateToHome(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 200));
    Navigator.of(context).pushAndRemoveUntil(
      routeToPage(const HomeMainParentPage()),
      (route) => false,
    );
  }

  static Future<void> addDeviceToUser(
      String userId, BuildContext context) async {
    try {
      log('StaticData.deviceId : ${StaticData.deviceId}');
      log("isLowRamDevice : ${StaticData.isLowRamDevice}");
      log("isPhysicalDevice : ${StaticData.isPhysicalDevice}");
      log("isLowRamDevice : ${StaticData.isLowRamDevice == true ? 1 : 0}");
      log("isPhysicalDevice : ${StaticData.isPhysicalDevice == true ? 1 : 0}");
      log("deviceId : ${StaticData.deviceId}");
      final respose = await CallApi.postRequest(
          '${StaticData.baseUrl}/signleteacher/apis3.php', {
        'function': 'addDeviceToUser',
        'userid': userId,
        //check this value i changed it to device id
        'device_id': StaticData.deviceId,
        'model': StaticData.model,
        'isLowRamDevice': StaticData.isLowRamDevice == true ? 1 : 0,
        'isPhysicalDevice': StaticData.isPhysicalDevice == true ? 1 : 0,
      });
      log("respose add device to user: $respose");
      log('sucess in add device ');
    } catch (e) {
      //buildShowDialogAuth(context, message: e.toString());
      log('error in add device error: $e');
      //showSnackBar(context, e.toString());
    }
  }
}
