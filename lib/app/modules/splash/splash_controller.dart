import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:step/app/modules/base/base_controller.dart';
import 'package:step/app/modules/home/home.dart';
import 'package:step/app/utils/routing_utils.dart';
import 'package:uuid/uuid.dart';
import '../../core/constants_and_enums/static_data.dart';
import '../../core/data/shared_preferences/shared_preferences_keys.dart';
import '../../core/data/shared_preferences/sharedpreference_service.dart';
import '../login/login_page.dart';

class SplashController extends BaseController {
  void navigate(context) async {
    await Future.delayed(const Duration(seconds: 1)); // ⏳ تأخير بسيط قبل التحقق
    // final isUpdateRequired =
    //     await checkForUpdate(context); // نفترض أنها ترجع true لو في تحديث
    // if (isUpdateRequired) return; // لو في تحديث، متعملش حاجة

    final connectivtyResult = await Connectivity().checkConnectivity();

    Timer(
      const Duration(seconds: 3),
      () {
        final str = SharedPreferencesService.instance
            .getString(SharedPreferencesKeys.loggedUser);

        if (str == null) {
          Navigator.of(context).pushReplacement(
            routeToPage(const LoginPage()),
          );
        } else {
          Navigator.of(context).pushReplacement(
            routeToPage(
              HomeMainParentPage(connectivityResult: connectivtyResult),
            ),
          );
        }
      },
    );
  }

  Future<void> getDeviceData() async {
    String? id =
        SharedPreferencesService.instance.getString(StaticData.kDeviceUuid);
    if (id == null) {
      id = const Uuid().v4();
      await SharedPreferencesService.instance
          .setString(StaticData.kDeviceUuid, id);
    }
    log("device id: $id");
    final deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final AndroidDeviceInfo deviceInfo = await deviceInfoPlugin.androidInfo;
      //log("id=${deviceInfo.id}");
      StaticData.deviceId = id;
      StaticData.isLowRamDevice = deviceInfo.isLowRamDevice;
      StaticData.isPhysicalDevice = deviceInfo.isPhysicalDevice;
      StaticData.model =
          "${deviceInfo.version.release.toString()} ${deviceInfo.version.sdkInt.toString()} ${deviceInfo.model.toString()} ${deviceInfo.brand.toString()}";
      log("${deviceInfo.version.release.toString()} ${deviceInfo.version.sdkInt.toString()} ${deviceInfo.model.toString()} ${deviceInfo.brand.toString()}");
      //log("deviceInfo:  $deviceInfo");
      log("deciceId: ${StaticData.deviceId}");
    } else if (Platform.isIOS) {
      //final IosDeviceInfo deviceInfo = await deviceInfoPlugin.iosInfo;
    }
    if (Platform.isWindows) {
      final WindowsDeviceInfo deviceInfo = await deviceInfoPlugin.windowsInfo;
      log("device in windows=${deviceInfo.data}");
    } else {
      log('Unsupported platform');
    }
  }
}
